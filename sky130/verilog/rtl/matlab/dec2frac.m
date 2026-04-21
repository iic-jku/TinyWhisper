function fracstring = dec2frac(dec, Bint, Bfrac)
  %assert(abs(dec)<2^(Bint),'Input does not fit in Bint bits');
  
  signed = round(dec/2^(-Bfrac));
  
  unsiged = signed;
  if signed < 0
    unsiged = signed+2^(Bfrac+Bint);
  end
  
  fracstring = sprintf('%i',unsigned2bin(unsiged,Bfrac+Bint));
  % fracstring = [ ones(1,Bint+Bfrac+1-length(fracstring))*'0' fracstring]; % unsigned2bin crops zeros in front
  % fracstring = [fracstring(1:Bint) '.' fracstring(Bint+1:end)];
  fracstring = [fracstring(1:Bint) fracstring(Bint+1:end)];
end
