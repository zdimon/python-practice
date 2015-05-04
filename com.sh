#!/bin/bash
comment=$1
dt=`date '+%d/%m/%Y_%H:%M:%S'`
git add --all
if [ -n "$comment" ]
    then
        git commit -m "$comment"
    else
        git commit -m "commit at $dt"
fi
git push   
