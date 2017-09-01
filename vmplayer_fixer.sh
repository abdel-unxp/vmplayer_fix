#!/bin/bash

# fix vmplayer not working on fedora release 26


VMDIR=/usr/lib/vmware/modules/source
if [ ! -d "$VMDIR" ]; then
	echo "this patch only work if vmware is installed but not working."
	exit 0
fi

pushd .
cd /tmp
cp ${VMDIR}/vmmon.tar .
cp ${VMDIR}/vmnet.tar .

tar -xvf vmmon.tar
tar -xvf vmnet.tar
cd vmmon-only
make
cd ..
cd vmnet-only
make
cd ..
LIBDIR="/lib/modules/`uname -r`/misc"
sudo mkdir ${LIBDIR}
sudo cp vmmon-only/vmmon.ko ${LIBDIR}/
sudo cp vmnet-only/vmnet.ko ${LIBDIR}/
sudo depmod -a
popd
