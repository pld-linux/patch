Summary:	GNU patch Utilities
Summary(de):	GNU-Patch-Utilities
Summary(es):	Programa de inicializaci�n System V
Summary(fr):	Utilitaires patch de GNU
Summary(pl):	GNU patch
Summary(pt_BR):	Programa de inicializa��o System V
Summary(ru):	������� GNU patch, ��� �����������/�������� ������
Summary(tr):	GNU yama yard�mc� programlar�
Summary(uk):	���̦�� GNU patch, ��� ����Ʀ��æ�/�������� ���̦�
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
zun�chst ein Diffs-Programm, um die �nderungen an der Datei zu
ermitteln und senden Sie diese an die Personen mit der Originaldatei.
Diese k�nnen dann mit Hilfe von PATCH ihre Dateien auf den neuesten
Stand bringen.

%description -l es
SysVinit es el primer programa ejecutado por el kernel Linux cuando se
inicia el sistema. Controla arranque, funcionamiento y cierre de todos
los otros programas.

%description -l fr
patch est un programme aidant � patcher des programmes. Vous pouvez
l'utiliser pour appliquer des � diffs �. On utilise diff pour noter
les changements dans un fichier, on envoie ces changements � celui qui
a le fichier original et qui peut utiliser � patch � pour combiner nos
modifications avec son original.

%description -l pl
Patch jest programem umo�liwiaj�cym nak�adanie �atek (patchy) na
pliki. Przy pomocy programu diff mo�esz sprawdzi� jakie zmiany zosta�y
zrobione w pliku, zmiany te wys�a� do kogo�, kto posiada oryginalny
plik i przy pomocy programu patch na�o�y� je. Daje to mo�liwo��
rozprowadzania ma�ych plik�w, w kt�rych s� jedynie zmiany, jakie
zosta�y wprowadzone w stosunku do orginalnych plik�w.

%description -l pt_BR
SysVinit � o primeiro programa executado pelo kernel Linux quando o
sistema � inicializado. Controla inicializa��o, funcionamento e
finaliza��o de todos os outros programas.

%description -l ru
Patch - ��� ���������, ������� �������� � ����������� ������. ��
������ ������������ diff ��� ������ ����������� �����, ��������
��������� ����-����, ��� ����� �������������� ������ �����, � �������
������ ������������ 'patch' ��� ��������� ��� ���������� ������.

%description -l tr
Bu program� 'diff' komutunu uygulamak i�in kullanabilirsiniz. diff,
bir dosya i�indeki de�i�iklikler� belirtir; 'patch' komutu
de�i�iklikleri as�llar� ile birle�tirir.

%description -l uk
Patch - �� ��������, ��� ��������� � ����Ʀ��æ� ���̦�. �� ������
��������������� diff ��� ������ ����Ʀ��æ� ������� �����, צĦ�����
������, ��� ��� ���Ǧ������ ���Ӧ� �����, ��� �����, � ������� �����,
�������������� 'patch', �������� � ���� ����Ʀ������ ���Ӧ� �����.

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
