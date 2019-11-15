# Скрипт автоматического добавления нового пользователя в систему samba
# создает системного пользователя, а также пользователя samba и добавляет 
# этого пользователя в конфиг samba

# Переменные
user='admin231'
smbconf='/etc/samba/smb.conf'
userpass='123'

useradd "$user" -p "$userpass"
usermod -aG archives $user
(echo "$userpass"; echo "$userpass") | smbpasswd -s -a "$user"
smbpasswd -e $user
sed -i -r "s/^(write list.*|valid user.*)/\1,"$user"/" $smbconf
service smbd restart
