# Basic Puppet Apache manifest

import "nodes"
import "clean"

# to make it referencable for require
include yum

class apache {
  exec { 'allow http connections':
    command => '/sbin/iptables -I INPUT 5 -m state --state NEW -p tcp --dport 80 -j ACCEPT'
  }

  package { "httpd":
    ensure => present,
    require => Exec['yum update', 'allow http connections'],
  }

  service { "httpd":
    ensure => running,
    require => Package["httpd"],
  }

  file { '/var/www/html/index.html':
    source => "/vagrant/index.html",
    notify => Service['httpd'],
    force  => true,
	require => Service["httpd"]
  }
}

class tomcat-webapp {

  $weppname = "helloworld"

  # only insert if not already there
  exec { 'allow http connections on port 8080':
    command => '/sbin/iptables -I INPUT 5 -m state --state NEW -p tcp --dport 8080 -j ACCEPT'
  }

  file { '/usr/java':
    ensure => directory
  }
  
  file { '/usr/java/latest/':
    ensure => link,
    target => "/usr/lib/jvm/java-1.7.0/",
    force  => true,
    require => Exec['yum clean']
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
  
  package { $weppname:
    ensure => latest,
    require => File['/usr/java/latest/'],
    #require => Package["apache-tomcat-7.0.41-1.noarch"]
  }
}