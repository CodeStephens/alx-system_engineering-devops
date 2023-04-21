# This manifest defines a resource package which is intended install a flask
# package with version 2.1.0 using pip3

package {'flask':
  ensure   => '2.1.0',
  provider => 'pip3'
}

