Summary:	GNU patch Utilities
Summary(pl):	GNU patch
Name:		patch
Version:	2.5.3
Release:	6
Copyright:	GPL
Group:		Utilities/Text
Group(pl):	Narz�dzia/Tekst
Source:		ftp://prep.ai.mit.edu/pub/gnu/patch/%{name}-%{version}.tar.gz
Buildroot:	/tmp/%{name}-%{version}-root

%description
Patch is a program to aid in patching programs.  :-) You can use it to apply
'diff's.  Basically, you can use diff to note the changes in a file, send
the changes to someone who has the original file, and they can use 'patch'
to combine your changes to their original.

%description -l pl
Patch jest programem umo�liwiaj�cym nak�adanie �atek (patchy) na pliki. Przy
pomocy programu diff mo�esz sprawdzi� jakie zmiany zosta�y zrobione w pliku,
zmiany te wys�a� do kogo�, kto posiada oryginalny plik i przy pomocy programu
patch na�o�y� je. Daje to mo�liwo�� rozprowadzania ma�ych plik�w, w kt�rych
s� jedynie zmiany, jakie zosta�y wprowadzone w stosunku do orginalnych
plik�w.

%prep
%setup -q

%build
chmod +w configure
autoconf

# XXX unset CPPFLAGS on (ultra)sparc to avoid large file system support
%ifarch sparc sparc64
CPPFLAGS=""
export CPPFLAGS
%endif

LDFLAGS="-s"; export LDFLAGS
%configure

make

%install
rm -rf $RPM_BUILD_ROOT

make install install-strip \
	bindir=$RPM_BUILD_ROOT%{_bindir} \
	man1dir=$RPM_BUILD_ROOT%{_mandir}/man1

gzip -9nf $RPM_BUILD_ROOT%{_mandir}/man1/*\
	NEWS README AUTHORS ChangeLog

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc {NEWS,README,AUTHORS,ChangeLog}.gz

%attr(755,root,root) %{_bindir}/*
%{_mandir}/man1/*
