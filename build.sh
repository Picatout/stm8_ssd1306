#!/bin/bash 

# usage:
# ./build.sh mcu  [flash]
# mcu is s103,s207,s208 
# flash after build 

if [ $1 == "s207" ]; then
    if [ ! -d "build/$1" ] 
    then 
        mkdir "build/$1"
    fi 
    if [[ ! -z $2 && ($2 == "flash") ]]; then 
        make -fstm8s207.mk && make -fstm8s207.mk flash 
    else 
        make -fstm8s207.mk
    fi 
elif [ $1 == "s208" ]; then 
    if [ ! -d "build/$1" ] 
    then 
        mkdir "build/$1"
    fi 
    if [[ ! -z $2 && ($2 == "flash") ]]; then 
        make -fstm8s208kb.mk && make -fstm8s208kb.mk flash 
    else 
        make -fstm8s208kb.mk
    fi 
elif [ $1 == "s103" ]; then 
    if [ ! -d "build/$1" ] 
    then 
        mkdir "build/$1"
    fi 
    if [[ ! -z $2 && ($2 == "flash") ]]; then 
        make -fstm8s103.mk && make -fstm8s103.mk flash 
    else 
        make -fstm8s103.mk
    fi 
fi



