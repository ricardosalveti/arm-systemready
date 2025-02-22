# Copyright (c) 2022-2023, ARM Limited and Contributors. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# Neither the name of ARM nor the names of its contributors may be used
# to endorse or promote products derived from this software without specific
# prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

echo -off

for %i in 0 1 2 3 4 5 6 7 8 9 A B C D E F then
    if exist FS%i:\EFI\BOOT\bbr\sie_SctStartup.nsh then
        FS%i:\EFI\BOOT\bbr\sie_SctStartup.nsh
        for %k in 0 1 2 3 4 5 6 7 8 9 A B C D E F then
            if  exist FS%k:\acs_results\SIE\sct_results\ then
                if  exist FS%i:\EFI\BOOT\bbr\SCT\Overall then
                    cp -r FS%i:\EFI\BOOT\bbr\SCT\Overall FS%k:\acs_results\SIE\sct_results\
                endif
                if  exist FS%i:\EFI\BOOT\bbr\SCT\Dependency\EfiCompliantBBTest then
                    cp -r FS%i:\EFI\BOOT\bbr\SCT\Dependency\EfiCompliantBBTest FS%k:\acs_results\SIE\sct_results\
                endif
                if  exist FS%i:\EFI\BOOT\bbr\SCT\Sequence then
                    cp -r FS%i:\EFI\BOOT\bbr\SCT\Sequence FS%k:\acs_results\SIE\sct_results\
                endif
            endif
        endfor
        for %l in 0 1 2 3 4 5 6 7 8 9 A B C D E F then
            if exist FS%l:\Image and exist FS%l:\ramdisk-buildroot.img then
                FS%l:
                cd FS%l:\
                Image initrd=\ramdisk-buildroot.img systemd.log_target=null plymouth.ignore-serial-consoles debug crashkernel=512M,high log_buf_len=1M efi=debug acpi=on crashkernel=256M earlycon uefi_debug
            endif
            if exist FS%l:\Image and exist FS%l:\ramdisk-busybox.img then
                FS%l:
                cd FS%l:\
                Image initrd=\ramdisk-busybox.img systemd.log_target=null plymouth.ignore-serial-consoles debug crashkernel=512M,high log_buf_len=1M efi=debug acpi=on crashkernel=256M earlycon uefi_debug
            endif
            if exist FS%l:\Image and exist FS%l:\yocto_image.flag then
                FS%l:
                cd FS%l:\
                Image LABEL=Boot root=partuid rootfstype=ext4
            endif
        endfor
    endif
endfor

