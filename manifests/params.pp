class ldap::params {
  $ldap_package                   = $::osfamily ?{
    'redhat' => 'openldap'
  }
  $ldap_pam_package               = $::osfamily ?{
    'redhat' => 'pam_ldap',
  }
  $nss_pam_ldapd_package          = $::osfamily ?{
    'redhat' => 'nss-pam-ldapd',
  }
  $nslcd_service                  = 'nslcd'
  $nslcd_service_enable           = true
  $nslcd_service_ensure           = 'running'
  $ldap_package_version           = 'installed'
  $ldap_pam_package_version       = 'installed'
  $nss_pam_ldapd_package_version  = 'installed'
  $ldap_conf                      = '/etc/ldap.conf'
  $ldap_conf_template             = "${module_name}/ldap_conf.erb"
  $nslcd_conf                     = '/etc/nslcd.conf'
  $nslcd_conf_template            = "${module_name}/nslcd_conf.erb"
  $pam_ldap_conf                  = '/etc/pam_ldap.conf'
  $pam_ldap_conf_template         = "${module_name}/pam_ldap_conf.erb"
  $sudo_ldap_conf                 = '/etc/sudo-ldap.conf'
  $sudo_ldap_conf_template        = "${module_name}/sudo_ldap_conf.erb"
  $sudoers_base                   = undef
  $manage_sudo_ldap               = false
  $manage_pam_ldap                = true 
  $nslcd_user                     = 'nslcd'
  $nslcd_group                    = 'nslcd'
  $use_ssl                        = false
  $ssl_cert                       = undef
  $base                           = undef
  $base_netgroup                  = undef
  $ldap_version                   = 3
  $uri                            = undef
  $tls_reqcert                    = undef
  $filter_passwd                  = undef
  $filter_shadow                  = undef
  $filter_group                   = undef
  $filter_netgroup                = undef
  $tls_checkpeer                  = undef
}
