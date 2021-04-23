### Настройка сети между виртуальными машинами ###
#### VM1 ####
Данная машина (ip адрес 192.168.1.2/24) имеет возможность обмена пакетами между VM2 и VM3, а также доступ в интернет через VM2.
Статический ip адрес, а также роутинг настроен при помощи инструмента nmtui.
Файлы ifcfg-enp0s8 и route-enp0s8 хранятся в каталоге VM1.
Для настройки фаервола, при помощи брандмауэра firewall-cmd, регулирующего обмен пакетами между VM1 и VM2, используется следующая команда:
> firewall-cmd --zone=public --add-rich-rule 'rule family="ipv4" source address=192.168.1.1 accept' --permanent 

Файл public.xml хранится в каталоге VM1.

---
#### VM2 ####
Данная машина (ip адрес 192.168.1.1/24 и ip адрес 10.0.0.1/24) имеет возможность обмена пакетами между VM1 и VM3, а также доступ в интернет.
Статический ip адрес, а также роутинг настроен при помощи инструмента nmtui.
Файлы ifcfg-enp0s3, ifcfg-enp0s8, ifcfg-enp0s9, route-enp0s3 хранятся в каталоге VM2.
Для настройки фаервола, при помощи брандмауэра firewall-cmd, регулирующего обмен пакетами между VM1 и VM3, используются следующие команды:
> firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv4" source address=10.0.0.2 accept'

> firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv4" source address=192.168.1.2 accept'

Для настройки фаервола, при помощи брандмауэра firewall-cmd, регулирующего доступ в интернет, используются следующие команды:
> firewall-cmd --permanent --zone=home --add-rich-rule 'rule family="ipv4" source address=192.168.1.2/24 masquerade'

> firewall-cmd --permanent --zone=home --add-rich-rule 'rule family="ipv4" source address=10.0.0.2/24 reject'

Файлы home.xml и public.xml хранятся в каталоге VM2.

---
 #### VM3 ####
Данная машина (ip адрес 10.0.0.2/24) имеет возможность обмена пакетами между VM1 и VM2.
Доступ в интернет для VM3 ограничивается настройками фаервола на машине VM2.
Статический ip адрес, а также роутинг настроен при помощи инструмента nmtui.
Файлы ifcfg-enp0s8 и route-enp0s8 хранятся в каталоге VM3.
Для настройки фаервола, при помощи брандмауэра firewall-cmd, регулирующего обмен пакетами между VM3 и VM2, используется следующая команда:
> firewall-cmd --zone=public --add-rich-rule 'rule family="ipv4" source address=10.0.0.1 accept' --permanent 

Файл public.xml хранится в каталоге VM3.
