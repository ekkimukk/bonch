# Используем официальный образ Ubuntu в качестве базового
FROM ubuntu:latest

# Устанавливаем необходимые пакеты
RUN apt-get update && \
    apt-get install -y sudo systemd systemd-sysv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Отключаем systemd-logind (он не нужен в контейнере)
RUN mkdir -p /etc/systemd/system/container-getty@1.service.d && \
    echo "[Service]\nExecStart=\nExecStart=-/sbin/agetty --noclear -o '-p -- \\u' --keep-baud console 115200,38400,9600 vt220" > /etc/systemd/system/container-getty@1.service.d/override.conf

# Копируем Bash-скрипт для сервиса
COPY script.sh /usr/local/bin/user_management.sh
RUN chmod +x /usr/local/bin/user_management.sh

# Копируем systemd unit файл
COPY user_management.service /etc/systemd/system/user_management.service

# Включаем сервис при запуске контейнера
RUN systemctl enable user_management.service

# Отключаем systemd-юнит, мешающий контейнеру
RUN systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount systemd-remount-fs.service

# Устанавливаем рабочую директорию
WORKDIR /root

# Указываем точки монтирования для systemd
VOLUME ["/sys/fs/cgroup"]

# Устанавливаем точку входа для запуска systemd
CMD ["/lib/systemd/systemd"]

