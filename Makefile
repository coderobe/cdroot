all: setup build/rootfs build/rootfs/bin/proot

setup:
	mkdir -p build
	mkdir -p working

build/rootfs/bin/proot:
	(cd PRoot/src; make)
	cp PRoot/src/proot build/rootfs/bin/proot

build/rootfs:
	./scripts/download-airootfs.sh
	./scripts/unpack-airootfs.sh
	echo "nameserver 8.8.8.8" > build/rootfs/etc/resolv.conf
	./scripts/setup.sh

clean-proot:
	(cd PRoot/src; make clean)

clean-working:
	rm -rf working

clean: clean-proot clean-working
	sudo rm -rf build
