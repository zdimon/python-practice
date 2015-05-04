#!/bin/bash
comment=$1
dt=`date '+%d/%m/%Y_%H:%M:%S'`
git add --all
if [ -n "$comment" ]
    then
        git commit -m "commit at $dt"
    else
        git commit -m "$comment"
fi
git push  
