FROM archlinux

RUN pacman -Syu --noconfirm \
    base \
    base-devel \
    git
RUN useradd -m builduser
RUN usermod -aG wheel builduser
RUN echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
