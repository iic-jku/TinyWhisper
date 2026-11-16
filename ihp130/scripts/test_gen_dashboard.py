# SPDX-FileCopyrightText: 2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
# Description: Test that gen_dashboard.py builds the dashboard with UTF-8 text I/O, run by `make regression`.

import os
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))

# A text I/O without an encoding uses the locale (cp1252 on Windows). As an error, the warning fails on every platform.
STRICT = [sys.executable, "-X", "warn_default_encoding", "-W", "error::EncodingWarning"]


class DashboardTest(unittest.TestCase):
    def test_utf8_io(self):
        with tempfile.TemporaryDirectory() as folder:
            out = os.path.join(folder, "dashboard.html")
            subprocess.run(STRICT + [os.path.join(HERE, "gen_dashboard.py"), "--out", out], check=True)
            with open(out, encoding="utf-8") as f:
                html = f.read()
        self.assertNotIn("__DATA__", html)
        self.assertIn("Ω", html)


if __name__ == "__main__":
    unittest.main()
