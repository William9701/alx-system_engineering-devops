#!/usr/bin/env bash
# Install Nginx web server (w/ Puppet)

# File: nginx_setup.pp

# Install Nginx package
package { 'nginx':
  ensure => present,
}

# Configure Nginx
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => '
    server {
      listen 80;
      server_name localhost;

      # Redirect root to a "Hello World!" page with a 301 Moved Permanently
      location / {
        return 301 /hello;
      }

      location /hello {
        default_type text/html;
        return 200 "Hello World!\n";
      }
    }
  ',
}

# Ensure the Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

