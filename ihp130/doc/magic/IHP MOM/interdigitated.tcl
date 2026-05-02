#------------------------------------------------------------
# Interdigitated metal capacitor for IHP SG13CMOS5L
#------------------------------------------------------------
#
# This is needed to replace MiM caps, which are not available
# in the CMOS5L variant of the IHP SG13 process.
#
# Source this script in magic to generate interdigitated caps.
#
# The output is a .mag file with the layout as specified
# by the range of metals to use and the layout width and
# height.  The procedure maximizes the amount of parasitic
# cap in the given area.  The cell is given a "device"
# property which tells magic to extract the cell as an
# ideal capacitor, which is how it appears in an output
# SPICE netlist.  The value of the capacitor is determined
# by running a parasitic extraction of the layout prior
# to setting the "device" property.
#
# To do:  Determine the mapping between layers and size
# and resulting capacitance value;  without that, to get
# a specific value of capacitance requires an iterative
# process and some guesswork.
#
#---------------------------------------------------------
# Written by R. Timothy Edwards, Open Circuit Design LLC
# March 15, 2026
#
# This file is distributed under the Apache 2.0 open source
# license.
#---------------------------------------------------------

proc make_interdigitated_cap {cname botm topm w h} {
    # cname: Name for the capacitor cell
    # botm:  Bottom metal (1 to 5)
    # topm:  Top metal (1 to 5)
    # w:     Width of capacitor layout
    # h:     Height of capacitor layout

    namespace path {::tcl::mathop ::tcl::mathfunc}

    set curunits [units]
    units microns 
    tech unlock *

    if {[cellname list exists $cname] != 0} {
	puts stderr "Cell $cname exists.  Choose another name or delete the cell.\n"
	return 1
    }
    if {[file exists ${cname}.mag]} {
	puts stderr "File ${cname}.mag exists.  Choose another name or delete the file.\n"
	return 1
    }

    load $cname -silent

    # Swap top and bottom metal layers if not in the right order
    if {$botm > $topm} {
	set tmp $botm
	set botm $topm
	set topm $tmp
    }

    # Main parameters used for calculating the layout (other than the input
    # arguments):
    # 
    # edgel:  Width of left edge.  Determined by the size of contacts.
    #		Extra width given to metal4 for the larger via4.
    # edger:  Width of right edge.  Determined by the size of contacts.
    #		via4 does not contact on this side.
    # edget:  Width of top edge.  Determined by the size of contacts.
    #		Extra width given to metal4 for the larger via4.
    # edgeb:  Width of bottom edge.  Determined by the size of contacts.
    #		via4 does not contact on this side.
    # mw:     Minimum metal width.  Fingers will be this wide.
    # ms:     Minimum metal space.  Fingers will be separated by this
    #		amount unless run-length rules require extra space.
    # msxl:    Extra spacing required to satisfy run-length rules (left side)
    # msxr:    Extra spacing required to satisfy run-length rules (right side)
    # msxt:    Extra spacing required to satisfy run-length rules (top side)
    # msxb:    Extra spacing required to satisfy run-length rules (bottom side)
    # viaw:   Width of a via contacting to the metal layer above.
    # viabe:  Minimum bottom metal enclosure of via (only applies to via1).
    # m:      The metal layer index of the current metal layer
    # m1:     The metal layer index one less than m
    # viaw1:  The via width of the via between m1 and m
    # viabe1: Minimum bottom metal enclosure of the via between m1 and m
    #		(only relevant for via1).
    # viate1: Minimum top metal enclosure of the via between m1 and m
    #		(only relevant for via4).
    #
    # General topology:
    # 1. Fingers alternate in direction between metal layers.
    # 2. The bottom-most metal layer always has vertical fingers.
    # 3. The bottom-most metal layer and every other layer above it connects
    #    on the bottom and left sides.  All other layers connect on the top
    #    and right side.
    # 4. All but the outermost fingers connect to alternating sides.
    # 5. The outermost fingers connect to the side appropriate for the via
    #    stack.  This may break the fingering pattern by being the same
    #    terminal as the finger next to it.
    # 6. If the (thick) top metal is used, then it connects only on the top
    #	 and left sides.  It keeps a regular pattern of fingers.
    # 7. If the (thick) top metal is used, then the metal 4 edges are widened
    #	 on the top and left sides to accomodate the via4 contact.

    set orient 0
    for {set m $botm} {$m <= $topm} {incr m} {
	set metal m$m
	set mw [tech drc width $metal]
	set ms [tech drc spacing $metal]
	# Extra metal space gets adjusted later as needed.
	set msxl 0.0
	set msxr 0.0
	set msxt 0.0
	set msxb 0.0
	if {$m == 1} {
	    set viabe 0.005
	} else {
	    set viabe 0
	}

	# Wide metal for run-length rule is 0.3 for m1, 0.39 for other metals.
	if {$m == 1} {
	    set widem 0.3
	} else {
	    set widem 0.39
	}

	# Values for the metal layer below the current one
	# (When m = 1 these values are not used.)

	set m1 [- $m 1]
	set viaw1 [tech drc width via3]
	if {$m == 5} {set viaw1 [tech drc width via4]}
	if {$m == 5} {
	    set viate1 0.32
	} else { 
	    set viate1 0
	}
	if {$m == 2} {
	    set viabe1 0.005
	} else {
	    set viabe1 0
	}

	# Regular pitch of fingers, not including the ends
	set pitch [+ $mw $ms]

	# For most metals, the metal width on the edge is the via size
	# Use via3 as representative (they're all the same)
	set viaw [tech drc width via3]
	if {$m == 4} {set viaw [tech drc width via4]}

	# Determine the width of edges.  For most metals this is independent
	# of orientation.
	if {$m == 1} {
	    set edgeb $mw	;# default is metal width only if no metal 2
	    if {$topm >= 2} {
		# Edge must be wide enough for a contact + metal 1 surround
		set edgeb [+ $viaw [* 2 $viabe]]
	    }
	    set edget $edgeb
	    set edger $edgeb
	    set edgel $edgeb
	} elseif {$m == 2} {
	    set edgeb $viaw	;# default is metal width only if no metal 1
	    if {$botm == 1} {
		set edgeb [+ $mw $viabe1]	;# because via1 is offset by $viabe
	    }
	    set edget $edgeb
	    set edger $edgeb
	    set edgel $edgeb
	} elseif {$m < 4} {
	    set edgeb $viaw
	    set edget $edgeb
	    set edger $edgeb
	    set edgel $edgeb
	} elseif {$m == 4} {
	    set edgeb $viaw
	    set edget $edgeb
	    set edger $edgeb
	    set edgel $edgeb
	    if {$topm == 5} {
		# via4 width + m5 surrounds via4.  Since we want everything
		# aligned to x=0, then m4 must also overlap by the same amount.
		set edgel 0.94
		set edget 0.94
	    }
	} elseif {$m == 5} {
	    set edgeb $mw
	    set edget $edgeb
	    set edger $edgeb
	    set edgel $edgeb
	}

	# Now determine how many fingers will fit in the layer's orientation.
	# If the width does not match an integer number of fingers exactly,
	# then the extra amount is added to the edges.  For metal 4 when
	# metal 5 is present, the top and left sides have wide enough metal 4
	# to trigger a run-length width rule, so incorporate the extra space.
	
	if {$orient == 0} {	;# Vertical fingers
	    set wbase [+ $edgel $edger]
            # nfxi = number of interior fingers (not counting the edges)
	    set nfxi [int [/ [- $w [+ $wbase $ms]] $pitch]]

	    # Find the remainder of area to distribute to the edges
	    set xdelta [/ [- $w [+ [* $nfxi $pitch] $ms $wbase]] 2]
	    set edgel [+ $edgel $xdelta]
	    set edger [+ $edger $xdelta]


	    # If edges are wider than $widem then reduce by 0.03
	    if {$edgel > $widem} {
		set msxl 0.03
		set edgel [- $edgel $msxl]
	    }
	    if {$edger > $widem} {
		set msxr 0.03
		set edger [- $edger $msxr]
	    }

	} else {	;# orient == 1,  Horizontal fingers
	    set hbase [+ $edget $edgeb]
            # nfyi = number of interior fingers (not counting the edges)
	    set nfyi [int [/ [- $h [+ $hbase $ms]] $pitch]]

	    # Find the remainder of area to distribute to the edges
	    set ydelta [/ [- $h [+ [* $nfyi $pitch] $ms $hbase]] 2]
	    set edget [+ $edget $ydelta]
	    set edgeb [+ $edgeb $ydelta]

	    # If edges are wider than 0.39um then reduce by 0.03
	    if {$edget > $widem} {
		set msxt 0.03
		set edget [- $edget $msxt]
	    }
	    if {$edgeb > $widem} {
		set msxb 0.03
		set edgeb [- $edgeb $msxb]
	    }
	}

	# Diagnostic:
	# puts stdout "Metal $metal"
	# puts stdout "edgel = $edgel"
	# puts stdout "edger = $edger"
	# puts stdout "edgeb = $edgeb"
	# puts stdout "edget = $edget"
	# if {$orient == 0} {
	#     puts stdout "nfxi = $nfxi"
	# } else {
	#     puts stdout "nfyi = $nfyi"
	# }

	# Paint the contacts based on the values for the metal on *top* of
	# the contact.

	if {$m > $botm} {
	    # Get the maximum value of the edge widths for both the top metal
	    # and the bottom metal of the contact.
	    set maxedgel [max $edgel $lastedgel]
	    set maxedger [max $edger $lastedger]
	    set maxedgeb [max $edgeb $lastedgeb]
	    set maxedget [max $edget $lastedget]

	    # Contact bottom side (except for via4)
	    if {$m != 5} {
		set bbox_llx [+ $maxedgel $pitch]
		set bbox_urx [- $w [+ $maxedger $pitch]]
		set bbox_lly $viabe1
		set bbox_ury [+ $bbox_lly $viaw1]
		box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
		paint via$m1
	    }

	    # Contact left side
	    set bbox_lly [+ $maxedgeb $ms]
	    set bbox_ury [- $h [+ $maxedget $pitch]]
	    set bbox_llx [+ $viabe1 $viate1]
	    set bbox_urx [+ $bbox_llx $viaw1]
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint via$m1

	    # Contact right side (except for via4)
	    if {$m != 5} {
		set bbox_lly [+ $maxedgeb $pitch]
		set bbox_ury [- $h [+ $maxedget $ms]]
		set bbox_urx [- $w $viabe1]
		set bbox_llx [- $bbox_urx $viaw1]
		box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
		paint via$m1
	    }

	    # Contact top side
	    set bbox_ury [- $h [+ $viabe1 $viate1]]
	    set bbox_lly [- $bbox_ury $viaw1]
	    set bbox_llx [+ $maxedgel $pitch]
	    set bbox_urx [- $w [+ $maxedger $ms]]
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint via$m1
	}
	
	# Now paint the fingers 
	set bbox_llx 0
	set bbox_lly 0
	set bbox_urx 0
	set bbox_ury 0

	if {$orient == 0} {	;# Vertical fingers
	    # Draw the left edge
	    set bbox_llx 0
	    set bbox_urx $edgel
	    set bbox_lly 0
	    set bbox_ury $h
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint $metal

	    # Draw the interior fingers
	    for {set x 0} {$x < $nfxi} {incr x} {
		set bbox_llx [+ [* $x $pitch] $edgel $msxl $ms]
		set bbox_urx [+ $bbox_llx $mw]
		set bbox_lly 0
		set bbox_ury $h

		box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
		if {[% $x 2] == 0} {
		    set inset [+ $edget $ms $msxt $viabe1]
		    box grow n -$inset
		} else {
		    set inset [+ $edgeb $ms $msxb $viabe1]
		    box grow s -$inset
		}
		paint $metal
	    }

	    # Draw the right edge
	    set bbox_llx [+ [* $nfxi $pitch] $edgel $msxl $msxr $ms]
	    set bbox_urx $w	;# should = $bbox_llx + $edger
	    set bbox_lly 0
	    set bbox_ury $h
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint $metal

	    # Draw the bottom edge
	    set bbox_llx 0
	    set bbox_lly 0
	    set bbox_ury $edgeb
	    set bbox_urx [- $w [+ $edger $ms $msxr]]
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint $metal

	    # Draw the top edge
	    set bbox_llx [+ $edgel $ms $msxl]
	    set bbox_lly [- $h $edget]
	    set bbox_ury $h
	    set bbox_urx $w
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint $metal

	} else {	;# orient == 1;  Horizontal fingers
	    # Draw the bottom edge
	    set bbox_llx 0
	    set bbox_urx $w
	    set bbox_lly 0
	    set bbox_ury $edgeb
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint $metal

	    # Draw the interior fingers
	    for {set y 0} {$y < $nfyi} {incr y} {
		set bbox_llx 0
		set bbox_urx $w
		set bbox_lly [+ [* $y $pitch] $edgeb $ms $msxb]
		set bbox_ury [+ $bbox_lly $mw]

		box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
		if {[% $y 2] == 0} {
		    set inset [+ $edgel $ms $msxl $viabe1]
		    box grow w -$inset
		} else {
		    set inset [+ $edger $ms $msxr $viabe1]
		    box grow e -$inset
		}
		paint $metal
	    }

	    # Draw the top edge
	    set bbox_llx 0
	    set bbox_urx $w
	    set bbox_lly [+ [* $nfyi $pitch] $edgeb $ms $msxb $msxt]
	    set bbox_ury $h	;# should = $bbox_lly + $edget
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint $metal

	    # Draw the left edge
	    set bbox_llx 0
	    set bbox_lly 0
	    set bbox_urx $edgel
	    set bbox_ury [- $h [+ $edget $ms $msxt]]
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint $metal

	    # Draw the right edge
	    set bbox_llx [- $w $edger]
	    set bbox_lly [+ $edgeb $ms $msxb]
	    set bbox_urx $w
	    set bbox_ury $h
	    box values $bbox_llx $bbox_lly $bbox_urx $bbox_ury
	    paint $metal
	}

	# Save the edge sizes for proper placement of contacts on the
	# next loop.
	set lastedgel $edgel
	set lastedger $edger
	set lastedget $edget
	set lastedgeb $edgeb

	set orient [- 1 $orient]
    }

    # Final touches:
    # 1. Paint pwell ring around the device.
    # 2. Paint PWELLBLK under the device to minimize parasitic cap to
    #    the substrate.
    # 3. Mark this area as the device area
    # 4. Create ports and labels
    #
    # The pwell ring is 0.31um larger than the PWELLBLK so that abutting
    # devices leaves sufficient space between PWELLBLK areas.

    box values 0 0 $w $h
    box grow c 0.31
    paint pwell
    property FIXED_BBOX [box values]
    box grow c -0.31
    paint pblock

    # On the bottom pwell, make a "sub!" substrate connection pin
    box position [/ $w 2] -0.155
    box size 0 0
    label sub! c pwell
    port make

    # On the top metal, make labels for terminals c1 (left) and c2 (top)
    box position 0.01 [/ $h 2]
    label c1 c m$topm
    port make
    box position [/ $w 2] [- $h 0.01]
    label c2 c m$topm
    port make

    # Extract the layout parasitic
    extract do local
    extract all

    # Read the SPICE subcircuit and get the capacitor value
    set capvalaF 0
    set f [open ${cname}.ext]
    while {true} {
	gets $f line
	if {[eof $f]} {
	    break
	}
	if {[string first cap $line 0] == 0} {
	    set llist [split $line]
	    set capvalaF [lindex $llist 3]
	    break
	}
    }
    close $f

    # Value of the device in the .ext file should be in fF, as opposed to
    # the parasitic value in aF, so convert from aF to fF.
    set value [* $capvalaF 1.0e-3]
   
    # The extraction file is no longer needed
    file delete ${cname}.ext

    # Set a property on this cell so that the entire cell extracts as an
    # ideal (unmodeled) capacitor component.  Note that handling the
    # capacitor this way loses the parasitic to substrate.

    if {$value != 0} {
	set propstr [format "devcap None 0 0 1 1 %.4f c1 0 0 c2 0 0" $value]
	property string device $propstr
    }

    # Restore units used prior to calling this procedure
    units {*}$curunits
    tech revert

    # Save the layout
    writeall force $cname

    if {$value != 0} {
	set resultstr [format "This capacitor has value %.4ffF" $value]
	puts stdout $resultstr
    } else {
	puts stderr "Error:  Unable to extract a value from the layout."
    }
    flush stdout
    puts stdout "Done!\n"
    return 0
}
