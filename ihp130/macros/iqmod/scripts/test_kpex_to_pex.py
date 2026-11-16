# SPDX-FileCopyrightText: 2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
# Description: Test the rename and substrate merge of kpex_to_pex.py with UTF-8 text I/O, run by `make regression`.

import os
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))

# A text I/O without an encoding uses the locale (cp1252 on Windows). As an error, the warning fails on every platform.
STRICT = [sys.executable, "-X", "warn_default_encoding", "-W", "error::EncodingWarning"]


def convert(text, cell):
    """The output of kpex_to_pex.py for the KPEX netlist `text`."""
    with tempfile.TemporaryDirectory() as folder:
        src, dst = os.path.join(folder, "kpex.spice"), os.path.join(folder, "pex.spice")
        with open(src, "w", encoding="utf-8") as f:
            f.write(text)
        subprocess.run(STRICT + [os.path.join(HERE, "kpex_to_pex.py"), src, dst, "--cell", cell], check=True)
        with open(dst, encoding="utf-8") as f:
            return f.read()


class KpexToPexTest(unittest.TestCase):
    def test_ports_on_continuation_line(self):
        text = (".SUBCKT cell VDD sub! A\n"
                "+ VSS\n"
                "R1 A n1 0.5\n"
                "C1 n1 sub! 1f\n"
                ".ENDS cell\n")
        self.assertEqual(convert(text, "cell"), (".SUBCKT cell_pex VDD A VSS\n"
                                                 "R1 A n1 0.5\n"
                                                 "C1 n1 VSS 1f\n"
                                                 ".ENDS cell_pex\n"))


if __name__ == "__main__":
    unittest.main()
