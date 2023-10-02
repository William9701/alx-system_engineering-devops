# 2-puppet_custom_http_response_header

class { 'nginx': }

nginx::resource::server { '_':
  listen_port => 80,
  index_files => ['index.html'],
  use_default_location => false,
  www_root => '/var/www/html',
}

nginx::resource::location { '/':
  location => '/',
  server => '_',
  location_custom_cfg => {
    'add_header' => [
      'Content-Type "text/html"',
      'ETag "your-etag-value"',
      'Accept-Ranges "bytes"',
      'X-Served-By $hostname',
    ],
    'return' => '200 "Hello World!\n"',
  },
}

nginx::resource::location { '/redirect_me':
  location => '/redirect_me',
  server => '_',
  location_custom_cfg => {
    'return' => '301 https://www.youtube.com/watch?v=QH2-TGUlwu4',
  },
}

