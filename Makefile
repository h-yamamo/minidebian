DEBARCH != dpkg --print-architecture
DATETIME != date +%Y%m%d.%H%M

_build:
	rm -rf w[012] xtract; ./main.sh 2>&1 | tee $(DATETIME).log

prepare_package: pkg.reconf/.b
	grep -h -E '^[0-9a-z]' data/package-list data/package-list.$(DEBARCH) \
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
	echo "1" > $@
	grep -A 1 "^Package: whiptail$$" /var/lib/dpkg/status \
	 | grep -q "^Status: install ok " \
	 || echo "" > $@

.PHONY: _build prepare_package
