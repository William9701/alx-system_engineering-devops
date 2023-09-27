#!/usr/bin/env bash
# what can the puppet archive

class { 'nginx':
  listen_port => 80,
}

nginx::resource::vhost { 'default':
  www_root => '/var/www/html',
}

nginx::resource::location { '/':
  location_cfg_append => [
    'return 200 "Hello World!\n";',
  ],
}

nginx::resource::location { '/redirect_me':
  location_cfg_append => [
    'return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;',
  ],
}

