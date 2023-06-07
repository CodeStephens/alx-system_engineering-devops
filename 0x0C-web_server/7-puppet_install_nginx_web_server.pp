# manifest installs nginx and configures the server

exec { 'apt-update':
  command => '/usr/bin/apt-get update',
  path    => '/usr/bin',
  unless  => '/usr/bin/apt-get update -qq >/dev/null',
  before  => Package['nginx'],
}

package { 'nginx':
  ensure => installed,
  before => File['/var/www/html/404.html'],
}

file { '/var/www/html/404.html':
  ensure  => present,
  content => "Ceci n'est pas une page",
  before  => Service['nginx'],
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => [
    File['/var/www/html/404.html'],
    File['/etc/nginx/sites-available/default'],
    File['/var/www/html/index.html'],
    ]
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "server {\n  listen 80 default_server;\n  listen [::]:80 default_server;\n  server_name _;\n\troot /var/www/html;\n\n  location /redirect_me {\n    return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\n  }\n\n  location / {\n    try_files \$uri \$uri/ =404;\n  }\n\n  error_page 404 /404.html;\n  location = /404.html {\n    internal;\n    root /var/www/html;\n  }\n}\n",
  before  => Service['nginx'],
}

file { '/var/www/html/index.html':
    ensure  => present,
    content => 'Hello World!\n',
    before  => Service['nginx'],
}
