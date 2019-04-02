#!/bin/bash

dpkg-scanpackages -m debs /dev/null > Packages
bzip2 Packages
echo "[+] Packages.bzip2 created"
