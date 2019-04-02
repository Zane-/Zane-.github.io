#!/bin/bash

dpkg-scanpackages -m debs /dev/null > Packages
bzip2 -f Packages
echo "[+] Packages.bzip2 created"
