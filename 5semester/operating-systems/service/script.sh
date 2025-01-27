#!/bin/bash

# Функция для добавления нового пользователя
add_user() {
    local username=$1
    sudo useradd -m "$username" && echo "Пользователь $username добавлен успешно."
}

# Функция для удаления пользователя
remove_user() {
    local username=$1
    sudo userdel -r "$username" && echo "Пользователь $username удален успешно."
}

# Функция для изменения прав доступа пользователя
change_permissions() {
    local username=$1
    local permissions=$2
    sudo usermod -aG "$permissions" "$username" && echo "Права для пользователя $username изменены."
}

# Функция для очистки директории ~/.cache/
clear_cache() {
    local username=$1
    local user_home=$(eval echo "~$username")
    if [ -d "$user_home/.cache" ]; then
        sudo rm -rf "$user_home/.cache/*" && echo "Кэш для пользователя $username очищен."
    else
        echo "Директория ~/.cache/ не найдена для пользователя $username."
    fi
}

# Функция для остановки приложения по трафику
stop_app_by_traffic() {
    local threshold=$1
    local app_pid=$(sudo netstat -tunp | awk -v threshold="$threshold" '$1 ~ /tcp|udp/ && $6 == "ESTABLISHED" && $7 ~ /[0-9]+\// {split($7, a, "/"); if ($3 >= threshold) print a[1]}' | head -n 1)

    if [ -n "$app_pid" ]; then
        sudo kill -9 "$app_pid" && echo "Приложение с PID $app_pid остановлено."
    else
        echo "Приложений с трафиком выше $threshold не найдено."
    fi
}

# Главный обработчик команд
case "$1" in
    add_user)
        add_user "$2"
        ;;
    remove_user)
        remove_user "$2"
        ;;
    change_permissions)
        change_permissions "$2" "$3"
        ;;
    clear_cache)
        clear_cache "$2"
        ;;
    stop_app_by_traffic)
        stop_app_by_traffic "$2"
        ;;
    *)
        echo "Usage: $0 {add_user|remove_user|change_permissions|clear_cache|stop_app_by_traffic}"
        ;;
esac

