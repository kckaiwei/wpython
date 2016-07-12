class hprest::service inherits hprest {

  $ilo_ip         = $hprest::ilo_ip
  $ilo_username   = $hprest::ilo_username
  $ilo_password   = $hprest::ilo_password
  $hprest_command = $hprest::hprest_command
  
  if $osfamily == 'Debian' {

    #Setting default Exec parameters, path is designated in case environmental variables were not set
    Exec {
      path      => '/usr/bin',
      cwd       => '/etc/puppetlabs/code/environments/production/modules/hprest/files',
      logoutput => true,
      loglevel  => notice,
      require   => File['/etc/puppetlabs/code/environments/production/modules/hprest/files'],
  	  }
  }
  
  if $osfamily == 'redhat' {

    #Setting default Exec parameters, path is designated in case environmental variables were not set
    Exec {
      path      => '/usr/bin',
      cwd       => '/etc/puppet/modules/hprest/files',
      logoutput => true,
      loglevel  => notice,
      require   => File['/etc/puppet/modules/hprest/files'],
  	  }
  }
  
  if $osfamily == 'windows'{
  
    #Setting default Exec parameters, path is designated in case environmental variables were not set
    #Two \ are required since only one is viewed as an exit character
    Exec {
      path      => 'C:\\Python27\\',
      cwd       => 'C:\\hprest\\files',
      logoutput => true,
      loglevel  => notice,
      require   => File['C:\\hprest\\files'],
  	  }
  }
  
  #Start of examples execution, double quote use to allow variable use. 
  exec { 'hprest login':
    command => "hprest login ${ilo_ip} ${ilo_username} ${ilo_password}",
    } ->
	
  exec { 'hprest commands':
    command => "hprest ${hprest_command}",
	onlyif  => "${hprest_command}",
    }

}
