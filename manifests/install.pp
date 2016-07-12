class wpython::install inherits wpython {

  $version = $wpython::version

  if $version >= 3.5{

    #/i & /qn flags are automatically included.
    #installs 3.0+
    package {'python35':
      ensure          => installed,
      source          => "https://www.python.org/ftp/python/${version}/python-${version}.exe",
      provider        => windows,
      install_options => [{ 'ALLUSERS'=>'1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
    
  }
  
  #Yes, that is how it's spelled
  elsif $version >= 3.0{
  
    #installs 3.0+
    package {'python30':
      ensure          => installed,
      source          => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
      provider        => windows,
      install_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
  
  }
  
  else {
    
    #install 2.7
    package {'python27':
      ensure          => installed,
      source          => "https://www.python.org/ftp/python/${version}/python-${version}.msi",
      provider        => windows,
      install_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
  }

}
