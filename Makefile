ifeq ($(shell uname -s),Darwin)
  libyubikey_prefix := $(shell brew --prefix libyubikey)
  CPPFLAGS += -I$(libyubikey_prefix)/include
  LDFLAGS += -L$(libyubikey_prefix)/lib
endif

CFLAGS ?= -O2 -g -Wall -Wextra
LDLIBS += -lyubikey

all: yksoft

yksoft: yksoft.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

.PHONY: test
test: yksoft
	sh tests/smoke.sh

.PHONY: clean
clean:
	@rm -f yksoft

#
#	Build a debian package
#
.PHONY: deb
deb:
	@if ! which fakeroot > /dev/null; then \
		if ! which apt-get > /dev/null; then \
		  echo "'make deb' only works on debian systems" ; \
		  exit 1; \
		fi ; \
		echo "Please run 'apt-get install build-essential' "; \
		exit 1; \
	fi
	fakeroot debian/rules debian/control #clean
	fakeroot dpkg-buildpackage -b -uc
