#!/bin/bash
nasm -f elf64 printftest.asm
gcc -no-pie printftest.o -o printftest
