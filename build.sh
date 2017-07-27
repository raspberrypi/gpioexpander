#!/bin/sh

BUILDROOT=buildroot-2017.02


if [ ! -e $BUILDROOT ]; then
    tar xzf $BUILDROOT.tar.gz
fi

if [ ! -e $BUILDROOT/.config ]; then
    make -C $BUILDROOT BR2_EXTERNAL="$PWD/gpioexpand" gpioexpand_defconfig
fi

make -C $BUILDROOT BR2_EXTERNAL="$PWD/gpioexpand"

cp $BUILDROOT/output/images/rootfs.cpio.gz output/gpioexpand.img
cp $BUILDROOT/output/images/zImage output/kernel.img
cp $BUILDROOT/output/images/rpi-firmware/*.elf output
cp $BUILDROOT/output/images/rpi-firmware/*.dat output
cp $BUILDROOT/output/images/rpi-firmware/bootcode.bin output
cp $BUILDROOT/output/images/*.dtb output
mkdir -p output/overlays
mv output/dwc2-overlay.dtb output/overlays/dwc2.dtbo

echo
echo Build complete. Files are in output folder.
echo
