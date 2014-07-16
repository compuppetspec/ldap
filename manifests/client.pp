class ldap::client(
  $ldap_package                   = $ldap::params::ldap_package,
  $ldap_pam_package               = $ldap::params::ldap_pam_package,
  $nss_pam_ldapd_package          = $ldap::params::nss_pam_ldapd_package,
  $nslcd_service                  = $ldap::params::nslcd_service,
  $nslcd_service_enable           = $ldap::params::nslcd_service_enable,
  $nslcd_service_ensure           = $ldap::params::nslcd_service_ensure,
  $ldap_package_version           = $ldap::params::ldap_package_version,
  $ldap_pam_package_version       = $ldap::params::ldap_pam_package_version,
  $nss_pam_ldapd_package_version  = $ldap::params::nss_pam_ldapd_package_version,
  $ldap_conf                      = $ldap::params::ldap_conf,
  $ldap_conf_template             = $ldap::params::ldap_conf_template,
  $nslcd_conf                     = $ldap::params::nslcd_conf,
  $nslcd_conf_template            = $ldap::params::nslcd_conf_template,
  $pam_ldap_conf                  = $ldap::params::pam_ldap_conf,
  $pam_ldap_conf_template         = $ldap::params::pam_ldap_conf_template,
  $sudo_ldap_conf                 = $ldap::params::sudo_ldap_conf,
  $sudo_ldap_conf_template        = $ldap::params::ldap_conf_template,
  $manage_sudo_ldap               = $ldap::params::manage_sudo_ldap,
  $sudoers_base                   = $ldap::params::sudoers_base,
  $manage_pam_ldap                = $ldap::params::manage_pam_ldap,
  $nslcd_user                     = $ldap::params::nslcd_user,
  $nslcd_group                    = $ldap::params::nslcd_group,
  $use_ssl                        = $ldap::params::use_ssl,
  $ssl_cert                       = $ldap::params::ssl_cert,
  $base                           = $ldap::params::base,
  $base_netgroup                  = $ldap::params::base_netgroup,
  $ldap_version                   = $ldap::params::ldap_version,
  $uri                            = $ldap::params::uri,
  $tls_reqcert                    = $ldap::params::tls_reqcert,
  $filter_passwd                  = $ldap::params::filter_passwd,
  $filter_shadow                  = $ldap::params::filter_shadow,
  $filter_group                   = $ldap::params::filter_group,
  $filter_netgroup                = $ldap::params::filter_netgroup,
  $tls_checkpeer                  = $ldap::params::tls_checkpeer
) inherits ldap::params {
  file { $ldap_conf:
    ensure  => file,
    mode    => '0644',
    content => template($ldap_conf_template),
  }->
  package { $ldap_package:
    ensure => $ldap_package_version,
  }

  file { $nslcd_conf:
    ensure  => file,
    mode    => '0644',
    content => template($nslcd_conf_template),
  } ->
  package { $nss_pam_ldapd_package:
    ensure => $nss_pam_ldapd_package_version,
  } ->
  service { $nslcd_service:
    ensure    => $nslcd_service_ensure,
    enable    => $nslcd_service_enable,
    subscribe => [ File[$ldap_conf], File[$nslcd_conf], File[$pam_ldap_conf], File[$sudo_ldap_conf]],
  }
  if ( $manage_pam_ldap ){
    package {$ldap_pam_package:
      ensure => $ldap_pam_package_version,
    } ->
    file { $pam_ldap_conf:
      ensure  => 'file',
      mode    => '0644',
      content => template($pam_ldap_conf_template),
    }
  }
  if ( $manage_sudo_ldap ){
    file { $sudo_ldap_conf:
      ensure  => 'file',
      mode    => '0644',
      content => template($sudo_ldap_conf_template),
    }
  }
}
