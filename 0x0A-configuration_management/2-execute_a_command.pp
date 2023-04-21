# This manifest when applied issues command to terminate a process named
# 'killmenow'

exec {'killmenow':
  command => 'pkill killmenow',
  onlyif  => 'pgrep killmenow',
  path    => ['/bin/', '/usr/bin/'],
}

