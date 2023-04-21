# This manifest defines a resource file which is intended to create a 'school'
# file in the tmp directory if the file does not already exist; defines
# the mode permission, the user and owner, as well as the content of the file

file {'/tmp/school':
ensure  => present,
mode    => '0744',
group   => 'www-data',
owner    => 'www-data',
content => 'I love Puppet',
}

