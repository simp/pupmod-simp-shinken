Summary: Shinken Puppet Module
Name: pupmod-shinken
Version: 4.1.0
Release: RC3
License: Apache License, Version 2.0
Group: Applications/System
Source: %{name}-%{version}-%{release}.tar.gz
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires: pupmod-concat
Requires: pupmod-pam >= 4.1.0-3
Requires: puppet >= 3.3.0
Buildarch: noarch
Requires: simp-bootstrap >= 4.2.0
Obsoletes: pupmod-shinken-test

Prefix:"/etc/puppet/environments/simp/modules"

%description
This Puppet module provides the capability to configure Shinken for your system.

%prep
%setup -q

%build

%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/shinken

dirs='lib manifests templates README'
for dir in $dirs; do
  cp -r $dir %{buildroot}/%{prefix}/shinken
done

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/shinken

%files
%defattr(0640,root,puppet,0750)
/etc/puppet/environments/simp/modules/shinken

%post
#!/bin/sh

if [ -d /etc/puppet/environments/simp/modules/shinken/plugins ]; then
  /bin/mv /etc/puppet/environments/simp/modules/shinken/plugins /etc/puppet/environments/simp/modules/shinken/plugins.bak
fi

%postun
# Post uninstall stuff

%changelog
* Fri Jan 16 2015 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-RC3
- Changed puppet-server requirement to puppet

* Sun Jun 22 2014 - Kendall Moore <kmoore@keywcorp.com> - 4.1.0-RC2
- Removed MD5 file checksums for FIPS compliance.

* Mon Apr 21 2014 - Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-RC1
- Updated the $client_nets variable to use hiera and cleaned up some comments.
- Replaced calls to pam::groupaccess with pam::access.

* Wed Feb 12 2014 - Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-Beta
- Fixed an error in the shinken-specific.cfg.erb template.

* Mon Nov 25 2013 - Kendall Moore <kmoore@keywcorp.com> - 4.1.0-Alpha
- Updated service.erb to allow for multiple hosts to be added to one service definition.
- Updated README

* Fri Nov 15 2013 - Kendall Moore <kmoore@keywcorp.com> - 4.1.0-Alpha
- Initial creation.
