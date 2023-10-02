# 2-puppet_custom_http_response_header

# Ensure Nginx is installed
package { 'nginx':
  ensure => 'installed',
}

# Define Nginx configuration
file { '/etc/nginx/sites-available/default':
  content => "\
server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.html;
    location / {
        add_header Content-Type 'text/html';
        add_header Accept-Ranges 'bytes';
        add_header X-Served-By $hostname;
        return 200 'Hello World!\\n';
    }
    location /redirect_me {
        return 301 'https://www.youtube.com/watch?v=QH2-TGUlwu4';
    }
}
",
  require => Package['nginx'],
}

# Restart Nginx
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}

