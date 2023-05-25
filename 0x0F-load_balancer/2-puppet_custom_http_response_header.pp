# Install nginx web server package
exec { 'update':
    provider => shell,
    command  => 'sudo apt-get -y update',
    before   => Package['nginx'],
}

package { 'nginx':
  ensure => installed,
}

# Add custom header to the configuration file
file_line { 'add_custom_header':
  path   => '/etc/nginx/sites-available/default',
  line   => "server {\n\tadd_header X-Served-By \$HOSTNAME;",
  match  => '^server {',
  after  => 'true',
  notify => Service['nginx'],
}

# Ensure nginx is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => 'true',
  require => Package['nginx'],
}
