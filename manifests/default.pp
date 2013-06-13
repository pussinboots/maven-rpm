# Basic Puppet Apache manifest

class apache {
  exec { 'yum update':
    command => '/usr/bin/yum -y update'
  }

  package { "httpd":
    ensure => present,
  }

  service { "httpd":
    ensure => running,
    require => Package["httpd"],
  }

  file { '/var/www/html/index.html':
  #  ensure => link,
    source => "/vagrant/index.html",
    notify => Service['httpd'],
    force  => true
  }
}

class helloworld {
  package { "helloworld":
    ensure => present,
  }

  #service { "tomcat":
  #  ensure => running,
  #  require => Package["apache-tomcat"],
  #}
}

class baserepo {
   yumrepo { "Local-Repo":
      baseurl => "file:///yum-repo",
      descr => "Local yum repo",
      enabled => 1,
      gpgcheck => 0
   }
}

include baserepo
include helloworld
include apache
