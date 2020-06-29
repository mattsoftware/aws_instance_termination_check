
Name: check_spot
Version: 1
Release: 1
Summary: Script for checking spot instance termination events
License: MIT

%description
Script for checking spot instance termination events

%prep

%build

%install
mkdir -p %{buildroot}/usr/bin
mkdir -p %{buildroot}/etc/systemd/system/
mkdir -p %{buildroot}/etc/check_spot.d/
install -m 755 %{_sourcedir}/check_spot/check_spot.sh %{buildroot}/usr/bin/check_spot
install -m 644 %{_sourcedir}/check_spot/check_spot.conf %{buildroot}/etc/check_spot
install -m 644 %{_sourcedir}/check_spot/check_spot.service %{buildroot}/etc/systemd/system/check_spot.service
install -m 644 %{_sourcedir}/check_spot/check_spot_hook %{buildroot}/etc/check_spot.d/check_spot_hook

%files
/usr/bin/check_spot
/etc/systemd/system/check_spot.service

%config
/etc/check_spot
/etc/check_spot.d/check_spot_hook

%changelog
* Mon Jun 29 2020 Matt Paine <matt@mattsoftware.com>
- Created initial check_spot project and spec file

