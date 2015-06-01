#!/bin/bash
#git@github.com:zdimon/python-practice.git
gitpath=$1
dir='./python-practice' 
if [ -n "$gitpath" ]
    then
        if [ -d "$dir" ]; then
                cd "$dir"
                git pull
                ./run.sh 
            else
                echo "Cloning from $gitpath"
                git clone "$gitpath"
                cd "$dir"
                ./run.sh            
        fi  
    else
        if [ -d "$dir" ]; then
                cd "$dir"
                git pull   
                ./run.sh         
        fi 
fi
