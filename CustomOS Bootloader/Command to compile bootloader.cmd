gcc -shared -nostdlib -mno-red-zone -fno-builtin -Wl,-e,efi_main -Wl,--subsystem,10 -mabi=ms -D__X86_64__ -o bootx64.efi bootloader.c
