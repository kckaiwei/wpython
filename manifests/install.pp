class wpython::install inherits wpython {

  $version          = $wpython::version
  $downloaddirectry = $wpython::downloaddirectory
  $uninstall        = $wpython::uninstall
  
  #version comparison function used, returns 1 if first # larger, 0 if equal, -1 if first # smaller
  #takes strings
  if versioncmp('3.5', $version) <= 0{
    
    if $uninstall != true {
 
	# creates directory for downloads 
    	file {'pythondirectory':
    	  ensure => directory,    
    	  path   => "${downloaddirectory}",
    	}
  
    	#package resource for windows exes only support file system URIs, hence need to store a copy
    	file {'pythondownload':
    	  ensure => present,
    	  path   => "${downloaddirectory}/python-${version}.exe",
    	  source => "https://www.python.org/ftp/python/${version}/python-${version}.exe",
    	}

	#________________________________________________________________ If python installed, If not installed...
    	if $facts['python_version'] == '3.9.2' and $facts['python_release'] == "3.9" {
    	  notify {'Python is installed with version 3.9.2' :}
    	}
    	else {
    	  #/i & /qn flags are automatically included.
    	  #installs 3.5+, it matters since python now uses .exe instead of .msi
    	  notify {'Python 3.9.2 not present, installing...':}
    	  package {'python35':
    	    ensure          => installed,
    	    source          => "${downloaddirectory}/python-${version}.exe",
    	    provider        => windows,
    	    install_options => ['/quiet', { 'InstallAllUsers' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, { 'PrependPath' => '1' }, ],
    	   }
    	}

    }
    #____________________________________________________________________ If uninstall option 
    else {
      package {"Python ${version} (32-bit)":
        ensure            => absent,
        source            => "${downloaddirectory}/python-${version}.exe",
        provider          => windows,
        uninstall_options => ['/uninstall', '/quiet'],
        }
    }
    
  }
 } 
 # #Yes, that is how it's spelled
 # elsif versioncmp('3.0', $version) <=0{
 # 
 #   if $uninstall != true {
 #   
 #     #installs 3.0+
 #     package {'python30':
 #       ensure          => installed,
 #       source          => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
 #       provider        => windows,
 #       install_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
 #       }
 #   }
 #   
 #   else {
 #   
 #     package {"Python ${version}":
 #       ensure            => absent,
 #       source            => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
 #       provider          => windows,
 #       uninstall_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
 #       }
 #   }
 # }
 # 
 # else {
 #   
 #   if $uninstall != true {
 #     #install 2.7
 #     package {'python27':
 #       ensure          => installed,
 #       source          => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
 #       provider        => windows,
 #       install_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
 #       }
 #     }
 #   else {
 #     package {"Python ${version}":
 #       ensure            => absent,
 #       source            => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
 #       provider          => windows,
 #       uninstall_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
 #       }
 #   }
 # }

