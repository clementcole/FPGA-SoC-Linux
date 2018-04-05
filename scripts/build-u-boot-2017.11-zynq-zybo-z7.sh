#!/bin/bash

UBOOT_BUILD_DIR=u-boot-2017.11-zynq-zybo-z7

### Download U-Boot Source
git clone git://git.denx.de/u-boot.git $UBOOT_BUILD_DIR
cd $UBOOT_BUILD_DIR

#### CHeckout v2017.11
git checkout -b u-boot-2017.11-zynq-zybo-z7 refs/tags/v2017.11

### Patch for zynq-zybo-z7

patch -p1 < ../files/u-boot-2017.11-zynq-zybo-z7.diff
git add --update
git add arch/arm/dts/zynq-zybo-z7.dts
git add board/xilinx/zynq/zynq-zybo-z7/*
git add configs/zynq_zybo_z7_defconfig
git add include/configs/zynq_zybo_z7.h
git commit -m "patch for zynq-zybo-z7"
git tag -a 2017.11-zynq-zybo-z7 -m "Release 2017.11 for zynq-zybo-z7"

### Setup for Build 

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
make zynq_zybo_z7_defconfig

### Build u-boot

make

### Copy boot.bin and u-boot.img to zynq-zybo-z7/boot/

cp spl/boot.bin  ../target/zynq-zybo-z7/boot/
cp u-boot.img    ../target/zynq-zybo-z7/boot/

cd ..
