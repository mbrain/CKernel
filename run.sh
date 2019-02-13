#assemble boot.s 
as --32 boot.s -o boot.o

#compile kernel.c 
gcc -m32 -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

#linking the kernel
ld -m elf_i386 -T linker.ld kernel.o boot.o -o MyOS.bin -nostdlib

#check x86 multiboot
grub-file --is-x86-multiboot MyOS.bin

#building iso
mkdir -p isodir/boot/grub
cp MyOS.bin isodir/boot/MyOS.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o MyOS.iso isodir

#run in qemu
qemu-system-x86_64 -cdrom MyOS.iso
