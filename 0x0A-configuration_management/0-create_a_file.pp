file {'/tmp/school':
ensure => present,
mode => '0744',
group => 'www-data',
user => 'www-data',
content => 'I love Puppet'
}
