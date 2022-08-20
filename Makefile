SHELL := bash

all: build

build:
	docker build . -t bonohub13/pkgbuild-buildenv -f Dockerfile
