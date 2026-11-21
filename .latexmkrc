# latexmk 設定（uplatex + upbibtex + dvipdfmx）
$latex     = 'uplatex -synctex=1 -halt-on-error -interaction=nonstopmode -file-line-error -kanji=utf8 %O %S';
$bibtex    = 'upbibtex %O %B';
$dvipdf    = 'dvipdfmx %O -o %D %S';
$makeindex = 'upmendex %O -o %D %S';
$pdf_mode  = 3;   # latex -> dvi -> dvipdfmx
$max_repeat = 5;
@default_files = ('00_main.tex');
