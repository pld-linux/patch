.\" 1999 PTM Przemek Borys
.\" aktualizacja PTM/WK/2001-I, wg patch.man P.Eggerta do wersji 2.5.4 (1998)
.\" -*- nroff -*-
.de Id
.ds Dt \\$4
..
.Id $Id$
.ds = \-\^\-
.de Sp
.if t .sp .3
.if n .sp
..
.TH PATCH 1 "21 marca 1998" GNU
.SH NAZWA
patch - do��cz plik r�nicowy do orygina�u
.SH SK�ADNIA
.B patch
.RI [ opcje ]
.RI [ plikoryginalny
.RI [ plikz�at� ]]
.sp
lecz zazwyczaj po prostu
.sp
.BI "patch \-p" "num"
.BI < plikz�at�
.SH OPIS
.B Patch
pobiera plik z �at�, kt�ry mo�e zawiera� jedn� z czterech postaci r�nic,
dawanych przez program
.BR diff (1).
Je�li
.I plikz�at�
jest pomini�ty lub jest my�lnikiem, to �ata b�dzie czytana ze standardowego
wej�cia.
Nast�pnie do��cza te r�nice do pliku oryginalnego, daj�c w efekcie wersj�
za�atan�. Domy�lnie, wersja za�atana jest podstawiana na miejsce orygina�u.
Mo�e te� tworzy� kopie zapasowe zmienianego orygina�u, zob. opcja
.B \-b
lub
.BR \*=backup .
Kopia orygina�u jest zapisywana obok, z rozszerzeniem \*(L".orig\*(R" 
(na systemach nie obs�uguj�cych d�ugich nazw plik�w \*(L"~\*(R").
Posta� nazwy kopii zapasowej mo�na kontrolowa� przez opcje
\fB\-b\fP (\fB\-\-suffix\fP),
\fB\-B\fP (\fB\-\-prefix\fP),
lub
\fB\-V\fP (\fB\-\-version\-control\fP).
.ig
.PP
Je�li plik kopii zapasowej ju� istnieje,
.B patch
tworzy nowy plik zapasowy, zmieniaj�c pierwsz� ma�� liter� ostatniego
komponentu nazwy pliku na du��. Je�li nie ma ju� wi�cej ma�ych liter, usuwa
pierwszy znak z nazwy. Proces ten jest powtarzany, a� nie znajdzie si�
nieistniej�ca nazwa pliku. [WK:??]
..
.PP
Nazwy plik�w do za�atania s� zwykle brane z pliku �aty, ale je�li �atany
b�dzie tylko jeden plik, to mo�na poda� go w wierszu polece� jako
.IR plikoryginalny .
.PP
Podczas uruchamiania, patch pr�buje sam okre�li� rodzaj listingu
r�nicowego. Mo�na to zrobi� te� r�cznie, opcjami
\fB\-c\fP (\fB\*=context\fP),
\fB\-e\fP (\fB\*=ed\fP),
\fB\-n\fP (\fB\*=normal\fP)
lub
\fB\-u\fP (\fB\*=unified\fP).
R�nice typu context (starego rodzaju, nowego rodzaju i unifikowane
(unified)) s� nanoszone na orygina� wprost przez program
.BR patch ,
podczas gdy r�nice
.B ed
s� po prostu przesy�ane poprzez potok do edytora
.BR ed (1).
.PP
.B Patch
pr�buje automatycznie pomin�� wszelkie �mieci znajduj�ce si� przed
fragmentem r�nicowym, dokona� za�atania i znowu pomin�� �mieci, znajduj�ce
si� za r�nic�. Tak wi�c przekazanie 
.BR patchowi ,
r�nicy znajduj�cej si� np. w wiadomo�ci pocztowej, powinno dzia�a�.
Je�li ca�o�� r�nic jest wci�ta o ten sam rozmiar,
lub r�nice kontekstowe zawieraj� linie zako�czone parami \s-1CRLF\s0,
lub s� raz b�d� wielokrotnie zakapsu�kowane przez poprzedzenie ci�giem
"\fB\- \fP" linii zaczynaj�cych si� od "\fB\-\fP", jak podano w RFC 934,
to jest to poprawnie uwzgl�dniane w �ataniu.
.PP
W przypadku r�nic typu context i w mniejszym stopniu r�nic typu normal,
.B patch
potrafi wykry�, kiedy numery linii wymienione w �acie s� nieprawid�owe i
spr�buje znale�� w�a�ciwe miejsce. Jako pierwszy strza�, u�ywany jest numer
linii u�yty w badanym kawa�ku plus lub minus offset u�yty do zaaplikowania
poprzedniego kawa�ka. Je�li nie jest to w�a�ciwe miejsce, nast�pi skanowanie
w prz�d i wstecz w poszukiwaniu zestawu linii odpowiadaj�cego podanemu
kontekstowi.
Na pocz�tek, szukane jest miejsce, do kt�rego pasuj� wszystkie linie fragmentu.
Je�li nie uda si� go znale�� i mamy do czynienia z r�nicami kontekstowymi
a wsp�czynnik `maximum fuzz factor' jest ustawiony na 1 lub wi�cej, to
skanowanie jest powtarzane, lecz teraz ignoruje pierwsz� i ostatni� lini�
kontekstu.
Je�li i to zawiedzie, a wy�ej wymieniony wsp�czynnik jest ustawiony na 2
lub wi�cej, to ignorowane b�d� dwie pierwsze i dwie ostatnie linie.
(Domy�lnym wsp�czynnikiem jest 2.)
Je�li
.B patch
nie mo�e znale�� w�a�ciwego miejsca do zaaplikowania fragmentu r�nicy, to
wstawi go do pliku odrzuce�, kt�ry normalnie ma nazw� pliku wyj�ciowego, z
dopisan� ko�c�wk�
.B \&.rej
(lub
.B #
je�li
.B \&.rej
utworzy�oby zbyt d�ug� nazw� pliku. Je�li dodanie nawet pojedynczego znaku
.B #
powoduje, �e nazwa pliku staje si� za d�uga, to
.B #
zast�puje ostatni znak nazwy).
(Zauwa�, �e odrzucony fragment zostanie wyprodukowany jako r�nica typu
context, niezale�nie od postaci �aty wej�ciowej. Je�li by�a ona typu
normal, wiele kontekst�w b�dzie po prostu pustych.)
Numery linii w pliku odrzuce� mog� by� inne ni� w �acie: odzwierciedlaj� one
przypuszczaln� pozycj� w nowym pliku, do kt�rej prawdopodobnie nale�� 
odrzucone fragmenty.
.PP
Gdy obr�bka fragmentu jest zako�czona, zostaniesz poinformowany, czy
zako�czy�a si� sukcesem, czy te� si� nie powiod�a i w kt�rej linii
(nowego pliku) wg \fBpatch\fRa ten fragment powinien si� znale��.
Je�li jest ona inna od numeru linii, podanego w pliku r�nicowym, zostaniesz
poinformowany o offsecie.
Pojedynczy du�y offset
.I mo�e
by� wskaz�wk�, �e fragment zainstalowano w z�ym
miejscu. Je�li do por�wnania u�yto wsp�czynnika `fuzz factor', to te�
b�dziesz o tym poinformowany, gdy� mo�e to by� podejrzane.
Je�li u�y�e� opcji
.BR \*=verbose ,
zostaniesz te� powiadomiony o fragmentach dopasowanych dok�adnie.
.PP
Je�li w linii komend nie podano �adnego pliku oryginalnego,
.B patch
spr�buje go odgadn�� ze �mieci, zawartych w pliku z r�nic�, stosuj�c
poni�sze zasady.
.LP
Najpierw buduje uporz�dkowan� list� kandydatur wed�ug takich regu�:
.TP 3
.B " \(bu"
Je�li nag��wek jest nag��wkiem r�nicy typu context, nazwa starego i nowego
pliku odczytywana jest z niego. Nazwa pliku jest ignorowana je�li ma za ma�o
uko�nik�w dla opcji
.BI \-p num
lub
.BI \*=strip= num\fR.
Nazwa
.B /dev/null
jest r�wnie� ignorowana.
.TP
.B " \(bu"
Je�li w pocz�tkowych �mieciach jest linia
.B Index:\&
i albo brakuje obu nazw, starego i nowego pliku, albo 
.B patch
dzia�a zgodnie z \s-1POSIX\s0, to pobierana jest nazwa z tej linii.
.TP
.B " \(bu"
W poni�szych regu�ach zak�ada si�, �e rozwa�ane nazwy plik�w s� uporz�dkowane
(stary, nowy, indeks), niezale�nie od kolejno�ci, w jakiej wyst�puj�
w nag��wku.
.LP
Nast�pnie
.B patch
wybiera nazw� pliki z listy potencjalnych nazw:
.TP 3
.B " \(bu"
Je�li kt�ry� z wymienionych plik�w istnieje, to wybierana jest pierwsza
nazwa zgodna z \s-1POSIX\s0, w przeciwnym razie najlepsza.
.TP
.B " \(bu"
Je�eli
.B patch
nie ignoruje \s-1RCS\s0, ClearCase i \s-1SCCS\s0 (zob. opcj�
.BI "\-g\ " num
lub
.BI \*=get= num \fR),
a tak wskazany plik istnieje, ale znaleziono g��wn� (master) pozycj�
\s-1RCS\s0, ClearCase lub \s-1SCCS\s0, wybrany zostanie pierwszy
plik wymieniony w tej pozycji.
.TP
.B " \(bu"
Je�li nie istnieje plik o danej nazwie, nie znaleziono g��wnej pozycji
\s-1RCS\s0, ClearCase lub \s-1SCCS\s0, podano jakie� nazwy,
.B patch
nie stosuje si� do \s-1POSIX\s0, za� �ata wymaga utworzenia pliku, to
wybierana jest najlepsza nazwa wymagaj�ca stworzenia najmniejszej liczby
katalog�w.
.TP
.B " \(bu"
Je�li powy�szy algorytm heurystyczny nie da �adnej nazwy pliku, to
zostaniesz o ni� zapytany.
.\" WK: ze starego:
Poza tym, je�li w prowadz�cych �mieciach znajduje linia \*(L"Prereq: \*(R",
.B patch
spr�buje pobra� pierwsze s�owo z tej linii (zwykle numer wersji) i sprawdzi�
czy istnieje ono w pliku wej�ciowym.
Je�li nie,
.B patch
zapyta o potwierdzenie przed kontynuacj�.
.PP
Efektem tego wszystkiego jest to, �e powiniene� by� w stanie poda� w
interfejsie news�w nast�puj�ce:
.Sp
	| patch -d /usr/src/local/blurfl
.Sp
i tym samym za�ata� katalog blurfl bezpo�rednio z artyku�u, kt�ry zawiera
�at�.
.PP
Je�li plik z �at� sk�ada si� z wi�cej ni� jednej �aty, program
.B patch
spr�buje zaaplikowa� je tak, jakby przysz�y w osobnych plikach z �atami.
Znaczy to mi�dzy innymi tyle, �e nazwa �atanego pliku jest okre�lana dla
ka�dego listingu r�nic z osobna i �e �mieci, znajduj�ce si� przed ka�dym
z listing�w b�d� analizowane jak opisano wy�ej.
Do kolejnych �at mo�na przekazywa� opcje (i inn� oryginaln� nazw� pliku),
oddzielaj�c odpowiadaj�ce listy argument�w znakiem \*(L'+\*(R'.
(Lista argument�w kolejnej �aty nie musi jednak podawa�
nowej nazwy pliku z �at�.)
.SH OPCJE
.TP 3
.BR \-b ", " \*=backup
Tworzy pliki kopii zapasowych.
To znaczy, przy �ataniu pliku, zamiast usuwania orygina�u tworzy jego
kopi� lub zmienia nazw�. Jako kopia zapasowa pliku, kt�ry nie istnia�
tworzony jest pusty plik, zast�pczo reprezentuj�cy nieistniej�cy orygina�.
Spos�b ustalania nazw plik�w kopii zapasowych opisano przy opcjach
.B \-V
lub
.BR \*=version\-control .
.TP
.B \*=backup\-if\-mismatch
Tworzy kopi� zapasow� je�li �ata nie pasuje dok�adnie do pliku a nie za��dano
w inny spos�b tworzenia kopii. Jest to zachowanie domy�lne, chyba �e
.B patch
dzia�a zgodnie z \s-1POSIX\s0.
.TP
.B \*=no\-backup\-if\-mismatch
Nie tworzy kopii zapasowej je�li �ata nie pasuje dok�adnie do pliku
i je�li nie za��dano w inny spos�b tworzenia kopii.
Jest to zachowanie domy�lne gdy
.B patch
dzia�a zgodnie z \s-1POSIX\s0.
.TP
\fB\-B\fP \fIpref\fP, \fB\*=prefix=\fP\fIpref\fP
Poprzedza przedrostkiem
.B pref
nazw� pliku podczas tworzenia nazwy zwyk�ej kopii.
Na przyk�ad, przy
.B "\-B\ /junk/"
nazw� zwyk�ej kopii dla
.B src/patch/util.c
jest
.BR /junk/src/patch/util.c .
.TP
\fB\*=binary\fP
Za wyj�tkiem standardowego wyj�cia i
.BR /dev/tty ,
wszystkie pliki czyta i zapisuje w trybie binarnym.
Opcja ta nie ma �adnych skutk�w na systemach zgodnych z \s-1POSIX\s0.
Na systemach podobnych do \s-1DOS\s0, gdzie ma znaczenie, �ata powinna by�
tworzona przy u�yciu
.BR "diff\ \-a\ \*=binary" .
.TP
\fB\-c\fP,  \fB\*=context\fP
Wymusza interpretacj� pliku z �at� jako r�nicy typu context.
.TP
\fB\-d\fP \fIkat\fP,  \fB\*=directory=\fP\fIkatalog\fP
Powoduje interpretacj�
.B katalogu
jako katalogu, kt�ry ma by� bie��cym i przechodzi do niego przed zrobieniem
czegokolwiek innego.
.TP
\fB\-D\fP \fIsymb\fP,  \fB\*=ifdef=\fP\fIsymb\fP
Powoduje u�ywanie konstrukcji
"#ifdef...#endif" do oznaczania zmian.
.I symb
b�dzie symbolem r�nicuj�cym.
.TP
.B "\*=dry\-run"
Wypisuje wynik �atania bez faktycznego zmieniania plik�w.
.TP
\fB\-e\fP,  \fB\*=ed\fP
Wymusza interpretacj� pliku z �at� jako skryptu
.BR ed .
.TP
\fB\-E\fP,  \fB\*=remove\-empty\-files\fP
Powoduje, �e usuwane s� pliki wyj�ciowe, kt�re po zaaplikowaniu �at s� puste.
Zwykle u�ycie tej opcji nie jest konieczne, gdy� program potrafi zbada�
znaczniki czasu w nag��wku i stwierdzi�, czy po naniesieniu �at plik powinien
istnie�.
Je�li jednak wej�cie nie jest plikiem r�nic kontekstowych lub gdy
.B patch
dzia�a zgodnie z \s-1POSIX\s0, puste za�atane pliki nie b�d� usuwane,
dop�ki nie zostanie podana ta opcja.
Podczas usuwania pliku
.B patch
usi�uje usun�� r�wnie� jego puste katalogi nadrz�dne.
.TP
\fB\-f\fP,  \fB\*=force\fP
Wymusza za�o�enie, �e u�ytkownik dok�adnie wie co robi i powoduje
niezadawanie pyta�. Pomija �aty, z kt�rych nag��wk�w nie wynika, jaki plik
powinien by� za�atany; pliki s� �atane nawet je�li maj� z�� wersj� dla linii
.BR Prereq:\& ;
zak�ada, �e �aty nie s� odwr�cone, nawet je�li tak wygl�daj�.
Opcja ta nie eliminuje komentarzy; do tego u�yj
.BR \-s .
.TP
\fB\-F\fP \fInum\fP,  \fB\*=fuzz=\fP\fInum\fP
Ustawia wsp�czynnik `maximum fuzz factor'.
Opcja ta tyczy si� tylko r�nic typu context i powoduje, �e
.B patch
ignoruje maksymalnie tyle linii, zagl�daj�c w miejsca, gdzie ma zainstalowa�
fragment �aty. Zauwa�, �e du�y wsp�czynnik zwi�ksza prawdopodobie�stwo
nieprawid�owego naniesienia �aty. Domy�ln� warto�ci� jest 2 i nie mo�e by�
ustawiona na wi�cej ni� liczba linii kontekstu w r�nicy, czyli zwykle 3.
.TP
\fB\-g\fP \fInum\fP,  \fB\*=get=\fP\fInum\fP
Steruje akcjami programu
.BR patch
gdy oryginalny plik jest pod kontrol� \s-1RCS\s0 lub \s-1SCCS\s0,
a nie istnieje lub jest przeznaczony tylko dla odczytu.
Tak�e wtedy, gdy jest pod kontrol� ClearCase, a nie istnieje.
Je�eli
.I num
jest dodatnie, to pobiera (get) lub aktualizuje (check out) plik
z danego systemu kontroli wersji (revision control system).
Je�li wynosi zero,
.B patch
ignoruje system kontroli wersji i nie pobiera pliku; je�li
.I num
jest ujemne, to pyta u�ytkownika czy pobra� plik.
Domy�lna warto�� tej opcji okre�lana jest warto�ci� zmiennej �rodowiska
.B PATCH_GET
je�li takowa istnieje; je�li nie, to warto�� domy�lna jest zerem, gdy 
.B patch
dzia�a zgodnie z \s-1POSIX\s0, w przeciwnym razie jest ujemna.
.TP
\fB\-i\fP \fIplik�aty\fP,  \fB\*=input=\fP\fIplik�aty\fP
Odczytuje �at� z
.IR pliku�aty .
Je�li
.I plikiem�aty
jest
.BR \- ,
to ze standardowego wej�cia, domy�lnie.
.TP
\fB\-l\fP,  \fB\*=ignore\-whitespace\fP
Wykonuje swobodniejsze por�wnywanie wzorc�w, w przypadku, gdy w pliku
pozamieniano tabulacje i spacje. Dowolna sekwencja bia�ych spacji (znak�w
tabulacji lub spacji) w linii pliku �aty b�dzie odpowiada� dowolnej sekwencji
bia�ych spacji oryginalnego pliku.
Ci�gi bia�ych spacji wyst�puj�ce na ko�cach linii s� ignorowane.
Normalne znaki musz� wci�� dok�adnie pasowa�. Ka�da linia kontekstu nadal
musi pasowa� do linii oryginalnego pliku.
.TP
\fB\-n\fP,  \fB\*=normal\fP
Powoduje, �e plik z �at� jest interpretowany jak r�nica typu `normal'.
.TP
\fB\-N\fP,  \fB\*=forward\fP
powoduje ignorowanie �at, kt�re wydaj� si� by� odwr�cone lub ju�
zaaplikowane.  Zobacz te�
.BR \-R .
.TP
\fB\-o\fP \fIplik-wyj\fP,  \fB\*=output=\fP\fIplik-wyj\fP
Zamiast �atania bezpo�rednio oryginalnych plik�w, wynik jest kierowany do
.BR plik-wyj .
.TP
\fB\-p\fP\fInum\fP,  \fB\*=strip\fP\fB=\fP\fInum\fP
Z ka�dej nazwy pliku znalezionej w pliku �aty ujmuje najmniejszy przedrostek
zawieraj�cy
.I num
pocz�tkowych uko�nik�w.
Ci�g kilku s�siaduj�cych uko�nik�w liczy si� za jeden uko�nik.
Opcj� przewidziano na wypadek gdyby� przechowywa� pliki w innym katalogu
ni� osoba, kt�ra przes�a�a �at�.
Na przyk�ad, za��my, �e nazwa pliku w �acie mia�a warto��
.sp
	/u/howard/src/blurfl/blurfl.c
.sp
ustawienie
.B \-p
lub
.B \-p0
nie zmienia jej,
.B \-p1
daje
.sp
	u/howard/src/blurfl/blurfl.c
.sp
bez pocz�tkowego uko�nika, a
.B \-p4
daje
.sp
	blurfl/blurfl.c
.sp
natomiast niepodanie 
.B \-p
w og�le, daje po prostu \fBblurfl.c\fP.
Wynik tej operacji jest poszukiwany albo w katalogu bie��cym, albo w katalogu
podanym przez opcj�
.BR \-d .
.TP
.B \*=posix
Post�puje bardziej zgodnie ze standardem \s-1POSIX\s0:
.RS
.TP 3
.B " \(bu"
Dociekaj�c nazw plik�w z nag��wk�w r�nic
z listy (stary, nowy, indeks) bierze pierwszy istniej�cy plik.
.TP
.B " \(bu"
Nie usuwa plik�w, kt�re po za�ataniu staj� si� puste.
.TP
.B " \(bu"
Nie pyta o pobieranie plik�w z \s-1RCS\s0, ClearCase czy \s-1SCCS\s0.
.TP
.B " \(bu"
Wymaga, by w wierszu polece� wszystkie opcje wyst�powa�y przed nazwami plik�w.
.TP
.B " \(bu"
Nie tworzy kopii zapasowych przy wyst�pieniu niezgodno�ci.
.RE
.TP
.BI \*=quoting\-style= wyraz
U�ywa stylu
.I wyraz
do cytowania nazw wyj�ciowych.
.I Wyraz
powinien by� jednym z poni�szych:
.RS
.TP
.B literal
Wypisuje nazwy bez zmian.
.TP
.B shell
Cytuje nazwy dla pow�oki je�li zawieraj� metaznaki pow�oki lub spowodowa�yby
dwuznaczno�� wyniku.
.TP
.B shell-always
Cytuje nazwy dla pow�oki, nawet wtedy, gdy normalnie nie wymaga�yby cytowania.
.TP
.B c
Cytuje nazwy jak dla �a�cuch�w w j�zyku C.
.TP
.B escape
Cytuje jak z
.BR c ,
z wyj�tkiem tego, i� pomija otaczaj�ce znaki cudzys�owu.
.LP
Warto�� domy�ln� opcji
.B \*=quoting\-style
mo�na okre�li� za pomoc� zmiennej �rodowiska
.BR QUOTING_STYLE .
Je�li nie jest ona ustawiona, to warto�ci� domy�ln� jest
.BR shell .
.RE
.TP
\fB\-r\fP \fIplik-odrz\fP,  \fB\*=reject\-file=\fP\fIplik-odrz\fP
Odrzucone poprawki s� umieszczane w zadanym
.BR pliku-odrz ,
a nie w domy�lnym pliku odrzuce�
.BR \&.rej .
.TP
\fB\-R\fP,  \fB\*=reverse\fP
M�wi, �e �ata ta zosta�a utworzona przy zamienionych miejscami starych
i nowych plikach [t�um. zamiast `\fBdiff -c stary nowy\fP' u�yto pomy�kowo
`\fBdiff -c nowy stary\fP'].  
(Tak, obawiam si� �e czasem si� to zdarza, natura ludzka jest jaka jest.)
.B Patch
Spr�buje zamieni� ka�dy fragment przed jego zaaplikowaniem. Odrzucenia wyjd�
w formacie zamienionym (swapped).
Opcja
.B \-R
nie dzia�a ze skryptami r�nicowymi 
.BR ed a
gdy� jest tam zbyt ma�o danych do zrekonstruowania operacji odwrotnej.
.Sp
Je�li pierwszy fragment �aty zawiedzie,
.B patch
odwraca ten fragment, sprawdzaj�c czy nie mo�e by� tak zaaplikowany.
Je�li mo�e, zostaniesz zapytany czy chcesz ustawi� opcj�
.BR \-R .
Je�li nie, �ata b�dzie aplikowana dalej w spos�b tradycyjny.
(Uwaga: metoda ta nie mo�e wykry� �aty odwr�conej je�li jest to r�nica typu
normal i je�li pierwsz� komend� jest doklejanie (append) (tj. powinno to
by� kasowanie \-\- delete). Jest tak dlatego, �e doklejanie zawsze dzia�a, gdy�
pusty kontekst pasuje wsz�dzie.
Szcz�liwym trafem, wiele �at raczej dodaje lub zmienia linie ni� je
kasuje, wi�c wi�kszo�� odwr�conych r�nic typu normal zaczyna si� od
kasowania, co zawiedzie i wywo�a heurystyk�.)
.ig
[A po ludzku: opcja -R umo�liwia anulowanie zaaplikowanej �aty -- przyp.
t�um.]
[Przemku: daje mo�no�� naniesienia *poprawnej* �aty, gdy przy jej tworzeniu
przez pomy�k� podano odwrotnie parametry stary/nowy]
..
.TP
\fB\-s\fP,  \fB\*=silent\fP,  \fB\*=quiet\fP
Powoduje, �e
.B patch
dzia�a cicho, chyba �e pojawi si� b��d.
.TP
\fB\-t\fP,  \fB\*=batch\fP
Podobne do
.BR \-f ,
gdy� eliminuje pytania, lecz dzia�a wed�ug innych za�o�e�:
pomija �aty, kt�rych nag��wki nie zawieraj� nazw plik�w (tak samo jak
\fB\-f\fP), pomija �aty dla plik�w ze z�ymi wersjami
.B Prereq:\&
i przyjmuje, �e �aty s� odwr�cone, je�li na takie wygl�daj�.
.TP
\fB\-T\fP,  \fB\*=set\-time\fP
Ustawia czasy modyfikacji i ostatniego dost�pu za�atanych plik�w wed�ug
znacznik�w czasu podanych w nag��wkach r�nic typu context, zak�adaj�c, �e
nag��wki te stosuj� czas lokalny.  Opcja ta jest niezalecana, gdy� u�ycie
�at korzystaj�cych z czasu lokalnego przez osoby z innych stref czasowych
nie jest �atwe.
Ponadto znaczniki czasu lokalnego nie s� jednoznaczne w przypadku, gdy zegar
lokalny jest cofany w zwi�zku z dostosowywaniem do czasu letniego.
Zamiast tej opcji, powinno si� tworzy� �aty z czasem uniwersalnym
(\s-1UTC\s0) i stosowa� opcj�
.B \-Z
lub
.BR \*=set\-utc .
.TP
\fB\-u\fP,  \fB\*=unified\fP
Wymusza interpretacj� �aty jako r�nicy typu unified context (zunifikowana
r�nica kontekstowa).
.TP
\fB\-V\fP \fImetoda\fP,  \fB\*=version\-control=\fP\fImetoda\fP
.B "\-V metoda, \-\-version\-\-control=metoda"
Powoduje, �e
.B metoda
staje si� metod� tworzenia nazw plik�w zapasowych. Rodzaje robionych kopii
zapasowych mo�na r�wnie� poda� w zmiennej �rodowiskowej
.B PATCH_VERSION_CONTROL
(lub, je�li nie jest ustawiona, zmienn�
.BR VERSION_CONTROL ),
kt�ra jest przes�aniana przez t� opcj�.
Wybrana metoda nie ma wp�ywu na to, czy kopie zapasowe b�d� wykonywane,
i w jakich przypadkach.  Okre�la tylko spos�b tworzenia nazw plik�w
zapasowych.
Warto��
.I metody
jest podobna jak zmiennej `version-control' \s-1GNU\s0 Emacsa.
.B Patch
rozpoznaje te� ich bardziej opisowe synonimy.
Poprawne warto�ci to
(przyjmowane s� rozr�nialne skr�ty):
.RS
.TP 3
\fBnumbered\fP  lub  \fBt\fP
Tworzy zawsze numerowane kopie zapasowe.  Nazw� numerowanej kopii zapasowej
pliku
.I F
jest
.IB F .~ N ~
gdzie
.I N
to numer wersji.
.TP
\fBexisting\fP  lub  \fBnil\fP
Tworzy numerowane kopie zapasowe plik�w, kt�re ju� je maj�, a zwyk�e kopie
dla pozosta�ych. Tak jest domy�lnie.
.TP
`never' lub `simple'
Zawsze robi zwyk�e kopie zapasowe.
Opcje
.B \-B
lub
.BR \*=prefix ,
.B \-Y
lub
.BR \*=basename\-prefix
i
.B \-z
lub
.BR \*=suffix
okre�laj� nazw� pliku zwyk�ej kopii zapasowej.
Je�eli nie podano �adnej z nich, to stosowany jest przyrostek zwyk�ej
kopii zapasowej.  Jest to warto�� zmiennej �rodowiska
.BR SIMPLE_BACKUP_SUFFIX ,
je�li jest ona ustawiona, lub
.B \&.orig
w przeciwnym razie.
.PP
Przy kopiach numerowanych lub zwyk�ych, je�li nazwa pliku kopii zapasowej
jest zbyt d�uga, to zamiast niej u�ywa si� przyrostka kopii
.BR ~ .
Je�eli nawet dodanie
.B ~
spowodowa�oby, �e nazwa b�dzie za d�uga, to
.B ~
zast�puje ostatni znak nazwy pliku.
.RE
.TP
\fB\*=verbose\fP
Wypisuje dodatkowe informacje o wykonywanej pracy.
.TP
\fB\-x\fP \fInum\fP,  \fB\*=debug=\fP\fInum\fP
ustawia wewn�trzne flagi debuggowe. Ma to znaczenie tylko dla �ataczy
programu
.BR patch .
.TP
\fB\-Y\fP \fIpref\fP,  \fB\*=basename\-prefix=\fP\fIpref\fP
Przy tworzeniu nazwy zwyk�ej kopii poprzedza przedrostkiem
.I pref
podstawow� cz�� nazwy pliku.
Na przyk�ad, przy
.B "\-Y\ .del/"
nazw� pliku zwyk�ej kopii zapasowej dla
.B src/patch/util.c
jest
.BR src/patch/.del/util.c .
.TP
\fB\-z\fP \fIsuffix\fP,  \fB\*=suffix=\fP\fIsuffix\fP
Powoduje, �e
.B suff
jest interpretowane jako przyrostek nazw zwyk�ych kopii zapasowych.
Na przyk�ad, przy
.B "\-z\ -"
nazw� pliku zwyk�ej kopii kopii dla
.B src/patch/util.c
jest
.BR src/patch/util.c- .
Przyrostek kopii mo�na te� okre�li� za pomoc� zmiennej �rodowiska
.BR SIMPLE_BACKUP_SUFFIX ,
kt�ra jest przes�aniana przez t� opcj�.
.TP
\fB\-Z\fP,  \fB\*=set\-utc\fP
Ustawia czasy modyfikacji i ostatniego dost�pu za�atanych plik�w wed�ug
znacznik�w czasu podanych w nag��wkach r�nic typu context, zak�adaj�c, �e
nag��wki te stosuj� czas uniwersalny - Coordinated Universal Time
(\s-1UTC\s0, znany te� jako czas �redni Greenwich \s-1GMT\s0).
Zobacz te� opcja
.B \-T
lub
.BR \*=set\-time .
.Sp
Opcje
.B \-Z
lub
.B \*=set\-utc
i
.B \-T
lub
.B \*=set\-time
normalnie powstrzymuj� si� od ustawiania czasu pliku je�li jego
oryginalny czas nie pasuje do czasu podanego w nag��wku �aty lub jej
zawarto�� nie pasuje dok�adnie do �aty.  Jednak, je�li podano opcj�
.B \-f
lub
.BR \*=force,
to czas pliku jest ustawiany bez wzgl�du na niezgodno�ci.
.Sp
Z powodu ogranicze� formatu wyj�ciowego stosowanego przez
.BR diff ,
opcje te nie potrafi� aktualizowa� czas�w plik�w, kt�rych zawarto�� si� nie
zmieni�a.  Wykorzystuj�c te opcje powinno si� pami�ta� o usuni�ciu
(np. za pomoc�
.BR "make\ clean" )
wszystkich plik�w, kt�re zale�� od za�atanych, by p�niejsze wywo�ania
.B make
nie zosta�y zmylone czasem za�atanych plik�w.
.TP
.B "\*=help"
Wypisuje list� opcji i ko�czy dzia�anie.
.TP
\fB\-v\fP,  \fB\*=version\fP
Wypisuje wersj� programu i ko�czy dzia�anie.
.SH �RODOWISKO
.TP 3
.B PATCH_GET
Okre�la, czy
.B patch
powinien domy�lnie pobiera� brakuj�ce lub przeznaczone tylko do odczytu
pliki z \s-1RCS\s0, ClearCase lub \s-1SCCS\s0. Zobacz opis opcji
.B \-g
lub
.BR \*=get .
.TP
.B POSIXLY_CORRECT
Je�li jest ustawiona,
.B patch
�ci�lej stosuje si� do standardu \s-1POSIX\s0 w zachowaniu domy�lnym.
Zobacz opis opcji
.BR \*=posix .
.TP
.B QUOTING_STYLE
Domy�lna warto�� opcji
.BR \*=quoting\-style .
.TP
.B SIMPLE_BACKUP_SUFFIX
Przyrostek stosowany do tworzenia nazw plik�w zwyk�ych kopii zapasowych
.BR \&.orig .
.TP
\fBTMPDIR\fP, \fBTMP\fP, \fBTEMP\fP
Katalog do przechowywania plik�w tymczasowych.
.B patch
wykorzystuje pierwsz� zmienn� �rodowiska z tej listy, jaka jest ustawiona.
Je�li �adna nie jest, warto�� domy�lna zale�y od systemu: normalnie
na maszynach uniksowych jest to
.BR /tmp .
.TP
\fBVERSION_CONTROL\fP lub \fBPATCH_VERSION_CONTROL\fP
Wybiera metod� kontroli wersji kopii pliku; zobacz opcja
.B \-v
lub
.BR \*=version\-control .
.SH PLIKI
.TP 3
.IB $TMPDIR "/p\(**"
pliki tymczasowe
.TP
.B /dev/tty
terminal steruj�cy; u�ywany do uzyskania odpowiedzi na pytania
zadawane u�ytkownikowi.
.SH ZOBACZ TAK�E
.BR diff (1)
.BR ed (1).
.Sp
Marshall T. Rose and Einar A. Stefferud,
Proposed Standard for Message Encapsulation,
Internet RFC 934 <URL:ftp://ftp.isi.edu/in-notes/rfc934.txt> (1985-01).
.SH UWAGI DLA WYSY�AJ�CYCH �ATY
Istnieje kilka rzeczy, o kt�rych nale�y pami�ta� przy wysy�aniu �at.
.PP
Tw�rz �at� wed�ug sprawdzonego schematu.
Dobr� metod� jest polecenie
.BI "diff\ \-Naur\ " "stary\ nowy"
gdzie
.I stary
i
.I nowy
identyfikuj� stary i nowy katalog.
Nazwy
.I stary
i
.I nowy
nie powinny zawiera� �adnych uko�nik�w.
Nag��wki z polece�
.B diff
powinny zawiera� daty i czasy czasu uniwersalnego (UTC) z zastosowaniem
tradycyjnego formatu uniksowego, by odbiorcy �aty mogli skorzysta� z opcji
.B \-Z
lub
.BR \*=set\-utc .
Oto przyk�adowe polecenie, z u�yciem sk�adni pow�oki Bourne'a:
.Sp
	\fBLC_ALL=C TZ=UTC0 diff \-Naur gcc\-2.7 gcc\-2.8\fP
.PP
Powiadom odbiorc�w, jak zaaplikowa� �at�, wskazuj�c, do kt�rego katalogu
przej��
.BR cd
i jakich opcji 
.B patch
u�y�.  Zalecany jest �a�cuch opcji
.BR "\-Np1" .
Wypr�buj procedur� stawiaj�c si� na miejscu odbiorcy i stosuj�c �at�
na kopi� oryginalnych plik�w.
.PP
Mo�esz oszcz�dzi� ludziom wielu problem�w, zachowuj�c plik
.B patchlevel.h
Jest on �atany aby zwi�kszy� poziom �aty (patch
level).
Umie�� go jako pierwsz� r�nic� w pliku z �at�, kt�ry wysy�asz.
Je�li do �aty wstawisz lini�
.BR Prereq:\& ,
to nie pozwoli ona na stosowanie �at poza kolejno�ci� bez ostrze�enia.
.PP
Mo�esz utworzy� plik u odbiorcy wysy�aj�c mu r�nic� z por�wnania
.B /dev/null
lub pusty plik o dacie r�wnej Epoce (1970-01-01 00:00:00 \s-1UTC\s0)
z plikiem, kt�ry chcesz stworzy�.
Zadzia�a to tylko je�li plik taki jeszcze nie istnieje w katalogu docelowym.
I odwrotnie, mo�esz usun�� plik wysy�aj�c r�nic� kontekstow� por�wnuj�c�
plik do usuni�cia z pustym plikiem datowanym na Epok�.
Plik nie zostanie usuni�ty je�li
.B patch
dzia�a zgodnie z \s-1POSIX\s0 a nie podano opcji
.B \-E
lub
.BR \*=remove\-empty\-files .
Prost� metod� generowania �at, kt�re tworz� i usuwaj� pliki jest u�ycie
opcji
.B \-N
lub
.B \*=new\-file
programu
\s-1GNU\s0
.BR diff .
Je�li spodziewasz si�, �e odbiorca u�yje opcji
.BI \-p N \fR,
nie wysy�aj wyj�cia wygl�daj�cego tak:
.Sp
.ft B
.ne 3
	diff \-Naur v2.0.29/prog/README prog/README
.br
	\-\^\-\^\- v2.0.29/prog/README   Mon Mar 10 15:13:12 1997
.br
	+\^+\^+ prog/README   Mon Mar 17 14:58:22 1997
.ft
.Sp
bo obie nazwy plik�w maj� r�n� liczb� uko�nik�w, a rozmaite wersje
.B patch
r�nie interpretuj� nazwy plik�w.
Unikniesz mylnej interpretacji, wysy�aj�c zamiast tego takie wyj�cie:
.Sp
.ft B
.ne 3
	diff \-Naur v2.0.29/prog/README v2.0.30/prog/README
.br
	\-\^\-\^\- v2.0.29/prog/README   Mon Mar 10 15:13:12 1997
.br
	+\^+\^+ v2.0.30/prog/README   Mon Mar 17 14:58:22 1997
.ft
.Sp
.PP
Unikaj wysy�ania �at por�wnuj�cych pliki o takich nazwach, jakie maj� kopie
zapasowe, jak np.
.BR README.orig ,
gdy� mo�e to zmyli�
.BR patch ,
tak �e b�dzie nak�ada� �at� na plik kopii zamiast na rzeczywisty plik.
Zamiast tego powiniene� wysy�a� �aty por�wnuj�ce pliki o takich samych
nazwach podstawowych, po�o�one w r�nych katalogach, np.\&
.B old/README
i
.BR new/README .
.PP
Uwa�aj by nie wysy�a� �at odwrotnych, gdy� powoduje to, �e ludzie
zastanawiaj� si� czy ju� za��czyli �at�.
.PP
Nie pr�buj budowa� �at, kt�re zmienia�y by pliki pochodne (np. plik
.BR configure ,
w kt�rym jest linia
.B "configure: configure.in"
w swoim makefile), poniewa� odbiorca i tak powinien by� w stanie
je odtworzy�.  Je�li musisz wys�a� r�nice plik�w pochodnych, utw�rz je
u�ywaj�c czasu uniwersalnego \s-1UTC\s0;  odbiorcy powinni zaaplikowa� ��t�
stosuj�c opcj�
.B \-Z
lub
.BR \*=set\-utc ,
a nast�pnie usun�� wszystkie nie�atane pliki, kt�re zale�� od w�a�nie
za�atanych (np. za pomoc�
.BR "make\ clean" ).
.PP
Mimo i� mo�na umie�ci� 582 listing�w r�nic w jednym pliku, to
lepiej wstawi� grupy powi�zanych �at do osobnych plik�w.
.PP
Poza tym, upewnij si�, �e poda�e� poprawnie nazwy plik�w, zar�wno w nag��wku
r�nicy kontekstowej, jak i w linii
.BR Index:\& .
Je�li �atasz co� w podkatalogu,
upewnij si�, �e powiadomi�e� u�ytkownika, by poda� opcj�
.BR \-p .
.SH DIAGNOSTYKA
Zbyt wiele by tu wymienia�, lecz og�lnie wskazuj�, �e
.B patch
nie m�g� przetworzy� pliku z �at�.
.PP
Je�li podano opcj�
.BR \*=verbose ,
komunikat
.B Hmm.\|.\|.\&
wskazuje, �e w pliku z �at� jest nieprzetworzony tekst i �e
.B patch
pr�buje domy�li� si�, czy znajduje si� w nim �ata, a je�li tak, to jakiego
jest rodzaju.
.PP
.B Patch
ko�czy prac� z kodem
0 je�li wszystkie kawa�ki zaaplikowano poprawnie,
1 je�li jakie� nie mog�y by� zaaplikowane,
a 2 w przypadku powa�niejszych k�opot�w.
Podczas aplikowania zbioru �at w p�tli, umo�liwia ci sprawdzenie tego kodu,
tak by nie do��cza� ju� reszty �at do cz�ciowo po�atanego pliku.
.SH ZASTRZE�ENIA
R�nice kontekstowe nie mog� wiarygodnie odwzorowywa� tworzenia lub usuwania
pustych plik�w, pustych katalog�w czy plik�w specjalnych, jak dowi�zania
symboliczne.  Nie potrafi� te� reprezentowa� zmian w metadanych pliku, takich
jak w�a�ciciel, grupa, prawa czy to, �e jeden plik jest twardym dowi�zaniem
do drugiego.
Je�li takie zmiany s� r�wnie� wymagane, �acie powinny towarzyszy� osobne
instrukcje (np. w postaci skryptu pow�oki).
.PP
.B Patch
nie potrafi stwierdzi�, czy w skrypcie
.B ed
nie istniej� numery linii,
a w normalnych r�nicach mo�e wykry� niew�a�ciwe numery tylko gdy odnajdzie
zmian� lub usuni�cie.
R�nica kontekstowa, u�ywaj�ca wsp�czynnika `fuzz factor' 3 mo�e mie�
podobne problemy. Dop�ki nie zostanie dodany w�a�ciwy interaktywny interfejs
u�ytkownika, powiniene� raczej w tych wypadkach robi� r�nice typu context.
Zobaczysz czy zmiany maj� sens. Oczywi�cie kompilowanie bez b��d�w jest
ca�kiem dobrym wskazaniem, �e �ata zadzia�a�a, lecz nie jest to zawsze
prawda.
.PP
.B Patch
zwykle daje prawid�owe wyniki, nawet gdy musi du�o zgadywa�. Jednak
rezultaty maj� gwarancj� prawid�owo�ci tylko wtedy, gdy �aty aplikowane s� do
dok�adnie tej samej wersji pliku, z kt�rej zosta�y wygenerowane.
.SH "KWESTIE ZGODNO�CI"
Standard \s-1POSIX\s0 podaje zachowanie, kt�re r�ni si� od tradycyjnego
zachowania si�
.BR patch a.
Powiniene� pami�ta� o tych r�nicach je�li musisz wsp�pracowa� z
.B patch
w wersji 2.1 lub wcze�niejszymi, kt�re nie s� zgodne z \s-1POSIX\s0.
.TP 3
.B " \(bu"
W tradycyjnym
.BR patch u
argument opcji
.B \-p
by� opcjonalny, a go�e
.B \-p
by�o r�wnowa�ne
.BR \-p0 .
Obecnie opcja
.B \-p
wymaga argumentu, a
.B "\-p\ 0"
jest teraz r�wnowa�nikiem
.BR \-p0 .
Dla zachowania maksymalnej zgodno�ci, stosuj opcje typu
.B \-p0
i
.BR \-p1 .
.Sp
Ponadto, tradycyjny
.B patch
po prostu zlicza uko�niki przy obcinaniu przedrostk�w �cie�kowych;
.B patch
liczy obecnie sk�adowe nazwy pliku.
To znaczy, ci�g s�siaduj�cych uko�nik�w liczy si� obecnie za jeden uko�nik.
Dla zachowania maksymalnej zgodno�ci, unikaj wysy�ania �at zawieraj�cych
.B //
w nazwach plik�w.
.TP
.B " \(bu"
W tradycyjnym
.BR patch u,
tworzenie kopii zapasowych by�o w��czone domy�lnie.
Zachowanie to jest teraz w��czane opcj�
.B \-b
lub
.BR \*=backup .
.Sp
I odwrotnie, w \s-1POSIX\s0-owym
.BR patch ,
kopie nigdy nie s� tworzone, nawet je�li wyst�pi niedopasowanie �aty.
W \s-1GNU\s0
.BR patch ,
zachowanie to jest w��czane opcj�
.B \*=no\-backup\-if\-mismatch
lub przez w��czenie zgodno�ci z \s-1POSIX\s0 opcj�
.B \*=posix
albo ustawieniem zmiennej �rodowiska
.BR POSIXLY_CORRECT .
.Sp
Opcja
.BI \-b "\ suffix"
tradycyjnego
.BR patch
jest r�wnowa�na opcjom
.BI "\-b\ \-z" "\ suffix"
dla \s-1GNU\s0
.BR patch .
.TP
.B " \(bu"
Tradycyjny
.B patch
stosuje skomplikowan� (i nie w pe�ni udokumentowan�) metod� domy�lania si�
z nag��wka �aty nazwy pliku do za�atania.
Metoda ta nie jest zgodna z \s-1POSIX\s0 i ma kilka niepoprawnie zakodowanych
fragment�w [gotchas].
Obecny
.B patch
korzysta z innej, r�wnie skomplikowanej (ale lepiej udokumentowanej) metody,
kt�ra jest opcjonalnie zgodna z \s-1POSIX\s0; mamy nadziej�, �e ma mniej
b��d�w. Obie te metody s� ze sob� zgodne je�li nazwy plik�w w nag��wku
r�nicy kontekstowej i w linii
.B Index:\&
po obci�ciu przedrostka s� identyczne.
Normalnie �ata jest zgodna je�li wszystkie nazwy plik�w w nag��wku zawieraj�
t� sam� liczb� uko�nik�w.
.TP
.B " \(bu"
Gdy tradycyjny
.B patch
zadawa� u�ytkownikowi pytanie, kierowa� je na standardowe wyj�cie b��d�w
i oczekiwa� odpowiedzi z pierwszego pliku poni�szej listy b�d�cego
terminalem:
standardowe wyj�cie b��d�w, standardowe wyj�cie,
.BR /dev/tty ,
i standardowe wej�cie.
Teraz
.B patch
wysy�a pytania na standardowe wyj�cie i pobiera odpowiedzi z
.BR /dev/tty .
Zmieniono domy�lne odpowiedzi na niekt�re z pyta�.  Dzi�ki temu
.B patch
nigdy nie wchodzi w niesko�czon� p�tl� przy stosowaniu domy�lnych
odpowiedzi.
.TP
.B " \(bu"
Tradycyjny
.B patch
ko�czy� dzia�anie z kodem r�wnym liczbie b��dnych fragment�w, albo z kodem 1
je�li napotkano powa�ny problem.
Obecnie
.B patch
ko�czy dzia�anie z kodem 1 je�li nie uda�o si� zaaplikowa� jakich�
fragment�w, albo 2 je�li napotkano powa�ny problem.
.TP
.B " \(bu"
Wysy�aj�c instrukcje okre�laj�ce spos�b skorzystania z �aty
przez kogo� pracuj�cego z
\s-1GNU\s0
.BR patch ,
tradycyjnym
.BR patch em,
lub
.B patch em
zgodnym z \s-1POSIX\s0 ogranicz si� do podanych ni�ej opcji.
W tym zestawieniu spacje s� znacz�ce, a argumenty wymagane.
.Sp
.nf
.in +3
.ne 11
.B \-c
.BI \-d " kat"
.BI \-D " symb"
.B \-e
.B \-l
.B \-n
.B \-N
.BI \-o " plik-wyj"
.BI \-p num
.B \-R
.BI \-r " plik-odrz"
.in
.fi
.SH B��DY
Zg�oszenia b��d�w prosz� wysy�a� do
.BR <bug-gnu-utils@gnu.org> .
.PP
M�g�by by� sprytniejszy co do cz�ciowych trafie�, nadmiernie odbiegaj�cych
od normy offset�w i zamienionego kodu, lecz wymaga�oby to dodatkowego
przebiegu.
.PP
Je�li kod zosta� powielony (np. #ifdef STARYKOD ... #else ... #endif),
.I patch
nie mo�e za�ata� obu wersji, i je�li w og�le zadzia�a, prawdopodobnie za�ata
niew�a�ciw� i powie, �e uda�o mu si� z obydwiema.
.PP
Je�li aplikujesz �at�, kt�r� ju� zaaplikowa�e�,
.I patch
pomy�li �e jest to odwrotna �ata i zaoferuje zdj�cie �aty.
Mo�na to uwa�a� za zaprojektowan� funkcj� programu.
.rn }` ''
.SH KOPIOWANIE
Copyright
.if t \(co
1984, 1985, 1986, 1988 Larry Wall.
.br
Copyright
.if t \(co
1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998
Free Software Foundation, Inc.
.PP
Permission is granted to make and distribute verbatim copies of
this manual provided the copyright notice and this permission notice
are preserved on all copies.
.PP
Permission is granted to copy and distribute modified versions of this
manual under the conditions for verbatim copying, provided that the
entire resulting derived work is distributed under the terms of a
permission notice identical to this one.
.PP
Permission is granted to copy and distribute translations of this
manual into another language, under the above conditions for modified
versions, except that this permission notice may be included in
translations approved by the copyright holders instead of in
the original English.
.SH AUTORZY
Larry Wall napisa� pierwotn� wersj�
.BR patch a.
Paul Eggert usun�� istniej�ce w programie arbitralne ograniczenia.
Doda� obs�ug� plik�w binarnych, ustawianie czas�w pliku i usuwanie plik�w,
i uczyni� go bardziej zgodnym z \s-1POSIX\s0-em.
Sw�j wk�ad wnie�li te� Wayne Davison, kt�ry doda� obs�ug� formatu unidiff,
i David MacKenzie, kt�ry do�o�y� obs�ug� ustawie� i kopii zapasowych.
