DEBARCH != dpkg --print-architecture
DATETIME != date +%Y%m%d.%H%M

ifeq ("$(MACHINE)","kvm")
	M_SUF := .kvm
endif

_build:
	rm -rf w[012] xtract
	MINIDEB_MTYPE=$(MACHINE) ./main.sh 2>&1 | tee $(DATETIME).log

prepare_package: pkg.reconf/.b
	grep -h -E '^[0-9a-z]' data/package-list$(M_SUF) \
			data/package-list.$(DEBARCH)$(M_SUF) \
	 | DEBIAN_FRONTEND=noninteractive xargs apt-get -y \
	 -o "Dpkg::Options::=--force-confold" --no-install-recommends install
	./reconf-package once

pkg.reconf/.b:
	mkdir pkg.reconf
	grep -A 1 "^Package: keyboard-configuration$$" /var/lib/dpkg/status \
	 | grep -q "^Status: install ok " \
	 || touch pkg.reconf/keyboard
	grep -A 1 "^Package: console-setup$$" /var/lib/dpkg/status \
	 | grep -q "^Status: install ok " \
	 || touch pkg.reconf/console
	grep -A 1 "^Package: tzdata$$" /var/lib/dpkg/status \
	 | grep -q "^Status: install ok " \
	 || touch pkg.reconf/tz
	touch $@

.PHONY: _build prepare_package
