#!/bin/bash

UBOOT_BUILD_DIR=u-boot-2016.03-zynq-pynqz1

### Download U-Boot Source
git clone git://git.denx.de/u-boot.git $UBOOT_BUILD_DIR
cd $UBOOT_BUILD_DIR

#### Checkout v2016.03
git checkout -b v2016.03-zynq-pynqz1 refs/tags/v2016.03

### Patch for PYNQ-Z1

patch -p0 < ../files/u-boot-2016.03-zynq-pynqz1.diff
git add --update
git add arch/arm/dts/zynq-pynqz1.dts
git add board/xilinx/zynq/pynqz1_hw_platform/*
git add configs/zynq_pynqz1_defconfig
git add include/configs/zynq_pynqz1.h
git commit -m "patch for zynq-pynqz1"
git tag -a v2016.03-zynq-pynqz1-1 -m "Release v2016.03-1 for PYNQ-Z1"

### Setup for Build 

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
make zynq_pynqz1_defconfig

### Build u-boot

make

### Copy boot.bin and u-boot.img to zynq-pynqz1/boot/

cp spl/boot.bin  ../target/zynq-pynqz1/boot/
cp u-boot.img    ../target/zynq-pynqz1/boot/

cd ..
