# PKGBUILD test
Docker image to create a test environment to build PKGBUILD for (AUR)[https://aur.archlinux.org]

## How to Use
### Building
1. Run `make build` to build pkgbuild-test docker image

### How To Use
1. Create a Dockerfile using the `bonohub13/pkgbuild-test` image as a base
    - Example: (note: `builduser` is the default user for building PKGBUILD)
    ``` dockerfile
    FROM bonohub13/pkgbuild-test

    RUN pacman -Syu --noconfirm
    
    USER builduser
    RUN git clone https://aur.archlinux.org/aura /tmp/aura
    WORKDIR /tmp/aura
    RUN makepkg -s --noconfirm

    USER root
    # The <mount point> will be specifically defined in Makefile later
    CMD [ "mv", "/tmp/aura", "<mount point>" ]
    ```
2. Create a Makefile to make the build process easier (optional)
    - Makefile
    ``` make
    SHELL:=bash

    all: build run

    clean:
        sudo rm -rf mnt/*

    build:
        docker build . --no-cache=true \
            -t bonohub13/aura_testbuild -f Dockerfile

    # In this case, /mnt would be the <mount point> in the Dockerfile
    # defined earlier.
    run: clean
        mkdir -p mnt
        docker run --rm -it -v $(shell pwd)/mnt:/mnt \
            bonohub13/aura_buildtest
    ```
3. Run and build the PKGBUILD with `make`

Anything made during the build process would be in `mnt`
directory in this case.
