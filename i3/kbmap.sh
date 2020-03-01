#!/bin/bash

(setxkbmap -query | grep -q 'layout:\s\+us') && setxkbmap hu || setxkbmap us