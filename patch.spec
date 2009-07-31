%bcond_without	tests
Summary:	GNU patch Utilities
Summary(de.UTF-8):	GNU-Patch-Utilities
Summary(fr.UTF-8):	Utilitaires patch de GNU
Summary(pl.UTF-8):	Program GNU patch
Summary(ru.UTF-8):	Утилита GNU patch, для модификации/апгрейда файлов
Summary(tr.UTF-8):	GNU yama yardımcı programları
Summary(uk.UTF-8):	Утиліта GNU patch, для модифікації/апгрейду файлів
Name:		patch
Version:	2.5.9
Release:	11
License:	GPL
Group:		Applications/Text
# old/so-called-stable versions in ftp://ftp.gnu.org/gnu/patch/
Source0:	ftp://alpha.gnu.org/gnu/patch/patch-2.5.9-120-g62d03ac.tar.gz
# Source0-md5:	22ca85de7311816d29ece9f6cd7a32a0
Source1:	%{name}.1.pl
URL:		http://www.gnu.org/software/patch/
BuildRequires:	autoconf >= 2.57
BuildRequires:	automake
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
Patch is a program to aid in patching programs. You can use it to
apply 'diff's. Basically, you can use diff to note the changes in a
file, send the changes to someone who has the original file, and they
can use 'patch' to combine your changes to their original.

%description -l de.UTF-8
Patch ist ein Programm zum Ausbessern von Programmen. Benutzen Sie
zunächst ein Diffs-Programm, um die Änderungen an der Datei zu
ermitteln und senden Sie diese an die Personen mit der Originaldatei.
Diese können dann mit Hilfe von PATCH ihre Dateien auf den neuesten
Stand bringen.

%description -l fr.UTF-8
patch est un programme aidant à patcher des programmes. Vous pouvez
l'utiliser pour appliquer des « diffs ». On utilise diff pour noter
les changements dans un fichier, on envoie ces changements à celui qui
a le fichier original et qui peut utiliser « patch » pour combiner nos
modifications avec son original.

%description -l pl.UTF-8
Patch jest programem umożliwiającym nakładanie łatek (patchy) na
pliki. Przy pomocy programu diff można sprawdzić, jakie zmiany zostały
zrobione w pliku, zmiany te wysłać do kogoś, kto posiada oryginalny
plik i przy pomocy programu patch nałożyć je. Daje to możliwość
rozprowadzania małych plików, w których są jedynie zmiany, jakie
zostały wprowadzone w stosunku do oryginalnych plików.

%description -l ru.UTF-8
Patch - это программа, которая помогает в модификации файлов. Вы
можете использовать diff для записи модификаций файла, отослать
изменения кому-либо, кто имеет первоначальную версию файла, и адресат
сможет использовать 'patch' для получения его измененной версии.

%description -l tr.UTF-8
Bu programı 'diff' komutunu uygulamak için kullanabilirsiniz. diff,
bir dosya içindeki değişikliklerı belirtir; 'patch' komutu
değişiklikleri asılları ile birleştirir.

%description -l uk.UTF-8
Patch - це програма, яка допомогає в модифікації файлів. Ви можете
використовувати diff для запису модифікацій якогось файлу, відіслати
комусь, хто має оригінальну версію файлу, цей запис, і адресат зможе,
використовуючи 'patch', отримати в себе модифіковану версію файлу.

%prep
%setup -q -n %{name}-2.5.9-120-g62d03ac

%build
%{__aclocal} -I m4 -I gl/m4
%{__autoconf}
%configure \
%ifarch sparc sparc64
	--disable-largefile
%endif

%{__make}

%{?with_tests:%{__make} check}

%install
rm -rf $RPM_BUILD_ROOT

%{__make} install \
	bindir=$RPM_BUILD_ROOT%{_bindir} \
	man1dir=$RPM_BUILD_ROOT%{_mandir}/man1

install -D %{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/patch.1

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc AUTHORS ChangeLog NEWS README
%attr(755,root,root) %{_bindir}/*
%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*
