# Puppet manifest that installs and configures nginx
class nginx {
  package { 'nginx':
    ensure => installed,
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

  file { '/var/www/html/index.html':
    content => 'Hello World!',
  }

  file { '/etc/nginx/sites-available/default':
    content => "
server {
  listen 80;
  server_name _;
  root /var/www/html;
  index index.html;

  location /redirect_me {
    return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
  }

  location / {
    try_files $uri $uri/ =404;
  }
}
    ",
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => link,
    target => '/etc/nginx/sites-available/default',
  }
}
