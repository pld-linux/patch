Summary:     GNU patch Utilities
Summary(pl): GNU patch
Name:        patch
Version:     2.5.3
Release:     1
Copyright:   GPL
Group:       Utilities/Text
Source:      ftp://prep.ai.mit.edu/pub/gnu/%{name}-%{version}.tar.gz
Buildroot:   /tmp/%{name}-%{version}-root

%description
Patch is a program to aid in patching programs.  :-) You can use it to apply
'diff's.  Basically, you can use diff to note the changes in a file, send
the changes to someone who has the original file, and they can use 'patch'
to combine your changes to their original.

%description -l pl
Patch jest programem umo¿liwiaj±cy nak³adanie ³atek (patchy) na pliki. Przy
pomocy programu diff mo¿esz sprawdziæ jakie zmiany zosta³y zrobione w pliku,
zmiany te wys³aæ do kogo¶ kto posiada orginalny plik i przy pomocy programu
patch na³o¿yæ je. Daje to mo¿liwo¶æ rozprowadzania ma³ych plików w których
s± jedynie zmiany jakie zosta³y wprowadzone w stosunku do orginalnych
plików.

%prep
%setup -q

%build
CFLAGS="$RPM_OPT_FLAGS" LDFLAGS="-s" ./configure --prefix=/usr
make

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT/usr/{bin,man/man1}

install -s patch $RPM_BUILD_ROOT/usr/bin
install patch.man $RPM_BUILD_ROOT/usr/man/man1/patch.1

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644, root, root, 755)
%doc NEWS README AUTHORS ChangeLog
%attr(755, root, root) /usr/bin/patch
%attr(644, root,  man) /usr/man/man1/patch.1

%changelog
* Wed Sep 23 1998 Andrzej Nakonieczny <dzemik@shadow.eu.org>
  [2.5.3-1d]
- added pl translation.

* Sun May 17 1998 Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
- AUTHORS, ChangeLog added to %doc,
- added -q %setup parameter,
- spec file rewrited for using Buildroot,
- added %clean section,
- added %defattr and %attr macros in %files (allows building package from
  non-root account).

* Mon Jun 02 1997 Erik Troan <ewt@redhat.com>
- built against glibc
