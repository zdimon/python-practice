#!/bin/bash
dt=`date '+%d/%m/%Y_%H:%M:%S'`
git add --all
git commit -m "commit at $dt"
echo "commit at $dt"
