class wpython::install inherits wpython {

  $version          = $wpython::version
  $downloaddirectry = $wpython::downloaddirectory
  $uninstall        = $wpython::uninstall
  
  #version comparison function used, returns 1 if first # larger, 0 if equal, -1 if first # smaller
  #takes strings
  if versioncmp('3.5', $version) <= 0{
  
    file {'pythondirectory':
      path   => "${downloaddirectory}",
      ensure => directory,
    }
  
    #package resource for windows exes only support file system URIs, hence need to store a copy
    file {'pythondownload':
      path   => "${downloaddirectory}/python-${version}.exe",
      source => "https://www.python.org/ftp/python/${version}/python-${version}.exe",
      ensure => present,
    }

    #/i & /qn flags are automatically included.
    #installs 3.5+, it matters since python now uses .exe instead of .msi
    package {'python35':
      ensure          => installed,
      source          => "C:/pythonfiles/python-${version}.exe",
      provider        => windows,
      install_options => ['/quiet', { 'InstallAllUsers' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
    
  }
  
  #Yes, that is how it's spelled
  elsif versioncmp('3.0', $version) <=0{
  
    if $uninstall != true {
    
      #installs 3.0+
      package {'python30':
        ensure          => installed,
        source          => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
        provider        => windows,
        install_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
        }
    }
    
    else {
    
      package {"Python ${version}":
        ensure          => absent,
        source          => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
        provider        => windows,
        uninstall_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
        }
    }
  }
  
  else {
    
    if $uninstall != true {
      #install 2.7
      package {'python27':
        ensure          => installed,
        source          => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
        provider        => windows,
        install_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
        }
      }
    else {
      package {"Python ${version}":
        ensure          => purge,
        source          => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
        provider        => windows,
        uninstall_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
        }
    }
  }

}
