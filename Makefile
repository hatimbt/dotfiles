CONFIG_FILE = ./config.scm
HOSTNAME	:=	$(shell cat /etc/hostname)
NPROCS		:=	$(shell grep -c ^processor /proc/cpuinfo)

hb:
	GUILE_LOAD_PATH=$(GLP) TARGET=${HOSTNAME}-home \
			guix time-machine -C guix/channels-lock.scm -- \
			home build --cores=$(NPROCS) $(CONFIG_FILE)


sb:
	GUILE_LOAD_PATH=$(GLP) TARGET=${HOSTNAME}-system \
			guix time-machine -C guix/channels-lock.scm -- \
			system build --cores=$(NPROCS) $(CONFIG_FILE)

hbl:
	GUILE_LOAD_PATH=$(GLP) TARGET=${HOSTNAME}-home \
			guix time-machine -C guix/channels-local-lock.scm -- \
			home build --cores=$(NPROCS) $(CONFIG_FILE)


sbl:
	GUILE_LOAD_PATH=$(GLP) TARGET=${HOSTNAME}-system \
			guix time-machine -C guix/channels-local-lock.scm -- \
			system build --cores=$(NPROCS) $(CONFIG_FILE)

hr:
	GUILE_LOAD_PATH=$(GLP) TARGET=${HOSTNAME}-home \
			guix time-machine -C guix/channels-lock.scm -- \
			home reconfigure --cores=$(NPROCS) $(CONFIG_FILE)

sr:
	GUILE_LOAD_PATH=$(GLP) TARGET=${HOSTNAME}-system \
			sudo -E guix time-machine -C guix/channels-lock.scm -- \
			system reconfigure --cores=$(NPROCS) $(CONFIG_FILE)

hrl:
	GUILE_LOAD_PATH=$(GLP) TARGET=${HOSTNAME}-home \
			guix time-machine -C guix/channels-local-lock.scm -- \
			home reconfigure --cores=$(NPROCS) $(CONFIG_FILE)

srl:
	GUILE_LOAD_PATH=$(GLP) TARGET=${HOSTNAME}-system \
			sudo -E guix time-machine -C guix/channels-local-lock.scm -- \
			system reconfigure --cores=$(NPROCS) $(CONFIG_FILE)

cp:
	guix pull -C guix/channels-lock.scm

culock:
	guix time-machine -C guix/channels.scm -- \
	describe -f channels > guix/channels-lock.scm

clp:
	guix pull -C guix/channels-local-lock.scm

clulock:
	guix time-machine -C guix/channels-local.scm -- \
	describe -f channels > guix/channels-local-lock.scm
