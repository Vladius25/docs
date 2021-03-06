=============================
Настройка веб-сервера Nginx
=============================

Определение
========================

Понятие **веб-сервер** может относиться как к аппаратной начинке, так и к программному обеспечению. Или даже к обеим частям, работающим совместно.

1. С точки зрения "железа", **веб-сервер** — это компьютер, который хранит файлы сайта (HTML-документы, CSS-стили, JavaScript-файлы, картинки и другие) и доставляет их на устройство конечного пользователя (веб-браузер и т.д.). Он подключен к сети Интернет и может быть доступен через доменное имя, подобное ``school9.perm.ru``.

2. С точки зрения ПО, **веб-сервер** включает в себя несколько компонентов, которые контролируют доступ веб-пользователей к размещенным на сервере файлам, как минимум — это HTTP-сервер. HTTP-сервер — это часть ПО, которая понимает URL’ы (веб-адреса) и HTTP (протокол, который ваш браузер использует для просмотра веб-страниц).

На самом базовом уровне, когда браузеру нужен файл, размещенный на веб-сервере, браузер запрашивает его через HTTP-протокол. Когда запрос достигает нужного веб-сервера ("железо"), сервер HTTP (ПО) принимает запрос, находит запрашиваемый документ (если нет, то сообщает об ошибке ``404``) и отправляет обратно, также через HTTP.

.. image:: _static/images/web-server.png

Популярное ПО
===================

**Apache** и **Nginx** — 2 самых широко распространенных веб-сервера с открытым исходным кодом в мире (`см. здесь <https://w3techs.com/technologies/overview/web_server/all>`_). Вместе они обслуживают большую часть трафика во всем интернете. Оба решения способны работать с разнообразными рабочими нагрузками и взаимодействовать с другими приложениями для реализации полного веб-стека.

Apache
-------------------

**Apache HTTP Server** был разработан *Робертом Маккулом* в 1995 году, а с 1999 года разрабатывается под управлением *Apache Software Foundation* — фонда развития программного обеспечения Apache. Так как HTTP сервер это первый и самый популярный проект фонда его обычно называют просто Apache.

Веб-север Apache был самым популярным веб-сервером в интернете с 1996 года. Благодаря его популярности у Apache сильная документация и интеграция со сторонним софтом

Nginx (Engine X)
--------------------

**Nginx** был разработан *Игорем Сысоевым* в 2002 году и начал набирать популярность с момента релиза благодаря своей легковесности и возможности легко масштабироваться на минимальном железе. Nginx превосходен при отдаче статического контента и спроектирован так, чтобы передавать динамические запросы другому ПО предназначенному для их обработки.

**Nginx** позиционируется производителем как простой, быстрый и надёжный сервер, не перегруженный функциями.

Что лучше?
---------------------

**Apache** и **Nginx** имеют очень много схожих качеств, но их нельзя рассматривать как взаимозаменяемые. Каждый веб-сервер имеет свои особенности, и поэтому лучше всего подходит для определенных ситуаций. В интернете вы можете найти множество статей, объясняющих преимущества каждого.

О данной инструкции
=====================

**Nginx** изначально умел очень мало и позиционировался как быстрый http-сервер для отдачи статики. Cейчас он умеет почти все, что и **Apache**. При этом первый менее ресурсоемкий и гораздо проще в настройке.

Выполнять его установку и настройку будем на дистрибутиве **CentOS 7**, который часто использутеся в качестве серверной ОС. Для других дистрибутивов процесс практически идентичен. Вам будет необходимо подключиться по ``ssh`` (:ref:`см. здесь <ssh>`) к хосту ``kojima.sch9.lan`` на порт ``50XX``, где *XX* - номер вашего компьютера. Заходите под пользователем *root* с паролем *toor*. Пароль можно сразу изменить (:ref:`cм. здесь <passwd>`).

К слову, сайт школы работает именно на такой конфигурации: **Nginx** и **CentOS 7**. 

.. note::

   1. В тексте встречается символ ``$``. Это общепринятое обозначение комманд, которые нужно выполнять с правами *суперпользователя* (:ref:`см. здесь <superuser>`).
   2. В тексте встречается слово ``контейнер``. Воспринимайте его как особым образом подготовленное для учебных целей окружение. 
   3. Урок предлагает использовать стандартную оболочку, но для упрощенной навигации и редактирования вы можете использовать *Midnight Commander* (``mc``).   

Установка
====================

Установка пакета
--------------------

Подключим репозиторий epel, в котором много полезного для **CentOS 7**. Установим пакет Nginx из репозитория (:ref:`см. здесь <repos>`):

.. prompt:: bash $
    
    yum install epel-release
    yum install nginx

Запуск и автозапуск
--------------------

Запустим веб-сервер и сразу добавим его в автозагрузку, чтобы он автоматически запускался при старте ОС. Для этого используем ``Systemd`` (:ref:`см. здесь <systemd>`):

.. prompt:: bash $
   
    systemctl start nginx
    systemctl enable nginx

.. hint::

   Эквивалентная команда:

   .. prompt:: bash $

   	   systemctl enable --now nginx

Проверим, что веб-сервер успешно запустился:

.. prompt:: bash $

    systemctl status nginx	

В результате должно быть что-то такое::

    ● nginx.service - The nginx HTTP and reverse proxy server
       Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
       Active: active (running) since Thu 2019-05-02 16:10:57 UTC; 3h 6min ago
       ...

Правила фаервола
-------------------

Откроем порты ``80`` *(http)* и ``443`` *(https)*:

.. prompt:: bash $

   firewall-cmd --permanent --add-service=http
   firewall-cmd --permanent --add-service=https
   firewall-cmd --reload

Уже можно посмотреть, что получилось. Откройте браузер и зайдите на ``http://kojima.sch9.lan:60XX/``, где *XX* - номер вашего компьютера. Порт ``60XX`` в данном случае перенаправляется на порт ``80`` вашего контейнера.

Настройка
====================

Структура конфигурационного файла
----------------------------------

Главной конфигурационный файл nginx находится по пути /etc/nginx/nginx.conf. Откроем его редактором ``vim``:

.. prompt:: bash $

    vim /etc/nginx/nginx.conf

Рассмотрим самые важные части:

.. code-block:: nginx

    http {  # Директива, в которой находится конфигурация всех серверов
        access_log  /var/log/nginx/access.log  main;  # Где хранить логи обращений к серверу

        include /etc/nginx/conf.d/*.conf;  # Подключаем конфигурационные файлы

        server { # Задаёт конфигурацию для виртуального сервера.
            listen       80 default_server;    # Указываем, какой порт слушать. Обычно это 80 или 443(для https)
            listen       [::]:80 default_server;   # То же самое для IPv6 адресов. 
            server_name  _;  # Задает имя виртуального сервера
            root         /usr/share/nginx/html;   # Путь до директории, где хранятся файлы нашего сайта

            include /etc/nginx/default.d/*.conf;  # Подключаем конфигурационные файлы

            location / { #Устанавливает конфигурацию в зависимости от URI запроса
                # В данном случае конфигурацию корня сайта
            }

            error_page 404 /404.html;    # Если ошибка 404, ссылаемся на 40x.html
                location = /40x.html {
            }

            error_page 500 502 503 504 /50x.html;  # Если ошибка 50x, ссылаемся на 50x.html
                location = /50x.html {
            }
        }
    } 

Пока нам достаточно будет привести ``server_name`` и ``root`` к такому виду (см. подсказку):

.. code-block:: nginx

    server_name kojima.sch9.lan;
    root /srv/www/kojima.sch9.lan;

Заставим **Nginx** перечитать конфигурацию:

.. prompt:: bash $

    systemctl reload nginx

.. hint::
    
    Чтобы войти в режим редактирования в ``vim``, нужно нажать ``i`` (в английской раскладке). Когда вы закончите редактирование, дважды нажмите ``ESC``, чтобы перейти в обычный режим. Нажмите ``:`` и наберите ``wq``, чтобы сохранить и выйти. Если ``vim`` показался вам сложным, можете импользоваться редактор ``nano`` или программку ``mc``. 

Создание директории сайта
----------------------------

Cоздадим директорию, которую мы указали в качестве корня сайта, и зайдем в нее:

.. prompt:: bash $

    mkdir -p /srv/www/kojima.sch9.lan
    cd /srv/www/kojima.sch9.lan

Создадим файл ``index.html`` следующего содержания:

.. code-block:: html

    <html>
        <head>
            <title>My First HTML Page</title>
        </head>
        <body>

            Hello, World.

        </body>
    </html>

Откроем сайт и посмотрим, что получилось.

Настройка php
---------------------------

**Nginx** сам по себе не умеет работать с **php**. Этим будет заниматься *PHP FastCGI Process Manager*. Утверждается, что связка ``Nginx + php-fpm`` сильно быстрее, чем **Apache**.

.. note::

    *FastCGI Process Manager*. Это альтернативная реализация **FastCGI** режима в **PHP** с несколькими дополнительными возможностями, которые обычно используются для высоконагруженных сайтов. `Подробнее <http://xandeadx.ru/blog/php/866>`_.

Установим необходимый пакет:

.. prompt:: bash $

    yum install php-fpm

Дополним конфигурацию nginx, указав, как должны обрабатываться файлы с расширением ``php``:

.. code-block:: nginx

    location / {
        }

    location ~ \.php$ {
        fastcgi_pass 127.0.0.1:9000; # FPM по умолчанию слушает порт 9000
        fastcgi_index index.php;     
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params; 
    }

Теперь создадим в директории сайта файл ``test.php`` следующего содержания:

.. code-block:: php
    
    <?php
    phpinfo();
    ?>

Наконец, перезагрузим **Nginx** и запустим **FPM**:

.. prompt:: bash $

    systemctl restart nginx php-fpm

Теперь можно зайти на ``http://kojima.sch9.lan:60XX/test.php``. Если все было сделано правильно, увидим сведения об установленной версии **php**.

Сброс контекста безопасности SELinux
-------------------------------------

У неопытных пользователей часто возникают проблемы с **SELinux** (:ref:`см. здесь <mac>`), поэтому они бегут его отключать, что является прямой угрозой безопасности. Чаще всего оказывается, что перемещенный из другого места файл имеет неподходящий контекст безопасности.

Восстанавливаем контекст всей директории:

.. prompt:: bash $
     
    restorecon -Rv /var/www/kojima.sch9.lan 

.. warning::

    Так как мы используем контейнеры, то в SELinux нет необходимости. Этот шаг выполнять не нужно.

.. _psnginx:

Послесловие
=================

Так выглядит стандартная настройка ПО в **GNU/Linux**. Возможно, она кажется сложной или громоздкой. На самом деле, ничего сложного здесь нет: весь процесс хорошо документирован. По сравнению с **GUI** имеем больше возможностей. Если нет желания настраивать вручную, для популярного ПО есть множество скриптов для автоматического развертывания.

Если вы когда нибудь брали дешевые или бесплатные хостинги для сайтов, то у вас может возникнуть вопрос: зачем мучиться с настройкой, если там все проще? Все эти хостинги работают на тех же **Apache** и **Nginx**, но не дают возможности хоть сколько-нибудь настроить их. Более разумным решением будет взять **VDS** или **VPS** и поднять веб-сервер. Крупные компании для размещения сайтов и приложений пользуются такими решениями, как *AWS* или *MS Azure*.
