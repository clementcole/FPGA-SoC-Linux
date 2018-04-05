### Build U-boot for ZYBO Z7

There are two ways

1. run scripts/build-u-boot-2017.11-zynq-zybo-z7.sh (easy)
2. run this chapter step-by-step (annoying)

#### Download U-boot Source

##### Clone from git.denx.de/u-boot.git

```console
shell$ git clone git://git.denx.de/u-boot.git u-boot-2017.11-zynq-zybo-z7
```

##### Checkout v2017.11

```console
shell$ cd u-boot-2017.11-zynq-zybo-z7
shell$ git checkout -b u-boot-2017.11-zynq-zybo refs/tags/v2017.11
```

#### Patch for zynq-zybo

```console
shell$ patch -p1 < ../files/u-boot-2017.11-zynq-zybo-z7.diff
shell$ git add --update
shell$ git add arch/arm/dts/zynq-zybo-z7.dts
shell$ git add board/xilinx/zynq/zynq-zybo-z7/*
shell$ git add configs/zynq_zybo_z7_defconfig
shell$ git add include/configs/zynq_zybo_z7.h
shell$ git commit -m "patch for zynq-zybo-z7"
shell$ git tag -a 2017.11-1 -m "Release 2017.11-1"
```

#### Setup for Build 

```console
shell$ cd u-boot-2017.11-zynq-zybo-z7
shell$ export ARCH=arm
shell$ export CROSS_COMPILE=arm-linux-gnueabihf-
shell$ make zynq_zybo_z7_defconfig
```

#### Build u-boot

```console
shell$ make
```

#### Copy boot.bin and u-boot.img to target/zybo-zynq/boot/

```console
shell$ cp spl/boot.bin  ../target/zynq-zybo-z7/boot/
shell$ cp u-boot.img    ../target/zynq-zybo-z7/boot/
```

