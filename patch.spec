Summary:	GNU patch Utilities
Summary(de):	GNU-Patch-Utilities
Summary(es):	Programa de inicializaciСn System V
Summary(fr):	Utilitaires patch de GNU
Summary(pl):	GNU patch
Summary(pt_BR):	Programa de inicializaГЦo System V
Summary(ru):	Утилита GNU patch, для модификации/апгрейда файлов
Summary(tr):	GNU yama yardЩmcЩ programlarЩ
Summary(uk):	Утил╕та GNU patch, для модиф╕кац╕╖/апгрейду файл╕в
Name:		patch
Version:	2.5.4
Release:	14
License:	GPL
Group:		Applications/Text
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
zunДchst ein Diffs-Programm, um die дnderungen an der Datei zu
ermitteln und senden Sie diese an die Personen mit der Originaldatei.
Diese kЖnnen dann mit Hilfe von PATCH ihre Dateien auf den neuesten
Stand bringen.

%description -l es
SysVinit es el primer programa ejecutado por el kernel Linux cuando se
inicia el sistema. Controla arranque, funcionamiento y cierre de todos
los otros programas.

%description -l fr
patch est un programme aidant Ю patcher des programmes. Vous pouvez
l'utiliser pour appliquer des ╚ diffs ╩. On utilise diff pour noter
les changements dans un fichier, on envoie ces changements Ю celui qui
a le fichier original et qui peut utiliser ╚ patch ╩ pour combiner nos
modifications avec son original.

%description -l pl
Patch jest programem umo©liwiaj╠cym nakЁadanie Ёatek (patchy) na
pliki. Przy pomocy programu diff mo©esz sprawdziФ jakie zmiany zostaЁy
zrobione w pliku, zmiany te wysЁaФ do kogo╤, kto posiada oryginalny
plik i przy pomocy programu patch naЁo©yФ je. Daje to mo©liwo╤Ф
rozprowadzania maЁych plikСw, w ktСrych s╠ jedynie zmiany, jakie
zostaЁy wprowadzone w stosunku do orginalnych plikСw.

%description -l pt_BR
SysVinit И o primeiro programa executado pelo kernel Linux quando o
sistema И inicializado. Controla inicializaГЦo, funcionamento e
finalizaГЦo de todos os outros programas.

%description -l ru
Patch - это программа, которая помогает в модификации файлов. Вы
можете использовать diff для записи модификаций файла, отослать
изменения кому-либо, кто имеет первоначальную версию файла, и адресат
сможет использовать 'patch' для получения его измененной версии.

%description -l tr
Bu programЩ 'diff' komutunu uygulamak iГin kullanabilirsiniz. diff,
bir dosya iГindeki deПiЧikliklerЩ belirtir; 'patch' komutu
deПiЧiklikleri asЩllarЩ ile birleЧtirir.

%description -l uk
Patch - це програма, яка допомога╓ в модиф╕кац╕╖ файл╕в. Ви можете
використовувати diff для запису модиф╕кац╕й якогось файлу, в╕д╕слати
комусь, хто ма╓ ориг╕нальну верс╕ю файлу, цей запис, ╕ адресат зможе,
використовуючи 'patch', отримати в себе модиф╕ковану верс╕ю файлу.

%prep
%setup -q
%patch0 -p1
%patch1 -p1
%patch2 -p1
%patch3 -p1

%build
aclocal -I m4
chmod +w configure
%{__autoconf}
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
