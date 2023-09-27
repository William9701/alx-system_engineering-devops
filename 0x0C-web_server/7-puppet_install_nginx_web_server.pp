# File: nginx_setup.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
  provider => 'apt',
  install_options => ['-y'],
}

# Remove HTML files
exec { 'delete html files':
  command => 'sudo rm -rf /var/www/html/*.html',
  path    => ['/usr/bin', '/usr/sbin', '/usr/bin/env'],
}

# Start Nginx
exec { 'start nginx':
  command => 'sudo service nginx start',
  path    => ['/usr/bin', '/usr/sbin', '/usr/bin/env'],
}

# Default HTML content
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!\n',
}

# Add error 404 file
file { '/var/www/html/error404.html':
  ensure  => present,
  content => 'Ceci n\'est pas une page\n',
}

# Edit the default Nginx configuration
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    # Configure custom 404 error page
    error_page 404 /error404.html;

    location / {
             try_files $uri $uri/ =404;
    }

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
}
",
}

# Restart Nginx
exec { 'restart nginx':
  command => 'sudo service nginx restart',
  path    => ['/usr/bin', '/usr/sbin', '/usr/bin/env'],
}

