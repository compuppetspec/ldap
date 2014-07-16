require 'spec_helper'

describe 'ldap::client' do

	let (:params) {{ :ldap_conf => '/etc/ldap.conf',:ldap_package => 'openldap',:ldap_package_version =>'installed',\
	:nslcd_conf=>'/etc/nslcd.conf',:nss_pam_ldapd_package =>'nss-pam-ldapd',:nslcd_service =>'nslcd',:nslcd_service_ensure=>'running',\
	:nslcd_service_enable=>'true',:pam_ldap_conf=>'/etc/pam_ldap.conf',:sudo_ldap_conf=>'/etc/sudo-ldap.conf',\
	:nss_pam_ldapd_package_version=>'installed',:manage_pam_ldap=>'true',:manage_sudo_ldap=>'false',\
	:ldap_pam_package=>'pam_ldap',:ldap_pam_package_version=>'installed'}}
	
	context 'With RedHat' do
	let (:facts) {{ :osfamily => 'redhat'}}
	it { should contain_class('ldap::client') }
	it { should contain_class('ldap::params') }
	
	it { should contain_file('/etc/ldap.conf').with('ensure'=>'file','mode' =>'0644').that_notifies('Service[nslcd]').with_content(/uri \nssl no\nbase \nldap_version 3/)}
	it { should contain_package('openldap').with('ensure' =>'installed').that_requires('File[/etc/ldap.conf]')}
    it { should contain_file('/etc/nslcd.conf').with('ensure'=>'file','mode' =>'0644').that_notifies('Service[nslcd]').with_content(/uid nslcd\ngid nslcd\nuri \nssl no\nbase \nldap_version 3/)}
	it { should contain_package('nss-pam-ldapd').with('ensure' =>'installed').that_requires('File[/etc/nslcd.conf]')}				
	it { should contain_service('nslcd').with('ensure' =>'running','enable' =>'true').that_requires('Package[nss-pam-ldapd]')}
	
	it { should contain_package('pam_ldap').with('ensure' =>'installed')}				
	it { should contain_file('/etc/pam_ldap.conf').with('ensure'=>'file','mode' =>'0644').that_notifies('Service[nslcd]').that_requires('Package[pam_ldap]').with_content(/uid nslcd\ngid nslcd\nuri \nssl no\nbase \nldap_version 3/)}
	it { expect {should compile}.to raise_error(Puppet::Error, /File \/etc\/sudo-ldap.conf is not being created as manage_sudo_ldap is set to false/)}
		
	context "With manage_pam_ldap set to false and manage_sudo_ldap set to true" do
	let (:facts) {{ :osfamily => 'redhat',:manage_pam_ldap=>'false',:manage_sudo_ldap=>'true'}}
	it {expect {should compile}.to raise_error(Puppet::Error, /Module pam_ldap is not being installed as manage_pam_ldap is set to false/)}
    it { should contain_file('/etc/sudo-ldap.conf').with('ensure'=>'file','mode' =>'0644').that_notifies('Service[nslcd]').with_content(/uri \nssl no\nbase \nldap_version 3/)}
    end
	end
	
	
	context 'Without RedHat' do
	let (:facts) {{ :osfamily=> 'solaris'}}
	it{ expect {should compile}.to raise_error(Puppet::Error, /Module udev is not supported on solaris/)}
    end
    
end
