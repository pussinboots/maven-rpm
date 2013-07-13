# Basic Puppet Apache manifest

import "nodes"
import "clean"

class apache {
  exec { 'yum update':
    command => '/usr/bin/yum -y update'
  }

  package { "httpd":
    ensure => present,
    require => Exec['yum update'],
  }

  service { "httpd":
    ensure => running,
    require => Package["httpd"],
  }

  file { '/var/www/html/index.html':
    source => "/vagrant/index.html",
    notify => Service['httpd'],
    force  => true
  }
}

class helloworld {
  exec { 'yum update':
    command => '/usr/bin/yum -y update',
    require => Yumrepo["Local-Repo"],
  }

  file { '/usr/java':
    ensure => directory
  }
  
  file { '/usr/java/latest/':
    ensure => link,
    target => "/usr/lib/jvm/java-1.7.0/",
    force  => true,
    require => Exec['yum update']
  }

  ## prepare handling of java and tomcat dependency with puppet instead of the rpm itself
  
  #package { ["java-1.7.0-openjdk-devel"]:
  #  ensure => present,
  #  require => File['/usr/java/latest/']
  #}
  
  #package { ["apache-tomcat-7.0.41-1.noarch"]:
  #  ensure => present,
  #  require => Package["java-1.7.0-openjdk-devel"],
  #} 
  
  package { ["helloworld"]:
    ensure => present,
    require => File['/usr/java/latest/'],
    #require => Package["apache-tomcat-7.0.41-1.noarch"]
  }
}