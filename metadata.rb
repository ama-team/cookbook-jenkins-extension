name             'jenkins-x'
maintainer       'AMA Group'
maintainer_email 'ops@amagroup.ru'
license          'MIT'
description      'Provides functional extensions for the classic jenkins cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'jenkins', '~> 2.6.0'