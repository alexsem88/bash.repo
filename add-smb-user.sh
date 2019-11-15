# Переменные
user='admin231'
smbconf='/etc/samba/smb.conf'
userpass='123'

# Добавляем пользователя в систему
useradd "$user" -p "$userpass"
# Добавляем пользователя в группу (в моем случае это было необходимо)
usermod -aG archives $user
# Добавляем пользователя в samba
(echo "$userpass"; echo "$userpass") | smbpasswd -s -a "$user"
# Включаем пользователя samba
smbpasswd -e $user
# Добавляем пользователя в конфиг samba (во все секции write list и valid user)
sed -i -r "s/^(write list.*|valid user.*)/\1,"$user"/" $smbconf
# Перезапустим службу samba
service smbd restart
