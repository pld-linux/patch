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
patch - do³±cz plik ró¿nicowy do orygina³u
.SH SK£ADNIA
.B patch
.RI [ opcje ]
.RI [ plikoryginalny
.RI [ plikz³at± ]]
.sp
lecz zazwyczaj po prostu
.sp
.BI "patch \-p" "num"
.BI < plikz³at±
.SH OPIS
.B Patch
pobiera plik z ³at±, który mo¿e zawieraæ jedn± z czterech postaci ró¿nic,
dawanych przez program
.BR diff (1).
Je¶li
.I plikz³at±
jest pominiêty lub jest my¶lnikiem, to ³ata bêdzie czytana ze standardowego
wej¶cia.
Nastêpnie do³±cza te ró¿nice do pliku oryginalnego, daj±c w efekcie wersjê
za³atan±. Domy¶lnie, wersja za³atana jest podstawiana na miejsce orygina³u.
Mo¿e te¿ tworzyæ kopie zapasowe zmienianego orygina³u, zob. opcja
.B \-b
lub
.BR \*=backup .
Kopia orygina³u jest zapisywana obok, z rozszerzeniem \*(L".orig\*(R" 
(na systemach nie obs³uguj±cych d³ugich nazw plików \*(L"~\*(R").
Postaæ nazwy kopii zapasowej mo¿na kontrolowaæ przez opcje
\fB\-b\fP (\fB\-\-suffix\fP),
\fB\-B\fP (\fB\-\-prefix\fP),
lub
\fB\-V\fP (\fB\-\-version\-control\fP).
.ig
.PP
Je¶li plik kopii zapasowej ju¿ istnieje,
.B patch
tworzy nowy plik zapasowy, zmieniaj±c pierwsz± ma³± literê ostatniego
komponentu nazwy pliku na du¿±. Je¶li nie ma ju¿ wiêcej ma³ych liter, usuwa
pierwszy znak z nazwy. Proces ten jest powtarzany, a¿ nie znajdzie siê
nieistniej±ca nazwa pliku. [WK:??]
..
.PP
Nazwy plików do za³atania s± zwykle brane z pliku ³aty, ale je¶li ³atany
bêdzie tylko jeden plik, to mo¿na podaæ go w wierszu poleceñ jako
.IR plikoryginalny .
.PP
Podczas uruchamiania, patch próbuje sam okre¶liæ rodzaj listingu
ró¿nicowego. Mo¿na to zrobiæ te¿ rêcznie, opcjami
\fB\-c\fP (\fB\*=context\fP),
\fB\-e\fP (\fB\*=ed\fP),
\fB\-n\fP (\fB\*=normal\fP)
lub
\fB\-u\fP (\fB\*=unified\fP).
Ró¿nice typu context (starego rodzaju, nowego rodzaju i unifikowane
(unified)) s± nanoszone na orygina³ wprost przez program
.BR patch ,
podczas gdy ró¿nice
.B ed
s± po prostu przesy³ane poprzez potok do edytora
.BR ed (1).
.PP
.B Patch
próbuje automatycznie pomin±æ wszelkie ¶mieci znajduj±ce siê przed
fragmentem ró¿nicowym, dokonaæ za³atania i znowu pomin±æ ¶mieci, znajduj±ce
siê za ró¿nic±. Tak wiêc przekazanie 
.BR patchowi ,
ró¿nicy znajduj±cej siê np. w wiadomo¶ci pocztowej, powinno dzia³aæ.
Je¶li ca³o¶æ ró¿nic jest wciêta o ten sam rozmiar,
lub ró¿nice kontekstowe zawieraj± linie zakoñczone parami \s-1CRLF\s0,
lub s± raz b±d¼ wielokrotnie zakapsu³kowane przez poprzedzenie ci±giem
"\fB\- \fP" linii zaczynaj±cych siê od "\fB\-\fP", jak podano w RFC 934,
to jest to poprawnie uwzglêdniane w ³ataniu.
.PP
W przypadku ró¿nic typu context i w mniejszym stopniu ró¿nic typu normal,
.B patch
potrafi wykryæ, kiedy numery linii wymienione w ³acie s± nieprawid³owe i
spróbuje znale¼æ w³a¶ciwe miejsce. Jako pierwszy strza³, u¿ywany jest numer
linii u¿yty w badanym kawa³ku plus lub minus offset u¿yty do zaaplikowania
poprzedniego kawa³ka. Je¶li nie jest to w³a¶ciwe miejsce, nast±pi skanowanie
w przód i wstecz w poszukiwaniu zestawu linii odpowiadaj±cego podanemu
kontekstowi.
Na pocz±tek, szukane jest miejsce, do którego pasuj± wszystkie linie fragmentu.
Je¶li nie uda siê go znale¼æ i mamy do czynienia z ró¿nicami kontekstowymi
a wspó³czynnik `maximum fuzz factor' jest ustawiony na 1 lub wiêcej, to
skanowanie jest powtarzane, lecz teraz ignoruje pierwsz± i ostatni± liniê
kontekstu.
Je¶li i to zawiedzie, a wy¿ej wymieniony wspó³czynnik jest ustawiony na 2
lub wiêcej, to ignorowane bêd± dwie pierwsze i dwie ostatnie linie.
(Domy¶lnym wspó³czynnikiem jest 2.)
Je¶li
.B patch
nie mo¿e znale¼æ w³a¶ciwego miejsca do zaaplikowania fragmentu ró¿nicy, to
wstawi go do pliku odrzuceñ, który normalnie ma nazwê pliku wyj¶ciowego, z
dopisan± koñcówk±
.B \&.rej
(lub
.B #
je¶li
.B \&.rej
utworzy³oby zbyt d³ug± nazwê pliku. Je¶li dodanie nawet pojedynczego znaku
.B #
powoduje, ¿e nazwa pliku staje siê za d³uga, to
.B #
zastêpuje ostatni znak nazwy).
(Zauwa¿, ¿e odrzucony fragment zostanie wyprodukowany jako ró¿nica typu
context, niezale¿nie od postaci ³aty wej¶ciowej. Je¶li by³a ona typu
normal, wiele kontekstów bêdzie po prostu pustych.)
Numery linii w pliku odrzuceñ mog± byæ inne ni¿ w ³acie: odzwierciedlaj± one
przypuszczaln± pozycjê w nowym pliku, do której prawdopodobnie nale¿± 
odrzucone fragmenty.
.PP
Gdy obróbka fragmentu jest zakoñczona, zostaniesz poinformowany, czy
zakoñczy³a siê sukcesem, czy te¿ siê nie powiod³a i w której linii
(nowego pliku) wg \fBpatch\fRa ten fragment powinien siê znale¼æ.
Je¶li jest ona inna od numeru linii, podanego w pliku ró¿nicowym, zostaniesz
poinformowany o offsecie.
Pojedynczy du¿y offset
.I mo¿e
byæ wskazówk±, ¿e fragment zainstalowano w z³ym
miejscu. Je¶li do porównania u¿yto wspó³czynnika `fuzz factor', to te¿
bêdziesz o tym poinformowany, gdy¿ mo¿e to byæ podejrzane.
Je¶li u¿y³e¶ opcji
.BR \*=verbose ,
zostaniesz te¿ powiadomiony o fragmentach dopasowanych dok³adnie.
.PP
Je¶li w linii komend nie podano ¿adnego pliku oryginalnego,
.B patch
spróbuje go odgadn±æ ze ¶mieci, zawartych w pliku z ró¿nic±, stosuj±c
poni¿sze zasady.
.LP
Najpierw buduje uporz±dkowan± listê kandydatur wed³ug takich regu³:
.TP 3
.B " \(bu"
Je¶li nag³ówek jest nag³ówkiem ró¿nicy typu context, nazwa starego i nowego
pliku odczytywana jest z niego. Nazwa pliku jest ignorowana je¶li ma za ma³o
uko¶ników dla opcji
.BI \-p num
lub
.BI \*=strip= num\fR.
Nazwa
.B /dev/null
jest równie¿ ignorowana.
.TP
.B " \(bu"
Je¶li w pocz±tkowych ¶mieciach jest linia
.B Index:\&
i albo brakuje obu nazw, starego i nowego pliku, albo 
.B patch
dzia³a zgodnie z \s-1POSIX\s0, to pobierana jest nazwa z tej linii.
.TP
.B " \(bu"
W poni¿szych regu³ach zak³ada siê, ¿e rozwa¿ane nazwy plików s± uporz±dkowane
(stary, nowy, indeks), niezale¿nie od kolejno¶ci, w jakiej wystêpuj±
w nag³ówku.
.LP
Nastêpnie
.B patch
wybiera nazwê pliki z listy potencjalnych nazw:
.TP 3
.B " \(bu"
Je¶li który¶ z wymienionych plików istnieje, to wybierana jest pierwsza
nazwa zgodna z \s-1POSIX\s0, w przeciwnym razie najlepsza.
.TP
.B " \(bu"
Je¿eli
.B patch
nie ignoruje \s-1RCS\s0, ClearCase i \s-1SCCS\s0 (zob. opcjê
.BI "\-g\ " num
lub
.BI \*=get= num \fR),
a tak wskazany plik istnieje, ale znaleziono g³ówn± (master) pozycjê
\s-1RCS\s0, ClearCase lub \s-1SCCS\s0, wybrany zostanie pierwszy
plik wymieniony w tej pozycji.
.TP
.B " \(bu"
Je¶li nie istnieje plik o danej nazwie, nie znaleziono g³ównej pozycji
\s-1RCS\s0, ClearCase lub \s-1SCCS\s0, podano jakie¶ nazwy,
.B patch
nie stosuje siê do \s-1POSIX\s0, za¶ ³ata wymaga utworzenia pliku, to
wybierana jest najlepsza nazwa wymagaj±ca stworzenia najmniejszej liczby
katalogów.
.TP
.B " \(bu"
Je¶li powy¿szy algorytm heurystyczny nie da ¿adnej nazwy pliku, to
zostaniesz o ni± zapytany.
.\" WK: ze starego:
Poza tym, je¶li w prowadz±cych ¶mieciach znajduje linia \*(L"Prereq: \*(R",
.B patch
spróbuje pobraæ pierwsze s³owo z tej linii (zwykle numer wersji) i sprawdziæ
czy istnieje ono w pliku wej¶ciowym.
Je¶li nie,
.B patch
zapyta o potwierdzenie przed kontynuacj±.
.PP
Efektem tego wszystkiego jest to, ¿e powiniene¶ byæ w stanie podaæ w
interfejsie newsów nastêpuj±ce:
.Sp
	| patch -d /usr/src/local/blurfl
.Sp
i tym samym za³ataæ katalog blurfl bezpo¶rednio z artyku³u, który zawiera
³atê.
.PP
Je¶li plik z ³at± sk³ada siê z wiêcej ni¿ jednej ³aty, program
.B patch
spróbuje zaaplikowaæ je tak, jakby przysz³y w osobnych plikach z ³atami.
Znaczy to miêdzy innymi tyle, ¿e nazwa ³atanego pliku jest okre¶lana dla
ka¿dego listingu ró¿nic z osobna i ¿e ¶mieci, znajduj±ce siê przed ka¿dym
z listingów bêd± analizowane jak opisano wy¿ej.
Do kolejnych ³at mo¿na przekazywaæ opcje (i inn± oryginaln± nazwê pliku),
oddzielaj±c odpowiadaj±ce listy argumentów znakiem \*(L'+\*(R'.
(Lista argumentów kolejnej ³aty nie musi jednak podawaæ
nowej nazwy pliku z ³at±.)
.SH OPCJE
.TP 3
.BR \-b ", " \*=backup
Tworzy pliki kopii zapasowych.
To znaczy, przy ³ataniu pliku, zamiast usuwania orygina³u tworzy jego
kopiê lub zmienia nazwê. Jako kopia zapasowa pliku, który nie istnia³
tworzony jest pusty plik, zastêpczo reprezentuj±cy nieistniej±cy orygina³.
Sposób ustalania nazw plików kopii zapasowych opisano przy opcjach
.B \-V
lub
.BR \*=version\-control .
.TP
.B \*=backup\-if\-mismatch
Tworzy kopiê zapasow± je¶li ³ata nie pasuje dok³adnie do pliku a nie za¿±dano
w inny sposób tworzenia kopii. Jest to zachowanie domy¶lne, chyba ¿e
.B patch
dzia³a zgodnie z \s-1POSIX\s0.
.TP
.B \*=no\-backup\-if\-mismatch
Nie tworzy kopii zapasowej je¶li ³ata nie pasuje dok³adnie do pliku
i je¶li nie za¿±dano w inny sposób tworzenia kopii.
Jest to zachowanie domy¶lne gdy
.B patch
dzia³a zgodnie z \s-1POSIX\s0.
.TP
\fB\-B\fP \fIpref\fP, \fB\*=prefix=\fP\fIpref\fP
Poprzedza przedrostkiem
.B pref
nazwê pliku podczas tworzenia nazwy zwyk³ej kopii.
Na przyk³ad, przy
.B "\-B\ /junk/"
nazw± zwyk³ej kopii dla
.B src/patch/util.c
jest
.BR /junk/src/patch/util.c .
.TP
\fB\*=binary\fP
Za wyj±tkiem standardowego wyj¶cia i
.BR /dev/tty ,
wszystkie pliki czyta i zapisuje w trybie binarnym.
Opcja ta nie ma ¿adnych skutków na systemach zgodnych z \s-1POSIX\s0.
Na systemach podobnych do \s-1DOS\s0, gdzie ma znaczenie, ³ata powinna byæ
tworzona przy u¿yciu
.BR "diff\ \-a\ \*=binary" .
.TP
\fB\-c\fP,  \fB\*=context\fP
Wymusza interpretacjê pliku z ³at± jako ró¿nicy typu context.
.TP
\fB\-d\fP \fIkat\fP,  \fB\*=directory=\fP\fIkatalog\fP
Powoduje interpretacjê
.B katalogu
jako katalogu, który ma byæ bie¿±cym i przechodzi do niego przed zrobieniem
czegokolwiek innego.
.TP
\fB\-D\fP \fIsymb\fP,  \fB\*=ifdef=\fP\fIsymb\fP
Powoduje u¿ywanie konstrukcji
"#ifdef...#endif" do oznaczania zmian.
.I symb
bêdzie symbolem ró¿nicuj±cym.
.TP
.B "\*=dry\-run"
Wypisuje wynik ³atania bez faktycznego zmieniania plików.
.TP
\fB\-e\fP,  \fB\*=ed\fP
Wymusza interpretacjê pliku z ³at± jako skryptu
.BR ed .
.TP
\fB\-E\fP,  \fB\*=remove\-empty\-files\fP
Powoduje, ¿e usuwane s± pliki wyj¶ciowe, które po zaaplikowaniu ³at s± puste.
Zwykle u¿ycie tej opcji nie jest konieczne, gdy¿ program potrafi zbadaæ
znaczniki czasu w nag³ówku i stwierdziæ, czy po naniesieniu ³at plik powinien
istnieæ.
Je¶li jednak wej¶cie nie jest plikiem ró¿nic kontekstowych lub gdy
.B patch
dzia³a zgodnie z \s-1POSIX\s0, puste za³atane pliki nie bêd± usuwane,
dopóki nie zostanie podana ta opcja.
Podczas usuwania pliku
.B patch
usi³uje usun±æ równie¿ jego puste katalogi nadrzêdne.
.TP
\fB\-f\fP,  \fB\*=force\fP
Wymusza za³o¿enie, ¿e u¿ytkownik dok³adnie wie co robi i powoduje
niezadawanie pytañ. Pomija ³aty, z których nag³ówków nie wynika, jaki plik
powinien byæ za³atany; pliki s± ³atane nawet je¶li maj± z³± wersjê dla linii
.BR Prereq:\& ;
zak³ada, ¿e ³aty nie s± odwrócone, nawet je¶li tak wygl±daj±.
Opcja ta nie eliminuje komentarzy; do tego u¿yj
.BR \-s .
.TP
\fB\-F\fP \fInum\fP,  \fB\*=fuzz=\fP\fInum\fP
Ustawia wspó³czynnik `maximum fuzz factor'.
Opcja ta tyczy siê tylko ró¿nic typu context i powoduje, ¿e
.B patch
ignoruje maksymalnie tyle linii, zagl±daj±c w miejsca, gdzie ma zainstalowaæ
fragment ³aty. Zauwa¿, ¿e du¿y wspó³czynnik zwiêksza prawdopodobieñstwo
nieprawid³owego naniesienia ³aty. Domy¶ln± warto¶ci± jest 2 i nie mo¿e byæ
ustawiona na wiêcej ni¿ liczba linii kontekstu w ró¿nicy, czyli zwykle 3.
.TP
\fB\-g\fP \fInum\fP,  \fB\*=get=\fP\fInum\fP
Steruje akcjami programu
.BR patch
gdy oryginalny plik jest pod kontrol± \s-1RCS\s0 lub \s-1SCCS\s0,
a nie istnieje lub jest przeznaczony tylko dla odczytu.
Tak¿e wtedy, gdy jest pod kontrol± ClearCase, a nie istnieje.
Je¿eli
.I num
jest dodatnie, to pobiera (get) lub aktualizuje (check out) plik
z danego systemu kontroli wersji (revision control system).
Je¶li wynosi zero,
.B patch
ignoruje system kontroli wersji i nie pobiera pliku; je¶li
.I num
jest ujemne, to pyta u¿ytkownika czy pobraæ plik.
Domy¶lna warto¶æ tej opcji okre¶lana jest warto¶ci± zmiennej ¶rodowiska
.B PATCH_GET
je¶li takowa istnieje; je¶li nie, to warto¶æ domy¶lna jest zerem, gdy 
.B patch
dzia³a zgodnie z \s-1POSIX\s0, w przeciwnym razie jest ujemna.
.TP
\fB\-i\fP \fIplik³aty\fP,  \fB\*=input=\fP\fIplik³aty\fP
Odczytuje ³atê z
.IR pliku³aty .
Je¶li
.I plikiem³aty
jest
.BR \- ,
to ze standardowego wej¶cia, domy¶lnie.
.TP
\fB\-l\fP,  \fB\*=ignore\-whitespace\fP
Wykonuje swobodniejsze porównywanie wzorców, w przypadku, gdy w pliku
pozamieniano tabulacje i spacje. Dowolna sekwencja bia³ych spacji (znaków
tabulacji lub spacji) w linii pliku ³aty bêdzie odpowiadaæ dowolnej sekwencji
bia³ych spacji oryginalnego pliku.
Ci±gi bia³ych spacji wystêpuj±ce na koñcach linii s± ignorowane.
Normalne znaki musz± wci±¿ dok³adnie pasowaæ. Ka¿da linia kontekstu nadal
musi pasowaæ do linii oryginalnego pliku.
.TP
\fB\-n\fP,  \fB\*=normal\fP
Powoduje, ¿e plik z ³at± jest interpretowany jak ró¿nica typu `normal'.
.TP
\fB\-N\fP,  \fB\*=forward\fP
powoduje ignorowanie ³at, które wydaj± siê byæ odwrócone lub ju¿
zaaplikowane.  Zobacz te¿
.BR \-R .
.TP
\fB\-o\fP \fIplik-wyj\fP,  \fB\*=output=\fP\fIplik-wyj\fP
Zamiast ³atania bezpo¶rednio oryginalnych plików, wynik jest kierowany do
.BR plik-wyj .
.TP
\fB\-p\fP\fInum\fP,  \fB\*=strip\fP\fB=\fP\fInum\fP
Z ka¿dej nazwy pliku znalezionej w pliku ³aty ujmuje najmniejszy przedrostek
zawieraj±cy
.I num
pocz±tkowych uko¶ników.
Ci±g kilku s±siaduj±cych uko¶ników liczy siê za jeden uko¶nik.
Opcjê przewidziano na wypadek gdyby¶ przechowywa³ pliki w innym katalogu
ni¿ osoba, która przes³a³a ³atê.
Na przyk³ad, za³ó¿my, ¿e nazwa pliku w ³acie mia³a warto¶æ
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
bez pocz±tkowego uko¶nika, a
.B \-p4
daje
.sp
	blurfl/blurfl.c
.sp
natomiast niepodanie 
.B \-p
w ogóle, daje po prostu \fBblurfl.c\fP.
Wynik tej operacji jest poszukiwany albo w katalogu bie¿±cym, albo w katalogu
podanym przez opcjê
.BR \-d .
.TP
.B \*=posix
Postêpuje bardziej zgodnie ze standardem \s-1POSIX\s0:
.RS
.TP 3
.B " \(bu"
Dociekaj±c nazw plików z nag³ówków ró¿nic
z listy (stary, nowy, indeks) bierze pierwszy istniej±cy plik.
.TP
.B " \(bu"
Nie usuwa plików, które po za³ataniu staj± siê puste.
.TP
.B " \(bu"
Nie pyta o pobieranie plików z \s-1RCS\s0, ClearCase czy \s-1SCCS\s0.
.TP
.B " \(bu"
Wymaga, by w wierszu poleceñ wszystkie opcje wystêpowa³y przed nazwami plików.
.TP
.B " \(bu"
Nie tworzy kopii zapasowych przy wyst±pieniu niezgodno¶ci.
.RE
.TP
.BI \*=quoting\-style= wyraz
U¿ywa stylu
.I wyraz
do cytowania nazw wyj¶ciowych.
.I Wyraz
powinien byæ jednym z poni¿szych:
.RS
.TP
.B literal
Wypisuje nazwy bez zmian.
.TP
.B shell
Cytuje nazwy dla pow³oki je¶li zawieraj± metaznaki pow³oki lub spowodowa³yby
dwuznaczno¶æ wyniku.
.TP
.B shell-always
Cytuje nazwy dla pow³oki, nawet wtedy, gdy normalnie nie wymaga³yby cytowania.
.TP
.B c
Cytuje nazwy jak dla ³añcuchów w jêzyku C.
.TP
.B escape
Cytuje jak z
.BR c ,
z wyj±tkiem tego, i¿ pomija otaczaj±ce znaki cudzys³owu.
.LP
Warto¶æ domy¶ln± opcji
.B \*=quoting\-style
mo¿na okre¶liæ za pomoc± zmiennej ¶rodowiska
.BR QUOTING_STYLE .
Je¶li nie jest ona ustawiona, to warto¶ci± domy¶ln± jest
.BR shell .
.RE
.TP
\fB\-r\fP \fIplik-odrz\fP,  \fB\*=reject\-file=\fP\fIplik-odrz\fP
Odrzucone poprawki s± umieszczane w zadanym
.BR pliku-odrz ,
a nie w domy¶lnym pliku odrzuceñ
.BR \&.rej .
.TP
\fB\-R\fP,  \fB\*=reverse\fP
Mówi, ¿e ³ata ta zosta³a utworzona przy zamienionych miejscami starych
i nowych plikach [t³um. zamiast `\fBdiff -c stary nowy\fP' u¿yto pomy³kowo
`\fBdiff -c nowy stary\fP'].  
(Tak, obawiam siê ¿e czasem siê to zdarza, natura ludzka jest jaka jest.)
.B Patch
Spróbuje zamieniæ ka¿dy fragment przed jego zaaplikowaniem. Odrzucenia wyjd±
w formacie zamienionym (swapped).
Opcja
.B \-R
nie dzia³a ze skryptami ró¿nicowymi 
.BR ed a
gdy¿ jest tam zbyt ma³o danych do zrekonstruowania operacji odwrotnej.
.Sp
Je¶li pierwszy fragment ³aty zawiedzie,
.B patch
odwraca ten fragment, sprawdzaj±c czy nie mo¿e byæ tak zaaplikowany.
Je¶li mo¿e, zostaniesz zapytany czy chcesz ustawiæ opcjê
.BR \-R .
Je¶li nie, ³ata bêdzie aplikowana dalej w sposób tradycyjny.
(Uwaga: metoda ta nie mo¿e wykryæ ³aty odwróconej je¶li jest to ró¿nica typu
normal i je¶li pierwsz± komend± jest doklejanie (append) (tj. powinno to
byæ kasowanie \-\- delete). Jest tak dlatego, ¿e doklejanie zawsze dzia³a, gdy¿
pusty kontekst pasuje wszêdzie.
Szczê¶liwym trafem, wiele ³at raczej dodaje lub zmienia linie ni¿ je
kasuje, wiêc wiêkszo¶æ odwróconych ró¿nic typu normal zaczyna siê od
kasowania, co zawiedzie i wywo³a heurystykê.)
.ig
[A po ludzku: opcja -R umo¿liwia anulowanie zaaplikowanej ³aty -- przyp.
t³um.]
[Przemku: daje mo¿no¶æ naniesienia *poprawnej* ³aty, gdy przy jej tworzeniu
przez pomy³kê podano odwrotnie parametry stary/nowy]
..
.TP
\fB\-s\fP,  \fB\*=silent\fP,  \fB\*=quiet\fP
Powoduje, ¿e
.B patch
dzia³a cicho, chyba ¿e pojawi siê b³±d.
.TP
\fB\-t\fP,  \fB\*=batch\fP
Podobne do
.BR \-f ,
gdy¿ eliminuje pytania, lecz dzia³a wed³ug innych za³o¿eñ:
pomija ³aty, których nag³ówki nie zawieraj± nazw plików (tak samo jak
\fB\-f\fP), pomija ³aty dla plików ze z³ymi wersjami
.B Prereq:\&
i przyjmuje, ¿e ³aty s± odwrócone, je¶li na takie wygl±daj±.
.TP
\fB\-T\fP,  \fB\*=set\-time\fP
Ustawia czasy modyfikacji i ostatniego dostêpu za³atanych plików wed³ug
znaczników czasu podanych w nag³ówkach ró¿nic typu context, zak³adaj±c, ¿e
nag³ówki te stosuj± czas lokalny.  Opcja ta jest niezalecana, gdy¿ u¿ycie
³at korzystaj±cych z czasu lokalnego przez osoby z innych stref czasowych
nie jest ³atwe.
Ponadto znaczniki czasu lokalnego nie s± jednoznaczne w przypadku, gdy zegar
lokalny jest cofany w zwi±zku z dostosowywaniem do czasu letniego.
Zamiast tej opcji, powinno siê tworzyæ ³aty z czasem uniwersalnym
(\s-1UTC\s0) i stosowaæ opcjê
.B \-Z
lub
.BR \*=set\-utc .
.TP
\fB\-u\fP,  \fB\*=unified\fP
Wymusza interpretacjê ³aty jako ró¿nicy typu unified context (zunifikowana
ró¿nica kontekstowa).
.TP
\fB\-V\fP \fImetoda\fP,  \fB\*=version\-control=\fP\fImetoda\fP
.B "\-V metoda, \-\-version\-\-control=metoda"
Powoduje, ¿e
.B metoda
staje siê metod± tworzenia nazw plików zapasowych. Rodzaje robionych kopii
zapasowych mo¿na równie¿ podaæ w zmiennej ¶rodowiskowej
.B PATCH_VERSION_CONTROL
(lub, je¶li nie jest ustawiona, zmienn±
.BR VERSION_CONTROL ),
która jest przes³aniana przez tê opcjê.
Wybrana metoda nie ma wp³ywu na to, czy kopie zapasowe bêd± wykonywane,
i w jakich przypadkach.  Okre¶la tylko sposób tworzenia nazw plików
zapasowych.
Warto¶æ
.I metody
jest podobna jak zmiennej `version-control' \s-1GNU\s0 Emacsa.
.B Patch
rozpoznaje te¿ ich bardziej opisowe synonimy.
Poprawne warto¶ci to
(przyjmowane s± rozró¿nialne skróty):
.RS
.TP 3
\fBnumbered\fP  lub  \fBt\fP
Tworzy zawsze numerowane kopie zapasowe.  Nazw± numerowanej kopii zapasowej
pliku
.I F
jest
.IB F .~ N ~
gdzie
.I N
to numer wersji.
.TP
\fBexisting\fP  lub  \fBnil\fP
Tworzy numerowane kopie zapasowe plików, które ju¿ je maj±, a zwyk³e kopie
dla pozosta³ych. Tak jest domy¶lnie.
.TP
`never' lub `simple'
Zawsze robi zwyk³e kopie zapasowe.
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
okre¶laj± nazwê pliku zwyk³ej kopii zapasowej.
Je¿eli nie podano ¿adnej z nich, to stosowany jest przyrostek zwyk³ej
kopii zapasowej.  Jest to warto¶æ zmiennej ¶rodowiska
.BR SIMPLE_BACKUP_SUFFIX ,
je¶li jest ona ustawiona, lub
.B \&.orig
w przeciwnym razie.
.PP
Przy kopiach numerowanych lub zwyk³ych, je¶li nazwa pliku kopii zapasowej
jest zbyt d³uga, to zamiast niej u¿ywa siê przyrostka kopii
.BR ~ .
Je¿eli nawet dodanie
.B ~
spowodowa³oby, ¿e nazwa bêdzie za d³uga, to
.B ~
zastêpuje ostatni znak nazwy pliku.
.RE
.TP
\fB\*=verbose\fP
Wypisuje dodatkowe informacje o wykonywanej pracy.
.TP
\fB\-x\fP \fInum\fP,  \fB\*=debug=\fP\fInum\fP
ustawia wewnêtrzne flagi debuggowe. Ma to znaczenie tylko dla ³ataczy
programu
.BR patch .
.TP
\fB\-Y\fP \fIpref\fP,  \fB\*=basename\-prefix=\fP\fIpref\fP
Przy tworzeniu nazwy zwyk³ej kopii poprzedza przedrostkiem
.I pref
podstawow± czê¶æ nazwy pliku.
Na przyk³ad, przy
.B "\-Y\ .del/"
nazw± pliku zwyk³ej kopii zapasowej dla
.B src/patch/util.c
jest
.BR src/patch/.del/util.c .
.TP
\fB\-z\fP \fIsuffix\fP,  \fB\*=suffix=\fP\fIsuffix\fP
Powoduje, ¿e
.B suff
jest interpretowane jako przyrostek nazw zwyk³ych kopii zapasowych.
Na przyk³ad, przy
.B "\-z\ -"
nazw± pliku zwyk³ej kopii kopii dla
.B src/patch/util.c
jest
.BR src/patch/util.c- .
Przyrostek kopii mo¿na te¿ okre¶liæ za pomoc± zmiennej ¶rodowiska
.BR SIMPLE_BACKUP_SUFFIX ,
która jest przes³aniana przez tê opcjê.
.TP
\fB\-Z\fP,  \fB\*=set\-utc\fP
Ustawia czasy modyfikacji i ostatniego dostêpu za³atanych plików wed³ug
znaczników czasu podanych w nag³ówkach ró¿nic typu context, zak³adaj±c, ¿e
nag³ówki te stosuj± czas uniwersalny - Coordinated Universal Time
(\s-1UTC\s0, znany te¿ jako czas ¶redni Greenwich \s-1GMT\s0).
Zobacz te¿ opcja
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
normalnie powstrzymuj± siê od ustawiania czasu pliku je¶li jego
oryginalny czas nie pasuje do czasu podanego w nag³ówku ³aty lub jej
zawarto¶æ nie pasuje dok³adnie do ³aty.  Jednak, je¶li podano opcjê
.B \-f
lub
.BR \*=force,
to czas pliku jest ustawiany bez wzglêdu na niezgodno¶ci.
.Sp
Z powodu ograniczeñ formatu wyj¶ciowego stosowanego przez
.BR diff ,
opcje te nie potrafi± aktualizowaæ czasów plików, których zawarto¶æ siê nie
zmieni³a.  Wykorzystuj±c te opcje powinno siê pamiêtaæ o usuniêciu
(np. za pomoc±
.BR "make\ clean" )
wszystkich plików, które zale¿± od za³atanych, by pó¼niejsze wywo³ania
.B make
nie zosta³y zmylone czasem za³atanych plików.
.TP
.B "\*=help"
Wypisuje listê opcji i koñczy dzia³anie.
.TP
\fB\-v\fP,  \fB\*=version\fP
Wypisuje wersjê programu i koñczy dzia³anie.
.SH ¦RODOWISKO
.TP 3
.B PATCH_GET
Okre¶la, czy
.B patch
powinien domy¶lnie pobieraæ brakuj±ce lub przeznaczone tylko do odczytu
pliki z \s-1RCS\s0, ClearCase lub \s-1SCCS\s0. Zobacz opis opcji
.B \-g
lub
.BR \*=get .
.TP
.B POSIXLY_CORRECT
Je¶li jest ustawiona,
.B patch
¶ci¶lej stosuje siê do standardu \s-1POSIX\s0 w zachowaniu domy¶lnym.
Zobacz opis opcji
.BR \*=posix .
.TP
.B QUOTING_STYLE
Domy¶lna warto¶æ opcji
.BR \*=quoting\-style .
.TP
.B SIMPLE_BACKUP_SUFFIX
Przyrostek stosowany do tworzenia nazw plików zwyk³ych kopii zapasowych
.BR \&.orig .
.TP
\fBTMPDIR\fP, \fBTMP\fP, \fBTEMP\fP
Katalog do przechowywania plików tymczasowych.
.B patch
wykorzystuje pierwsz± zmienn± ¶rodowiska z tej listy, jaka jest ustawiona.
Je¶li ¿adna nie jest, warto¶æ domy¶lna zale¿y od systemu: normalnie
na maszynach uniksowych jest to
.BR /tmp .
.TP
\fBVERSION_CONTROL\fP lub \fBPATCH_VERSION_CONTROL\fP
Wybiera metodê kontroli wersji kopii pliku; zobacz opcja
.B \-v
lub
.BR \*=version\-control .
.SH PLIKI
.TP 3
.IB $TMPDIR "/p\(**"
pliki tymczasowe
.TP
.B /dev/tty
terminal steruj±cy; u¿ywany do uzyskania odpowiedzi na pytania
zadawane u¿ytkownikowi.
.SH ZOBACZ TAK¯E
.BR diff (1)
.BR ed (1).
.Sp
Marshall T. Rose and Einar A. Stefferud,
Proposed Standard for Message Encapsulation,
Internet RFC 934 <URL:ftp://ftp.isi.edu/in-notes/rfc934.txt> (1985-01).
.SH UWAGI DLA WYSY£AJ¡CYCH £ATY
Istnieje kilka rzeczy, o których nale¿y pamiêtaæ przy wysy³aniu ³at.
.PP
Twórz ³atê wed³ug sprawdzonego schematu.
Dobr± metod± jest polecenie
.BI "diff\ \-Naur\ " "stary\ nowy"
gdzie
.I stary
i
.I nowy
identyfikuj± stary i nowy katalog.
Nazwy
.I stary
i
.I nowy
nie powinny zawieraæ ¿adnych uko¶ników.
Nag³ówki z poleceñ
.B diff
powinny zawieraæ daty i czasy czasu uniwersalnego (UTC) z zastosowaniem
tradycyjnego formatu uniksowego, by odbiorcy ³aty mogli skorzystaæ z opcji
.B \-Z
lub
.BR \*=set\-utc .
Oto przyk³adowe polecenie, z u¿yciem sk³adni pow³oki Bourne'a:
.Sp
	\fBLC_ALL=C TZ=UTC0 diff \-Naur gcc\-2.7 gcc\-2.8\fP
.PP
Powiadom odbiorców, jak zaaplikowaæ ³atê, wskazuj±c, do którego katalogu
przej¶æ
.BR cd
i jakich opcji 
.B patch
u¿yæ.  Zalecany jest ³añcuch opcji
.BR "\-Np1" .
Wypróbuj procedurê stawiaj±c siê na miejscu odbiorcy i stosuj±c ³atê
na kopiê oryginalnych plików.
.PP
Mo¿esz oszczêdziæ ludziom wielu problemów, zachowuj±c plik
.B patchlevel.h
Jest on ³atany aby zwiêkszyæ poziom ³aty (patch
level).
Umie¶æ go jako pierwsz± ró¿nicê w pliku z ³at±, który wysy³asz.
Je¶li do ³aty wstawisz liniê
.BR Prereq:\& ,
to nie pozwoli ona na stosowanie ³at poza kolejno¶ci± bez ostrze¿enia.
.PP
Mo¿esz utworzyæ plik u odbiorcy wysy³aj±c mu ró¿nicê z porównania
.B /dev/null
lub pusty plik o dacie równej Epoce (1970-01-01 00:00:00 \s-1UTC\s0)
z plikiem, który chcesz stworzyæ.
Zadzia³a to tylko je¶li plik taki jeszcze nie istnieje w katalogu docelowym.
I odwrotnie, mo¿esz usun±æ plik wysy³aj±c ró¿nicê kontekstow± porównuj±c±
plik do usuniêcia z pustym plikiem datowanym na Epokê.
Plik nie zostanie usuniêty je¶li
.B patch
dzia³a zgodnie z \s-1POSIX\s0 a nie podano opcji
.B \-E
lub
.BR \*=remove\-empty\-files .
Prost± metod± generowania ³at, które tworz± i usuwaj± pliki jest u¿ycie
opcji
.B \-N
lub
.B \*=new\-file
programu
\s-1GNU\s0
.BR diff .
Je¶li spodziewasz siê, ¿e odbiorca u¿yje opcji
.BI \-p N \fR,
nie wysy³aj wyj¶cia wygl±daj±cego tak:
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
bo obie nazwy plików maj± ró¿n± liczbê uko¶ników, a rozmaite wersje
.B patch
ró¿nie interpretuj± nazwy plików.
Unikniesz mylnej interpretacji, wysy³aj±c zamiast tego takie wyj¶cie:
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
Unikaj wysy³ania ³at porównuj±cych pliki o takich nazwach, jakie maj± kopie
zapasowe, jak np.
.BR README.orig ,
gdy¿ mo¿e to zmyliæ
.BR patch ,
tak ¿e bêdzie nak³ada³ ³atê na plik kopii zamiast na rzeczywisty plik.
Zamiast tego powiniene¶ wysy³aæ ³aty porównuj±ce pliki o takich samych
nazwach podstawowych, po³o¿one w ró¿nych katalogach, np.\&
.B old/README
i
.BR new/README .
.PP
Uwa¿aj by nie wysy³aæ ³at odwrotnych, gdy¿ powoduje to, ¿e ludzie
zastanawiaj± siê czy ju¿ za³±czyli ³atê.
.PP
Nie próbuj budowaæ ³at, które zmienia³y by pliki pochodne (np. plik
.BR configure ,
w którym jest linia
.B "configure: configure.in"
w swoim makefile), poniewa¿ odbiorca i tak powinien byæ w stanie
je odtworzyæ.  Je¶li musisz wys³aæ ró¿nice plików pochodnych, utwórz je
u¿ywaj±c czasu uniwersalnego \s-1UTC\s0;  odbiorcy powinni zaaplikowaæ ³±tê
stosuj±c opcjê
.B \-Z
lub
.BR \*=set\-utc ,
a nastêpnie usun±æ wszystkie nie³atane pliki, które zale¿± od w³a¶nie
za³atanych (np. za pomoc±
.BR "make\ clean" ).
.PP
Mimo i¿ mo¿na umie¶ciæ 582 listingów ró¿nic w jednym pliku, to
lepiej wstawiæ grupy powi±zanych ³at do osobnych plików.
.PP
Poza tym, upewnij siê, ¿e poda³e¶ poprawnie nazwy plików, zarówno w nag³ówku
ró¿nicy kontekstowej, jak i w linii
.BR Index:\& .
Je¶li ³atasz co¶ w podkatalogu,
upewnij siê, ¿e powiadomi³e¶ u¿ytkownika, by poda³ opcjê
.BR \-p .
.SH DIAGNOSTYKA
Zbyt wiele by tu wymieniaæ, lecz ogólnie wskazuj±, ¿e
.B patch
nie móg³ przetworzyæ pliku z ³at±.
.PP
Je¶li podano opcjê
.BR \*=verbose ,
komunikat
.B Hmm.\|.\|.\&
wskazuje, ¿e w pliku z ³at± jest nieprzetworzony tekst i ¿e
.B patch
próbuje domy¶liæ siê, czy znajduje siê w nim ³ata, a je¶li tak, to jakiego
jest rodzaju.
.PP
.B Patch
koñczy pracê z kodem
0 je¶li wszystkie kawa³ki zaaplikowano poprawnie,
1 je¶li jakie¶ nie mog³y byæ zaaplikowane,
a 2 w przypadku powa¿niejszych k³opotów.
Podczas aplikowania zbioru ³at w pêtli, umo¿liwia ci sprawdzenie tego kodu,
tak by nie do³±czaæ ju¿ reszty ³at do czê¶ciowo po³atanego pliku.
.SH ZASTRZE¯ENIA
Ró¿nice kontekstowe nie mog± wiarygodnie odwzorowywaæ tworzenia lub usuwania
pustych plików, pustych katalogów czy plików specjalnych, jak dowi±zania
symboliczne.  Nie potrafi± te¿ reprezentowaæ zmian w metadanych pliku, takich
jak w³a¶ciciel, grupa, prawa czy to, ¿e jeden plik jest twardym dowi±zaniem
do drugiego.
Je¶li takie zmiany s± równie¿ wymagane, ³acie powinny towarzyszyæ osobne
instrukcje (np. w postaci skryptu pow³oki).
.PP
.B Patch
nie potrafi stwierdziæ, czy w skrypcie
.B ed
nie istniej± numery linii,
a w normalnych ró¿nicach mo¿e wykryæ niew³a¶ciwe numery tylko gdy odnajdzie
zmianê lub usuniêcie.
Ró¿nica kontekstowa, u¿ywaj±ca wspó³czynnika `fuzz factor' 3 mo¿e mieæ
podobne problemy. Dopóki nie zostanie dodany w³a¶ciwy interaktywny interfejs
u¿ytkownika, powiniene¶ raczej w tych wypadkach robiæ ró¿nice typu context.
Zobaczysz czy zmiany maj± sens. Oczywi¶cie kompilowanie bez b³êdów jest
ca³kiem dobrym wskazaniem, ¿e ³ata zadzia³a³a, lecz nie jest to zawsze
prawda.
.PP
.B Patch
zwykle daje prawid³owe wyniki, nawet gdy musi du¿o zgadywaæ. Jednak
rezultaty maj± gwarancjê prawid³owo¶ci tylko wtedy, gdy ³aty aplikowane s± do
dok³adnie tej samej wersji pliku, z której zosta³y wygenerowane.
.SH "KWESTIE ZGODNO¦CI"
Standard \s-1POSIX\s0 podaje zachowanie, które ró¿ni siê od tradycyjnego
zachowania siê
.BR patch a.
Powiniene¶ pamiêtaæ o tych ró¿nicach je¶li musisz wspó³pracowaæ z
.B patch
w wersji 2.1 lub wcze¶niejszymi, które nie s± zgodne z \s-1POSIX\s0.
.TP 3
.B " \(bu"
W tradycyjnym
.BR patch u
argument opcji
.B \-p
by³ opcjonalny, a go³e
.B \-p
by³o równowa¿ne
.BR \-p0 .
Obecnie opcja
.B \-p
wymaga argumentu, a
.B "\-p\ 0"
jest teraz równowa¿nikiem
.BR \-p0 .
Dla zachowania maksymalnej zgodno¶ci, stosuj opcje typu
.B \-p0
i
.BR \-p1 .
.Sp
Ponadto, tradycyjny
.B patch
po prostu zlicza uko¶niki przy obcinaniu przedrostków ¶cie¿kowych;
.B patch
liczy obecnie sk³adowe nazwy pliku.
To znaczy, ci±g s±siaduj±cych uko¶ników liczy siê obecnie za jeden uko¶nik.
Dla zachowania maksymalnej zgodno¶ci, unikaj wysy³ania ³at zawieraj±cych
.B //
w nazwach plików.
.TP
.B " \(bu"
W tradycyjnym
.BR patch u,
tworzenie kopii zapasowych by³o w³±czone domy¶lnie.
Zachowanie to jest teraz w³±czane opcj±
.B \-b
lub
.BR \*=backup .
.Sp
I odwrotnie, w \s-1POSIX\s0-owym
.BR patch ,
kopie nigdy nie s± tworzone, nawet je¶li wyst±pi niedopasowanie ³aty.
W \s-1GNU\s0
.BR patch ,
zachowanie to jest w³±czane opcj±
.B \*=no\-backup\-if\-mismatch
lub przez w³±czenie zgodno¶ci z \s-1POSIX\s0 opcj±
.B \*=posix
albo ustawieniem zmiennej ¶rodowiska
.BR POSIXLY_CORRECT .
.Sp
Opcja
.BI \-b "\ suffix"
tradycyjnego
.BR patch
jest równowa¿na opcjom
.BI "\-b\ \-z" "\ suffix"
dla \s-1GNU\s0
.BR patch .
.TP
.B " \(bu"
Tradycyjny
.B patch
stosuje skomplikowan± (i nie w pe³ni udokumentowan±) metodê domy¶lania siê
z nag³ówka ³aty nazwy pliku do za³atania.
Metoda ta nie jest zgodna z \s-1POSIX\s0 i ma kilka niepoprawnie zakodowanych
fragmentów [gotchas].
Obecny
.B patch
korzysta z innej, równie skomplikowanej (ale lepiej udokumentowanej) metody,
która jest opcjonalnie zgodna z \s-1POSIX\s0; mamy nadziejê, ¿e ma mniej
b³êdów. Obie te metody s± ze sob± zgodne je¶li nazwy plików w nag³ówku
ró¿nicy kontekstowej i w linii
.B Index:\&
po obciêciu przedrostka s± identyczne.
Normalnie ³ata jest zgodna je¶li wszystkie nazwy plików w nag³ówku zawieraj±
tê samê liczbê uko¶ników.
.TP
.B " \(bu"
Gdy tradycyjny
.B patch
zadawa³ u¿ytkownikowi pytanie, kierowa³ je na standardowe wyj¶cie b³êdów
i oczekiwa³ odpowiedzi z pierwszego pliku poni¿szej listy bêd±cego
terminalem:
standardowe wyj¶cie b³êdów, standardowe wyj¶cie,
.BR /dev/tty ,
i standardowe wej¶cie.
Teraz
.B patch
wysy³a pytania na standardowe wyj¶cie i pobiera odpowiedzi z
.BR /dev/tty .
Zmieniono domy¶lne odpowiedzi na niektóre z pytañ.  Dziêki temu
.B patch
nigdy nie wchodzi w nieskoñczon± pêtlê przy stosowaniu domy¶lnych
odpowiedzi.
.TP
.B " \(bu"
Tradycyjny
.B patch
koñczy³ dzia³anie z kodem równym liczbie b³êdnych fragmentów, albo z kodem 1
je¶li napotkano powa¿ny problem.
Obecnie
.B patch
koñczy dzia³anie z kodem 1 je¶li nie uda³o siê zaaplikowaæ jakich¶
fragmentów, albo 2 je¶li napotkano powa¿ny problem.
.TP
.B " \(bu"
Wysy³aj±c instrukcje okre¶laj±ce sposób skorzystania z ³aty
przez kogo¶ pracuj±cego z
\s-1GNU\s0
.BR patch ,
tradycyjnym
.BR patch em,
lub
.B patch em
zgodnym z \s-1POSIX\s0 ogranicz siê do podanych ni¿ej opcji.
W tym zestawieniu spacje s± znacz±ce, a argumenty wymagane.
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
.SH B£ÊDY
Zg³oszenia b³êdów proszê wysy³aæ do
.BR <bug-gnu-utils@gnu.org> .
.PP
Móg³by byæ sprytniejszy co do czê¶ciowych trafieñ, nadmiernie odbiegaj±cych
od normy offsetów i zamienionego kodu, lecz wymaga³oby to dodatkowego
przebiegu.
.PP
Je¶li kod zosta³ powielony (np. #ifdef STARYKOD ... #else ... #endif),
.I patch
nie mo¿e za³ataæ obu wersji, i je¶li w ogóle zadzia³a, prawdopodobnie za³ata
niew³a¶ciw± i powie, ¿e uda³o mu siê z obydwiema.
.PP
Je¶li aplikujesz ³atê, któr± ju¿ zaaplikowa³e¶,
.I patch
pomy¶li ¿e jest to odwrotna ³ata i zaoferuje zdjêcie ³aty.
Mo¿na to uwa¿aæ za zaprojektowan± funkcjê programu.
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
Larry Wall napisa³ pierwotn± wersjê
.BR patch a.
Paul Eggert usun±³ istniej±ce w programie arbitralne ograniczenia.
Doda³ obs³ugê plików binarnych, ustawianie czasów pliku i usuwanie plików,
i uczyni³ go bardziej zgodnym z \s-1POSIX\s0-em.
Swój wk³ad wnie¶li te¿ Wayne Davison, który doda³ obs³ugê formatu unidiff,
i David MacKenzie, który do³o¿y³ obs³ugê ustawieñ i kopii zapasowych.
