remd
====

Демон, управляет стадом демонов для удаленного COM порта. (remserial)

remd.conf - Файл настроек.
remd - демон ( /etc/init.d/ )

### Установка:

remd.conf - Положить в /etc/remd.conf / chmod 644 /etc/remd.conf

Поместить remd в каталог /etc/init.d/ и установить службу

chkconfig --add remd

Проверяем что служба установлена и включена

chkconfig --list remd

За место chkconfig можно использовать update-rc.d

### Поддерживает команды:
* start - запускает
* stop - останавливает
* status - статус
* restart - перезапускает

### Требования:
* В файле /etc/sudoers хватало прав у пользователя root. ('root ALL=(ALL) ALL')

### Проверн в ОС
* AltLinux

