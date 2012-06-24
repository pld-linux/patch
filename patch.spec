Summary:	GNU patch Utilities
Summary(pl):	GNU patch
Name:		patch
Version:	2.5.3
Release:	5
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
CFLAGS="$RPM_OPT_FLAGS" LDFLAGS="-s" \
./configure %{_target} \
	--prefix=%{_prefix}

make

%install
rm -rf $RPM_BUILD_ROOT

install -d $RPM_BUILD_ROOT{%{_bindir},%{_mandir}/man1}

install -s patch $RPM_BUILD_ROOT%{_bindir}
install patch.man $RPM_BUILD_ROOT%{_mandir}/man1/patch.1

gzip -9nf NEWS README AUTHORS ChangeLog \
	$RPM_BUILD_ROOT%{_mandir}/man1/patch.1

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc {NEWS,README,AUTHORS,ChangeLog}.gz
%attr(755,root,root) %{_bindir}/patch
%{_mandir}/man1/patch.1*

%changelog
* Tue May 25 1999 Tomasz K�oczko <kloczek@rudy.mif.pg.gda.pl>
  [2.5.3-5]
- spec based on RH version,
- rewrited by PLD team,
- pl translation Andrzej Nakonieczny <dzemik@shadow.eu.org>.
