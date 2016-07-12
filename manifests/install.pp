class hprest::install {

    if $osfamily == 'Debian' {

    #Create initial directory for recursive management
    #Directory containing 'hprest' MUST EXIST!
    file { '/etc/puppetlabs/code/environments/production/modules/hprest/':
      ensure => directory,
      mode   => '0755',
  	  }
	  
    #Recursive copy of files
    file { '/etc/puppetlabs/code/environments/production/modules/hprest/files':
      ensure  => directory,
      source  => 'puppet:///modules/hprest',
      recurse => true,
      require => File['/etc/puppetlabs/code/environments/production/modules/hprest/'],
          }
		  
    exec { 'auto-add repo':
      path      => '/bin',
      cwd       => '/etc/puppetlabs/code/environments/production/modules/hprest/files',
      logoutput => true,
      loglevel  => notice,
      require   => File['/etc/puppetlabs/code/environments/production/modules/hprest/files'],
      command   => 'sh add_repo.sh hprest',
      }
	  
    exec { 'apt-get install':
      command => 'apt-get update && apt-get install hprest',
	}
    }
    
  if $osfamily == 'redhat' {

    #Create initial directory for recursive management
    #Directory containing 'hprest' MUST EXIST!
    file { '/etc/puppet/modules/hprest/':
      ensure => directory,
      mode   => '0755',
  	  }
	  
    #Recursive copy of files
    file { '/etc/puppet/modules/hprest/files':
      ensure  => directory,
      source  => 'puppet:///modules/hprest',
      recurse => true,
      require => File['/etc/puppet/modules/hprest'],
          }
		  
    exec { 'auto-add repo':
      path      => '/bin',
      cwd       => '/etc/puppet/modules/hprest/files',
      logoutput => true,
      loglevel  => notice,
      require   => File['/etc/puppet/modules/hprest/files'],
      command   => 'sh add_repo.sh hprest',
  	  }
	  
    #manual install using unless
    yumrepo { 'hprest yum repo':
      ensure => present,
      baseurl => "http://downloads.linux.hpe.com/SDR/repo/hprest/rhel/$operatingsystemrelease/$architecture/current",
    }
	  
    package {'hprest':
      ensure   => installed,
      provider => yum,
    }
    
  }
  
  if $osfamily == 'windows' {
  
    #Create initial directory for recursive management
    file { 'C:\\hprest':
      ensure => directory,
      mode   => '0755',
  	  }
    #Recursive copy and management of library files
    file { 'C:\\hprest\\files':
      ensure  => directory,
      source  => 'puppet:///modules/hprest',
      recurse => true,
      require => File['C:\\hprest'],
          }
    #msiexec is called when provider is set to windows
    #/i & /qn flags are automatically included.
    package {'python':
      ensure          => installed,
      source          => 'https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi',
      provider        => windows,
      install_options => [ { 'INSTALLDIR'=>'C:\\python27' }, { 'ALLUSERS'=>'1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }

    package {'hprest':
      ensure          => installed,
      source          => 'ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1440367746/v109762/hprest-1.5.0.0-94.x86_64.msi',
      install_options => ['INSTALLDIR=>C:\\Program Files\\Hewlett Packard Enterprise\\HPE RESTful Interface Tool\\'],
      provider        => windows,
      }
  
  }

}
