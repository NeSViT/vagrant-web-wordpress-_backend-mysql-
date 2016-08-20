1. Создать проект(использовать то что делали в класе просто создать папочку) на Gitlab'e. В созданном проекте будут - Vagrantfile, provision script, WordPress sources(https://wordpress.org).

1.1 Скачать последнюю версию WordPress, распаковать и добавить исходники в наш проект, в папку: wordpress-sources.

1.2 Создать Vagrantfile со следующей конфигурацией:

- 2 VMs: web, backend



[Backend VM]:

-- 1 CPU ; 512 MB MEM ; private network ; shell provision: db_config.sh

[Web VM]:

-- 1 CPU ; 512 MB MEM ; private and public network; sync-folder: "/path/to/your/project/wordpress-sources" "/var/www/wordpress"

p.s дистрибутив по желанию



2. Написать db_config.sh, который будет:

- создавать базу данных для WordPress

- создавать пользователя и установит ему пароль и права на БД для WordPress

3. Отредактировать файл настроек WordPress(wp-config.php), чтобы сайт был автоматически был сконфигурирован на работу с VM: backend.



Критерии успеха:

- Backend

1. MySQL is up and running.

2. MySQL доступен для подключения с WEB VM.

3. В MySQL присутствует БД. пользователь, пароль и права на БД.

- Web

1. Apache HTTPD is up and running.

2. Wordpress доступен как в private так и в public network.

3. Вы можете подключиться к БД на BACKEND VM.

4. Все изменения, которые вы вносите в код WordPress в папке wordpress-sources, после перезагрузки сайта сразу доступны.



Документация:

- Vagrant :: https://docs.vagrantup.com/v2/

- CentOS :: https://www.centos.org

- Ubuntu :: http://www.ubuntu.com

- VirtualBox :: http://www.virtualbox.org/manual/

- GitHub :: https://github.com