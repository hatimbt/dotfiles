CONFIG_FILE = ./config.scm
HOSTNAME	:=	$(shell cat /etc/hostname)
NPROCS		:=	$(shell grep -c ^processor /proc/cpuinfo)
GLP			:=  ./src

hb:
	TARGET=${HOSTNAME}-home \
			guix time-machine -C rde/channels-lock.scm -- \
			home build \
			--load-path=$(GLP) --cores=$(NPROCS) $(CONFIG_FILE)

sb:
	TARGET=${HOSTNAME}-system \
			guix time-machine -C rde/channels-lock.scm -- \
			system build \
			--load-path=$(GLP) --cores=$(NPROCS) $(CONFIG_FILE)

hbl:
	TARGET=${HOSTNAME}-home \
			guix time-machine -C rde/channels-local-lock.scm -- \
			home build \
			--load-path=$(GLP) --cores=$(NPROCS) $(CONFIG_FILE)

hcl:
	TARGET=${HOSTNAME}-home \
			guix time-machine -C rde/channels-local-lock.scm -- \
			home container \
			--load-path=$(GLP) --cores=$(NPROCS) $(CONFIG_FILE)
			
sbl:
	TARGET=${HOSTNAME}-system \
			guix time-machine -C rde/channels-local-lock.scm -- \
			system build \
			--load-path=$(GLP) --cores=$(NPROCS) $(CONFIG_FILE)

hr:
	TARGET=${HOSTNAME}-home \
			guix time-machine -C rde/channels-lock.scm -- \
			home reconfigure \
			--load-path=$(GLP) --cores=$(NPROCS) $(CONFIG_FILE)

sr:
	TARGET=${HOSTNAME}-system \
			sudo -E guix time-machine -C rde/channels-lock.scm -- \
			system reconfigure \
			--load-path=$(GLP) --cores=$(NPROCS) $(CONFIG_FILE)

hrl:
	TARGET=${HOSTNAME}-home \
			guix time-machine -C rde/channels-local-lock.scm -- \
			home reconfigure \
			--load-path=$(GLP) --cores=$(NPROCS) $(CONFIG_FILE)

srl:
	TARGET=${HOSTNAME}-system \
			sudo -E guix time-machine -C rde/channels-local-lock.scm -- \
			system reconfigure \
			--load-path=$(GLP) --cores=$(NPROCS) $(CONFIG_FILE)

cp:
	guix pull -C rde/channels-lock.scm

culock:
	guix time-machine -C rde/channels.scm -- \
	describe -f channels > rde/channels-lock.scm

clp:
	guix pull -C rde/channels-local-lock.scm

clulock:
	guix time-machine -C rde/channels-local.scm -- \
	describe -f channels > rde/channels-local-lock.scm
