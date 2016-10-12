\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NCU_thesis}[2016/09/01 by sppmg]
% pass no defined option to book class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
% terminates the option processing.
\ProcessOptions\relax 
% Load base class
\LoadClass[a4paper,10pt]{book}
%%%%% Load additional packages and commands.

\RequirePackage{ifthen}

\IfFileExists{./config.tex}{\input{./config.tex}}{} % search only in the current directory use ./file
\PassOptionsToPackage{hyphens, allowmove}{url}
% Chinese 
\XeTeXlinebreaklocale "zh"   % 設定斷行演算法為中文
\XeTeXlinebreakskip = 0pt plus 1pt   % 設定中文字距與英文字距
\RequirePackage{zhnumber}

\RequirePackage{fontspec} % no need these package now : inputenc,xltxtra,xunicode
\RequirePackage[slantfont,boldfont]{xeCJK} % [啟用斜體,粗體]
% \setlength{\parindent}{3em} %縮排約2字寬
% Linux 利用指令 fc-list :lang=zh 來查詢可以用的字體名稱。
%\setmainfont{DejaVu Sans} % ==\setromanfont
%\setmonofont[Ligatures=Historical]{DejaVu Sans Mono}
% \setCJKmainfont{AR PL UMing TW MBE} % 襯線字體(\rmfamily)，中文設為明體
% \setCJKsansfont{AR PL UKai TW MBE} % 原意為無襯線字體(\sffamily)，中文設為楷體
% \setCJKmonofont[Scale=0.9]{AR PL UMing TW MBE} % (\ttfamily)
%%%%%%%%%%% Auto select font %%%%%%%%%%%%%%
% You can use ifplatform package in here, but need add option to XeLaTeX, not good to newbie.
% --------- English ----------
\ifx\mainfont\empty\else
    \setmainfont{\mainfont}
\fi
\ifx\sansfont\empty\else
    \setsansfont{\sansfont}
\fi
\ifx\monofont\empty\else
    \setmonofont{\monofont}
\fi
% --------- Chinese ----------
\ifx\CJKmainfont\empty
    \ifthenelse{\equal{\OS}{linux}}{
        % linux os
        \setCJKmainfont{AR PL UMing TW}  % MingLiU == 細明體
    }{
        \ifthenelse{\equal{\OS}{win}}{
            % win os
            \setCJKmainfont{MingLiU}  % MingLiU == 細明體
        }{
            % set macos later
    }}
\else
    \setCJKmainfont{\CJKmainfont}
\fi
%%%
\ifx\CJKsansfont\empty
    \ifthenelse{\equal{\OS}{linux}}{
        % linux os
        \setCJKsansfont{AR PL UKai TW}  % DFKai-SB == 標楷體
    }{
        \ifthenelse{\equal{\OS}{win}}{
            % win os
            \setCJKsansfont{DFKai-SB}  % DFKai-SB == 標楷體
        }{
            % set macos later
    }}
\else
    \setCJKsansfont{\CJKsansfont}
\fi
%%%
\ifx\CJKmonofont\empty
    \ifthenelse{\equal{\OS}{linux}}{
        % linux os
        \setCJKmonofont{AR PL UMing TW}  % MingLiU == 細明體
    }{
        \ifthenelse{\equal{\OS}{win}}{
            % win os
            \setCJKmonofont{MingLiU}  % MingLiU == 細明體
        }{
            % set macos later
    }}
\else
    \setCJKmonofont{\CJKmonofont}
\fi
%%%%%%%%%%%% Auto select font end %%%%%%%%%%%%%
\RequirePackage{indentfirst} % 章節行縮排

% \setcounter{secnumdepth}{3}  % 顯示至\subsubsection 的標號，LaTeX 預設2 , move to config.tex

%設定頁面配置
\RequirePackage[a4paper, top=2.5cm, bottom=2.5cm, inner=3cm, outer=2cm, marginparwidth=2.0cm]{geometry}% use showframe in class option for check. marginparwidth for todonotes
%http://tex.stackexchange.com/questions/5180/how-can-i-get-todonotes-in-the-left-marginparwidth

\RequirePackage{graphicx}
\graphicspath{ {./figures/} {../figures/} } 
% \RequirePackage{mmap}

\RequirePackage{pdfpages} % Insert PDF file by  \includepdf[pages={1,3,5}]{myfile.pdf}

\RequirePackage{xargs}  % Use more than one optional parameter in a new commands , for todonotes macro.
\RequirePackage{xparse} % advanced macro package, similar with xargs 
\RequirePackage{xcolor}  % Coloured text etc.

% table
\RequirePackage{tabularx}	% for table which specified width. tabulary also can do it.
\RequirePackage{multirow}	% for table
\RequirePackage{colortbl} % color table
\renewcommand{\arraystretch}{1.2}

\ifthenelse{\boolean{publish}}{
    \RequirePackage[disable]{todonotes}     % hide notes
}{
    \RequirePackage[colorinlistoftodos,prependcaption]{todonotes}
}
\reversemarginpar % add this after loading the geometry and todonotes packages
%http://tex.stackexchange.com/questions/5180/how-can-i-get-todonotes-in-the-left-margin


\RequirePackage[format=hang]{caption}
\RequirePackage{subcaption}  % subfigure
\captionsetup{subrefformat=parens} % \subref style is (a)

\RequirePackage{floatrow} % set caption position of table
\floatsetup[table]{capposition=top}

\RequirePackage{amsmath}
\RequirePackage{siunitx}
\sisetup{per-mode=symbol, range-phrase=$\:\sim\:$} % \per default use / not ^-1 , change ``to'' to ``~'' 
% set a new ``molar'' unit
\DeclareSIUnit\molar{\mole\per\cubic\deci\metre}
\DeclareSIUnit\Molar{\textsc{m}}

\RequirePackage[version=3]{mhchem} % usage \ce{KH2PO4}

% set title's font size
% http://tex.stackexchange.com/questions/59726/change-size-of-section-subsection-subsubsection-paragraph-and-subparagraph-ti
\RequirePackage{titlesec}
\titleformat*{\section}{\LARGE\bfseries}
\titleformat*{\subsection}{\Large\bfseries}
\titleformat*{\subsubsection}{\large\bfseries}

\RequirePackage[nottoc,numbib]{tocbibind}
%\renewcommand{\tocbibname}{參考文獻}
\RequirePackage[backend=biber,natbib=true,style=nature,citestyle=numeric-comp,sorting=none]{biblatex}
% use biblatex and sort by citation order
% http://tex.stackexchange.com/questions/51434/biblatex-citation-order
% use \addbibresource{bib.bib} 


% 中文化
\renewcommand{\chaptername}{章}
\renewcommand{\figurename}{圖}
\renewcommand{\tablename}{表}
%\renewcommand{\refname}{參考資料} % book class no \refname
\renewcommand{\bibname}{參考文獻} % no effect in this template
\renewcommand{\appendixname}{附錄}
\renewcommand\contentsname{目錄}
\renewcommand\listfigurename{圖目錄}
\renewcommand\listtablename{表目錄}

% Latex 章節名稱及目錄改為中文 http://lzsh00262.blogspot.tw/2013/02/xelatex.html
% \RequirePackage{titlesec} % 前面用過
\RequirePackage{titletoc}
%\RequirePackage{zhnumber}% 前面用過

% 修改每章首頁的標題格式
\titleformat{\chapter}{\centering\Huge\bfseries}{\zhnumber{\thechapter}、}{1em} {}
%\titlespacing{\chapter}{0cm}{-1.3cm}{1em}  % 修改章節上方空白的大小



% 修改目錄的風格（縮排）
\ifthenelse{\equal{\tocStyle}{0}}{
    \titlecontents{chapter}[0em] % 數字到文字框邊
    {}{\makebox[3.8em][l]% 3.8 = 數字到文字間距
    {\zhnumber{\thecontentslabel}、}}{}
    {\titlerule*[0.4pc]{.}\contentspage}%0.4 = 點距
    
    \titlecontents{section}[1.5em]
    {}{\makebox[2.3em][l]
    {\thecontentslabel}}{}
    {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsection}[3.8em]
    {}{\makebox[3.0em][l]
    {\thecontentslabel}}{}
    {\titlerule*[0.4pc]{.}\contentspage}
}{
    \titlecontents{chapter}[0em]
    {}{\makebox[6em][l] %3.8
    {\zhnumber{\thecontentslabel}、}}{}
    {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{section}[2.0em]
    {}{\makebox[4.0em][l]
    {\thecontentslabel}}{}
    {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsection}[3em]
    {}{\makebox[3.0em][l]
    {\thecontentslabel}}{}
    {\titlerule*[0.4pc]{.}\contentspage}
}


% 修改附錄的章格式，因為附錄使用字母A,B,C所以要另外定義。這裡直接修改\appendix 的定義。
\makeatletter
\renewcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}%以上複製原book.cls定義
  \titleformat{\chapter}{\centering\Huge\bfseries}{\appendixname\thechapter、}{1em} {}% 改章首
  \titlecontents{chapter}[0em]{}{\makebox[3.8em][l]{附錄\thecontentslabel}}{}{\titlerule*[0.4pc]{.}\contentspage}% 改目錄
  \renewcommand{\chaptermark}[1]{\markboth{\thechapter、\ ##1}{}}% 改頁眉
  \@mainmattertrue}% \appendix 置於 \backmatter 之後
\makeatother  % Definition inside a definition you need to double the hash char.


% http://latexfly.com/docs/packages/fancyhdr.html
% http://tex.stackexchange.com/questions/228362/get-sectionmark-in-fancyhdr-without-chapter-number
\RequirePackage{fancyhdr}
\pagestyle{fancy} % 使用自訂的頁面風格

% http://tex.stackexchange.com/questions/290400/remove-chapter-0-from-header-in-frontmatter-chapters-with-fancyhdr
\makeatletter
\renewcommand{\chaptermark}[1]{\markboth{%
	\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter % mainmatter 才進行中文化
			\zhnumber{\thechapter}、\ % 
		\fi
	\fi
	#1}{}}
\makeatother

% \renewcommand{\chaptermark}[1]{\markboth{第\arabic{chapter}章\quad  #1 }{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
\fancyhead{} % 清除頁眉
\fancyhead[LE]{\leftmark}
\fancyhead[RO]{\rightmark}
\fancyfoot{} % 清除頁尾
\fancyfoot[CE,CO]{\thepage}
\renewcommand{\headrulewidth}{0pt} % remove line
\renewcommand{\footrulewidth}{0pt}




% FloatBarrier http://tex.stackexchange.com/questions/279/how-do-i-ensure-that-figures-appear-in-the-section-theyre-associated-with/235312#235312
% Make sure figure in the subsection.
\RequirePackage{placeins}
\let\Oldsection\section
\renewcommand{\section}{\FloatBarrier\Oldsection}
\let\Oldsubsection\subsection
\renewcommand{\subsection}{\FloatBarrier\Oldsubsection}
\let\Oldsubsubsection\subsubsection
\renewcommand{\subsubsection}{\FloatBarrier\Oldsubsubsection}


% 程式碼
\RequirePackage{listingsutf8} % for program source.
\newcommand*\lstinputpath[1]{\lstset{inputpath=#1}}
\lstinputpath{./codes/}

\RequirePackage{showexpl} % display latex code with result.(will use listings path,must change to root tex)

\RequirePackage{tikz}

% 浮水印及自動填單
\RequirePackage{eso-pic}% The zero point of the coordinate systemis the lower left corner of the page (the default).

\newcommand{\placetextbox}[3]{% \placetextbox{<horizontal pos>}{<vertical pos>}{<stuff>}
  \setbox0=\hbox{#3}% Put <stuff> in a box
  \AddToShipoutPictureFG*{% Add <stuff> to current page foreground
    \put(\LenToUnit{#1mm},\LenToUnit{#2mm}){\vtop{{\null}\makebox[0pt][c]{#3}}}%
  }%
}% mm 可取代為\paperwidth 使用比例0-1
% 選項grid標示座標

% Break long url. Only for break, \url{} from hyperref package. bibliography url can break without this package.
% \RequirePackage[hyphens, allowmove]{url}
% \makeatletter
% \g@addto@macro{\UrlBreaks}{\UrlOrds}
% \makeatother



% input users preamble
\IfFileExists{./macros_preamble.tex}{\input{./macros_preamble.tex}}{} % search only in the current directory use ./file


% this 2 pkg should in the last.
\RequirePackage{hyperref}		% url and PDF bookmarks
\providecommand\phantomsection{} % with hyperref 
% http://tex.stackexchange.com/questions/44088/when-do-i-need-to-invoke-phantomsection
% PDF Metadata with hyperref in LaTeX  https://www.karlrupp.net/2016/01/pdf-metadata-in-latex-documents/
\hypersetup{
pdftitle={\title},
pdfsubject={\title},
pdfauthor={\author},
pdfkeywords={\keywordsZh,\ \keywordsEn}
}
\RequirePackage{cleveref}
% each of the following has two versions
%   \crefname{environmentname}{singular}{plural}, to be used mid-sentence
%   \Crefname{environmentname}{singular}{plural}, to be used at the beginning of a sentence
\crefname{figure}{圖}{圖}
\crefname{table}{表}{表}
\Crefname{figure}{圖}{圖}
\Crefname{table}{表}{表}
\crefname{section}{章節}{章節}
\Crefname{section}{章節}{章節}
\crefname{equation}{式}{式}
\Crefname{equation}{式}{式}


%%%%%%%%%%%%%%%%%%%%%%% tool 
% 快速插入圖片

% easy insert single figure
% \insfig[scalefactor][label][!htb]{path}[caption][short caption]
\NewDocumentCommand\insfig{O{0.5} o O{} m O{} o}{ % need xparse package
  \begin{figure}[#3]%[!htb]
    \centering
    \includegraphics[width=#1\textwidth]{#4}
    \IfNoValueTF{#6}{\caption{#5}}{\caption[#6]{#5}}
    %\label{\IfNoValueTF{#2}{fig:#4}{#2}}
    \IfNoValueTF{#2}{\label{fig:#4}}{\ifx#2\empty\else\label{#2}\fi}
  \end{figure}
}

% make circle around letters(use tikz)
\newcommand*\circhar[1]{%
\begin{tikzpicture}
	\node[draw,circle,inner sep=1pt] {#1};
\end{tikzpicture}}

\definecolor{mygreen}{RGB}{28,172,0} % color values Red, Green, Blue
\definecolor{mylilas}{RGB}{170,55,241}
\definecolor{OliveGreen}{rgb}{0,0.6,0} % for todonotes

% 各目錄增加「頁次」文字
\addtocontents{toc}{~\hfill\textbf{頁次}\par}
\addtocontents{lof}{~\hfill\textbf{頁次}\par}
\addtocontents{lot}{~\hfill\textbf{頁次}\par}

\endinput % this must be the last command.