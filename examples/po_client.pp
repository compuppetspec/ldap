class {'ldap::client':
  sudoers_base     => 'ou=xsudoers,dc=ra,dc=ccp,dc=cable,dc=comcast,dc=com',
  manage_sudo_ldap => true,
  base             => 'dc=ra,dc=ccp,dc=cable,dc=comcast,dc=com',
  base_netgroup    => 'ou=xnetgroups,dc=ra,dc=ccp,dc=cable,dc=comcast,dc=com',
  uri              => 'ldap://ldap.po.ccp.cable.comcast.com ldap://ldap.ccp.xcal.tv:389 ldap://ldap3.r53.xcal.tv:1389',
  filter_passwd    => '(objectClass=posixAccount)',
  filter_shadow    => '(objectClass=posixAccount)',
  filter_group     => '(objectClass=posixGroup)',
  filter_netgroup  => '(objectClass=nisNetgroup)',
}

