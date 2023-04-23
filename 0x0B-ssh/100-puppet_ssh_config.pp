# This puppet manifest seeks to make changes to configuration file
# it will ensure the client server is set up so as not to require password to 
# connect

$file_content = @(END)
IdentityFile ~/.ssh/school
PasswordAuthentication no
END

file {'./2-ssh_config':
ensure  => present,
content => $file_content,
}
