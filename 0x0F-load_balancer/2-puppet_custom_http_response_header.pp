# 2-puppet_custom_http_response_header.pp

# Ensure the package manager's cache is up to date
exec { 'apt_update':
  command => '/usr/bin/apt-get update',
}

# Install Nginx
package { 'nginx':
  ensure => installed,
  require => Exec['apt_update'],
}

# Start and enable Nginx service
service { 'nginx':
  ensure => running,
  enable => true,
  require => Package['nginx'],
}

# Configure Nginx
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

# Restart Nginx service after configuration
exec { 'restart_nginx':
  command     => '/usr/sbin/service nginx restart',
  refreshonly => true,
}

