#
# Conditional build:
%bcond_without	tests	# "make check"
#
Summary:	GNU patch Utilities
Summary(de.UTF-8):	GNU-Patch-Utilities
Summary(fr.UTF-8):	Utilitaires patch de GNU
Summary(pl.UTF-8):	Program GNU patch
Summary(ru.UTF-8):	Утилита GNU patch, для модификации/апгрейда файлов
Summary(tr.UTF-8):	GNU yama yardımcı programları
Summary(uk.UTF-8):	Утиліта GNU patch, для модифікації/апгрейду файлів
Name:		patch
Version:	2.7.6
Release:	3
License:	GPL v3+
Group:		Applications/Text
Source0:	http://ftp.gnu.org/gnu/patch/%{name}-%{version}.tar.xz
# Source0-md5:	78ad9937e4caadcba1526ef1853730d5
Source1:	%{name}.1.pl
Patch0: patch-2.7.6-avoid-set_file_attributes-sign-conversion-warnings.patch
Patch1: patch-2.7.6-test-suite-compatibility-fixes.patch
Patch2: patch-2.7.6-fix-korn-shell-incompatibility.patch
Patch3: patch-2.7.6-fix-segfault-with-mangled-rename-patch.patch
Patch4: patch-2.7.6-allow-input-files-to-be-missing-for-ed-style-patches.patch
Patch5: patch-CVE-2018-1000156.patch
Patch6: patch-2.7.6-CVE-2019-13638-invoked-ed-directly-instead-of-using-the-shell.patch
Patch7: patch-2.7.6-switch-from-fork-execlp-to-execute.patch
Patch8: patch-2.7.6-cleanups-in-do_ed_script.patch
Patch9: patch-2.7.6-avoid-warnings-gcc8.patch
Patch10: patch-2.7.6-check-of-return-value-of-fwrite.patch
Patch11: patch-2.7.6-fix-ed-style-test-failure.patch
Patch12: patch-2.7.6-dont-leak-temporary-file-on-failed-ed-style-patch.patch
Patch13: patch-2.7.6-dont-leak-temporary-file-on-failed-multi-file-ed-style-patch.patch
Patch14: patch-2.7.6-make-debug-output-more-useful.patch
Patch15: patch-2.7.6-CVE-2018-6952-fix-swapping-fake-lines-in-pch_swap.patch
Patch16: patch-2.7.6-improve_support_for_memory_leak_detection.patch
Patch17: patch-2.7.6-skip-ed-test-when-the-ed-utility-is-not-installed.patch
Patch18: patch-2.7.6-abort_when_cleaning_up_fails.patch
Patch19: patch-2.7.6-crash-RLIMIT_NOFILE.patch
Patch20: patch-2.7.6-CVE-2019-13636-symlinks.patch
Patch21: patch-2.7.6-avoid-invalid-memory-access-in-context-format-diffs.patch
Patch22: patch-2.7.6-CVE-2018-17942.patch
Patch23: patch-2.7.6-failed_assertion.patch
URL:		http://www.gnu.org/software/patch/
BuildRequires:	autoconf >= 2.65
BuildRequires:	automake >= 1:1.11.2
BuildRequires:	attr-devel
%if %{with tests}
BuildRequires:	bash
BuildRequires:	ed
%endif
BuildRequires:	tar >= 1:1.22
BuildRequires:	xz
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
%setup -q
%patch0 -p1 -b .avoid-set_file_attributes-sign-conversion-warnings
%patch1 -p1 -b .test-suite-compatibility-fixes
%patch2 -p1 -b .fix-korn-shell-incompatibility
%patch3 -p1 -b .fix-segfault-with-mangled-rename-patch
%patch4 -p1 -b .allow-input-files-to-be-missing-for-ed-style-patches
%patch5 -p1 -b .CVE-2018-1000156
%patch6 -p1 -b .CVE-2019-13638-invoked-ed-directly-instead-of-using-the-shell
%patch7 -p1 -b .switch-from-fork-execlp-to-execute
%patch8 -p1 -b .cleanups-in-do_ed_script
%patch9 -p1 -b .avoid-warnings-gcc8
%patch10 -p1 -b .check-of-return-value-of-fwrite
%patch11 -p1 -b .fix-ed-style-test-failure
%patch12 -p1 -b .dont-leak-temporary-file-on-failed-ed-style-patch
%patch13 -p1 -b .dont-leak-temporary-file-on-failed-multi-file-ed-style-patch
%patch14 -p1 -b .make-debug-output-more-useful
%patch15 -p1 -b .CVE-2018-6952-fix-swapping-fake-lines-in-pch_swap
%patch16 -p1 -b .improve_support_for_memory_leak_detection
%patch17 -p1 -b .skip-ed-test-when-the-ed-utility-is-not-installed
%patch18 -p1 -b .abort_when_cleaning_up_fails
%patch19 -p1 -b .crash-RLIMIT_NOFILE
%patch20 -p1 -b .CVE-2019-13636-symlinks
%patch21 -p1 -b .avoid-invalid-memory-access-in-context-format-diffs
%patch22 -p1 -b .CVE-2018-17942-gnulib_buffer_overflow
%patch23 -p1 -b .failed_assertion

%build
%{__aclocal} -I m4
%{__autoconf}
%{__autoheader}
%{__automake}
%configure \
%ifarch sparc sparc64
	--disable-largefile \
%endif
	--disable-silent-rules

%{__make}

%if %{with tests}
%{__make} check \
	SHELL=/bin/bash
%endif

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
%attr(755,root,root) %{_bindir}/patch
%{_mandir}/man1/patch.1*
%lang(pl) %{_mandir}/pl/man1/patch.1*
