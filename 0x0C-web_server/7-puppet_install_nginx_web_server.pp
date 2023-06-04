# manifest installs nginx and configures the server

exec { 'apt-update':
  command => '/usr/bin/apt-get update',
  path    => '/usr/bin',
  unless  => '/usr/bin/apt-get update -qq >/dev/null',
  before => Package['nginx'],
}

package { 'nginx':
  ensure => installed,
  before => File['/etc/nginx/sites-available/default'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "server {\n  listen 80 default_server;\n  listen [::]:80 default_server;\n  server_name _;\n\n  location /redirect_me {\n    return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\n  }\n\n  location / {\n    try_files \$uri \$uri/ =404;\n  }\n\n  error_page 404 /404.html;\n  location = /404.html {\n    internal;\n    root /var/www/html;\n  }\n}\n",
  before => File['/var/www/html/404.html'],
}

file { '/var/www/html/404.html':
  ensure  => present,
  content => "Ceci n'est pas une page",
  notify => Service['nginx'],
}

service { 'nginx':
  ensure => running,
  enable => true,
  -> File['/var/www/html/404.html'],
}
