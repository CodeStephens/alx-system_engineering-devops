# Install Nginx
class { 'nginx': }

# Configure Nginx
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  content => "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name 52.87.219.225;

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }

    error 404 /404.html

    location / {
        try_files \$uri \$uri/ =404;
    }

    location = /404.html {
        internal;
        root /var/www/html;
    }
}",
  notify => Service['nginx'],
}

# Create the default html page
file { '/var/www/html/default':
  ensure  => file,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  content => "<!DOCTYPE html>
<html>
    <head>
        <title>Welcome</title>
    </head>
    <body>
         <p>Hello World!</p>
    </body>
</html>",
}

# Create the custom 404 error page
file { '/var/www/html/404.html':
  ensure  => file,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  content => "<!DOCTYPE html>
<html>
    <head>
        <title>404 Not Found</title>
    </head>
    <body>
        <h1>404 Not Found</h1>
         <p>Ceci n'est pas une page</p>
    </body>
</html>",
}

# Start and enable the Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/sites-available/default'],
}

