FROM ubuntu:20.04

# タイムゾーン設定
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y tzdata
ENV TZ=Asia/Tokyo

# 諸々取得
RUN apt update && apt install -y \
    binutils \
    build-essential \
    golang \
    sysstat \
    python3-matplotlib \
    python3-pil \
    fonts-takao \
    fio \
    qemu-kvm \
    virt-manager \
    libvirt-clients \
    virtinst \
    jq \
    docker.io \
    containerd \
    libvirt-daemon-system \
    zsh \
    strace \
    psmisc \
 && adduser `id -un` libvirt \
 && adduser `id -un` libvirt-qemu \
 && adduser `id -un` kvm

# 個人ユーザ作成
RUN apt update && apt install -y sudo
RUN useradd -m -s $(which bash) atabata
RUN echo 'atabata:pass' | chpasswd
RUN gpasswd -a atabata sudo

# sshするための設定
RUN apt install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]