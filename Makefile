SHELL := bash

all: build run

build:
	docker build . -t bonohub13/pkgbuild-buildenv -f Dockerfile

run:
	docker run --rm -it bonohub13/pkgbuild-buildenv
