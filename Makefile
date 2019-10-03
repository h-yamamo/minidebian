DEBARCH != dpkg --print-architecture
DATETIME != date +%Y%m%d.%H%M

_build:
        rm -rf w[012] xtract; ./main.sh 2>&1 | tee $(DATETIME).log

.PHONY : _build

prepare_package:
        grep -h -E '^[0-9a-z]' data/package-list data/package-list.$(DEBARCH) \
	| xargs apt-get --no-install-recommends -y install

.PHONY : prepare_package
