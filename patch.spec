Summary:	GNU patch Utilities
Summary(de):	GNU-Patch-Utilities
Summary(es):	Programa de inicialización System V
Summary(fr):	Utilitaires patch de GNU
Summary(pl):	GNU patch
Summary(pt_BR):	Programa de inicialização System V
Summary(tr):	GNU yama yardýmcý programlarý
Name:		patch
Version:	2.5.4
Release:	13
License:	GPL
Group:		Applications/Text
Group(de):	Applikationen/Text
Group(fr):	Utilitaires/Texte
Group(pl):	Aplikacje/Tekst
Source0:	ftp://prep.ai.mit.edu/pub/gnu/patch/%{name}-%{version}.tar.gz
Source1:	%{name}.1.pl
Patch0:		%{name}-stderr.patch
Patch1:		%{name}-suffix.patch
Patch2:		%{name}-ac25x.patch
Patch3:		%{name}-sigsegv.patch
BuildRequires:	autoconf
BuildRequires:	automake
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
Patch is a program to aid in patching programs. You can use it to
apply 'diff's. Basically, you can use diff to note the changes in a
file, send the changes to someone who has the original file, and they
can use 'patch' to combine your changes to their original.

%description -l de
Patch ist ein Programm zum Ausbessern von Programmen. Benutzen Sie
zunächst ein Diffs-Programm, um die Änderungen an der Datei zu
ermitteln und senden Sie diese an die Personen mit der Originaldatei.
Diese können dann mit Hilfe von PATCH ihre Dateien auf den neuesten
Stand bringen.

%description -l es
SysVinit es el primer programa ejecutado por el kernel Linux cuando se
inicia el sistema. Controla arranque, funcionamiento y cierre de todos
los otros programas.

%description -l fr
patch est un programme aidant à patcher des programmes. Vous pouvez
l'utiliser pour appliquer des « diffs ». On utilise diff pour noter
les changements dans un fichier, on envoie ces changements à celui qui
a le fichier original et qui peut utiliser « patch » pour combiner nos
modifications avec son original.

%description -l pl
Patch jest programem umo¿liwiaj±cym nak³adanie ³atek (patchy) na
pliki. Przy pomocy programu diff mo¿esz sprawdziæ jakie zmiany zosta³y
zrobione w pliku, zmiany te wys³aæ do kogo¶, kto posiada oryginalny
plik i przy pomocy programu patch na³o¿yæ je. Daje to mo¿liwo¶æ
rozprowadzania ma³ych plików, w których s± jedynie zmiany, jakie
zosta³y wprowadzone w stosunku do orginalnych plików.

%description -l pt_BR
SysVinit é o primeiro programa executado pelo kernel Linux quando o
sistema é inicializado. Controla inicialização, funcionamento e
finalização de todos os outros programas.

%description -l tr
Bu programý 'diff' komutunu uygulamak için kullanabilirsiniz. diff,
bir dosya içindeki deðiþikliklerý belirtir; 'patch' komutu
deðiþiklikleri asýllarý ile birleþtirir.

%prep
%setup -q
%patch0 -p1
%patch1 -p1
%patch2 -p1
%patch3 -p1

%build
aclocal -I m4
chmod +w configure
autoconf
CFLAGS="%{rpmcflags} -D_GNU_SOURCE"
%configure \
%ifarch sparc sparc64
	--disable-largefile
%endif

%{__make}

%install
rm -rf $RPM_BUILD_ROOT

%{__make} install install-strip \
	bindir=$RPM_BUILD_ROOT%{_bindir} \
	man1dir=$RPM_BUILD_ROOT%{_mandir}/man1

install -d $RPM_BUILD_ROOT%{_mandir}/pl/man1

install %{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/patch.1

gzip -9nf NEWS README AUTHORS ChangeLog

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc *.gz
%attr(755,root,root) %{_bindir}/*
%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*
