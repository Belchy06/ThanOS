ORG ?= docker.io/belchy06
ARCH := $(shell uname -m)
FORMAT := dynamic-vhd

GIT_VERSION ?= $(shell git log -1 --format="%h")
ifneq ($(shell git status --porcelain),)
  GIT_VERSION := $(GIT_VERSION)-dirty
endif
default: dev clean

LINUXKIT_CONFIG ?= thanos.yaml

dev: dev-thanos-dockerBuild
ifeq ($(ARCH),x86_64)
dev: image-amd64
endif

# This option is for running docker manifest command
export DOCKER_CLI_EXPERIMENTAL := enabled

image-amd64:
	mkdir out
	linuxkit build -docker -format $(FORMAT) -name thanos-x86_64 -dir out $(LINUXKIT_CONFIG)


dev-thanos-dockerBuild:
	cd thanos-docker; docker buildx build --load -t $(ORG)/thanos-docker:0.0 .; docker push $(ORG)/thanos-docker:0.0 



dev-dist: dev dev-convert
	rm -rf ./dist ./convert
	mkdir ./dist
	# mv ./initramfs-${ARCH}.gz ./dist/initramfs-${ARCH}
	# mv ./out/thanos-${ARCH}-kernel ./dist/vmlinuz-${ARCH}
	# rm -rf out
	# cd ./dist && tar -czvf ../thanos-${GIT_VERSION}.tar.gz ./*


.PHONY: clean
clean:
	cp ./out/* ./
	rm -rf out
