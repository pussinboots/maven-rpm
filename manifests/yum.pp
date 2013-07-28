class yum {
  $repo = "Local-Repo"
  exec { 'yum clean':
    command => '/usr/bin/yum clean expire-cache',
    require => Yumrepo[$repo]
  }
  
  exec { 'yum update':
    command => '/usr/bin/yum -y update',
	require => Yumrepo[$repo]
  }
}

class baserepo {
   yumrepo { "Local-Repo":
      baseurl => "file:///yum-repo",
      descr => "Local yum repo",
      enabled => 1,
      gpgcheck => 0
   }
}