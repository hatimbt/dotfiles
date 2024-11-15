# profiles.mk provides guix version specified by rde/channels-lock.scm
# To rebuild channels-lock.scm use `make -B rde/channels-lock.scm`
include profiles.mk

# Also defined in .envrc to make proper guix version available project-wide
GUIX_PROFILE=target/profiles/guix
GUIX=GUILE_LOAD_PATH="~/src/guile/rde/src::./src" GUILE_LOAD_COMPILED_PATH="" ${GUIX_PROFILE}/bin/guix

SRC_DIR=./src
CONFIGS=${SRC_DIR}/rde-configs/configs.scm
PULL_EXTRA_OPTIONS=
# --allow-downgrades

HOSTNAME	:=	$(shell cat /etc/hostname)

ROOT_MOUNT_POINT=/mnt

VERSION=latest

repl: ares

grepl:
	${GUIX} repl

ares:
	${GUIX} shell guile-next guile-ares-rs \
	-e '(@ (rde packages package-management) guix-from-channels-lock)' \
	-- guile \
	-L ~/src/dotfiles/src \
	-L ~/src/guile/rde/src \
	-L ~/src/guile/nonguix \
	-L ~/src/guile/guile-ares-rs/src \
	-c \
"(begin (use-modules (guix gexp)) #;(load gexp reader macro globally) \
((@ (ares server) run-nrepl-server) #:port 7888))"

host/home/build: guix
	RDE_TARGET=${HOSTNAME}-home ${GUIX} home \
	build ${CONFIGS}

host/home/container: guix
	RDE_TARGET=${HOSTNAME}-home ${GUIX} home \
	container ${CONFIGS}

host/home/reconfigure: guix
	RDE_TARGET=${HOSTNAME}-home ${GUIX} home \
	reconfigure ${CONFIGS}

host/system/build: guix
	RDE_TARGET=${HOSTNAME}-system ${GUIX} system \
	build ${CONFIGS}

host/system/reconfigure: guix
	RDE_TARGET=${HOSTNAME}-system ${GUIX} system \
	reconfigure ${CONFIGS}

host/system/vm: guix
	RDE_TARGET=${HOSTNAME}-system ${GUIX} system \
	vm ${CONFIGS}

cow-store:
	sudo herd start cow-store ${ROOT_MOUNT_POINT}

host/system/init: guix
	RDE_TARGET=${HOSTNAME}-system ${GUIX} system \
	init ${CONFIGS} ${ROOT_MOUNT_POINT}

target:
	mkdir -p target

live/image/build: guix
	RDE_TARGET=live-system ${GUIX} system image --image-type=iso9660 \
	${CONFIGS}

target/rde-live.iso: guix target
	RDE_TARGET=live-system ${GUIX} system image --image-type=iso9660 \
	${CONFIGS} -r target/rde-live-tmp.iso
	mv -f target/rde-live-tmp.iso target/rde-live.iso

target/release:
	mkdir -p target/release

# TODO: Prevent is rebuilds.
release/rde-live-x86_64: target/rde-live.iso target/release
	cp -df $< target/release/rde-live-${VERSION}-x86_64.iso
	gpg -ab target/release/rde-live-${VERSION}-x86_64.iso

minimal-emacs: guix
	${GUIX} shell --pure -Df ./src/rde-configs/minimal-emacs.scm \
	-E '.*GTK.*|.*XDG.*|.*DISPLAY.*' \
	--rebuild-cache -- emacs -q \
	--eval "(load \"~/.config/emacs/early-init.el\")"
	#--eval "(require 'feature-loader-portable)"

minimal/home/build: guix
	${GUIX} home build ./src/rde-configs/minimal.scm

minimal/home/build/ci:
	guix time-machine -C rde/channels-ci.scm -- \
	home build ./src/rde-configs/minimal.scm

minimal/home/build/ci-no-auth:
	guix time-machine -C rde/channels-ci.scm --disable-authentication -- \
	home build ./src/rde-configs/minimal.scm

clean-target:
	rm -rf ./target

clean: clean-target
