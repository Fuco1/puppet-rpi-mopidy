PWD=$(shell pwd)

.phony: all

all:
	librarian-puppet install
	puppet apply --modulepath=$(PWD)/local-modules:$(PWD)/modules:/usr/share/puppet/modules manifests/site.pp
