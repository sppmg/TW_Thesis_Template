\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NCU_thesis_extbook}[2016/11/18 by sppmg]
% pass no defined option to book class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extbook}}
% terminates the option processing.
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        LaTeX tools
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\listfiles % display used package list in .log file, information for develop.
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{ifplatform}  % only for auto select CJK font.
\RequirePackage{xparse} % advanced macro package, similar with xargs
% \RequirePackage{xargs}  % Use more than one optional parameter in a new commands , for orig todonotes macro, not require now.
% \RequirePackage{mmap} % testing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Load config.tex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------- Define option for config.tex ----------
\provideboolean{publish} % publish ? Set true before publish. 發怖前設true
\provideboolean{disableChinese} % Disable chinese, for English user.
\provideboolean{printcopyright} % print copyright text on titlepage or cover.
\provideboolean{pdfLinkBoxDisplay} % Draw box on link in the pdf viewer.
\provideboolean{bibStyleNameYear} % bibliography use name,year to sort and cite.

% --------- Load config.tex ----------
\IfFileExists{./config.tex}{\input{./config.tex}}{} % search only in the current directory use ./file

% Easy check Chinese sitting. It will not disable Chinese font.
% Usage: \ifzh{zh}{non-zh} or \ifzh{zh}
\NewDocumentCommand{\ifzh}{+m +G{}}{
\ifthenelse{\NOT \boolean{disableChinese} \AND \equal{\lang}{zh}}{#1}{#2}
} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Load base class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass[a4paper,\baseFontSize]{extbook}

%%%%%%%%%%%%%%% Load additional packages and commands. %%%%%%%%%%%%%%%

\setcounter{secnumdepth}{\secNumDepth} % 設定章節標題給予數字標號的深度, \paragraph == 4。
\setcounter{tocdepth}{\tocDepth}  % 目錄顯示層級，\subsection == 2。


\PassOptionsToPackage{hyphens, allowmove}{url} % testing for break url

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chinese, XeLaTeX with Chinese
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (xeCJK will load fontspec and set \XeTeXlinebreaklocale , but I still keep it.)
\XeTeXlinebreakskip = 0pt plus 1pt   % 設定中文字距與英文字距
\ifthenelse{\boolean{disableChinese}}{}{
    \XeTeXlinebreaklocale "zh"   % 設定斷行演算法為中文
    \RequirePackage[slantfont, boldfont, AutoFakeBold=\fakeBoldLevel]{xeCJK} % [啟用斜體,粗體]
}
\RequirePackage{fontspec} % no need these package now : inputenc,xltxtra,xunicode
% \setlength{\parindent}{3em} %縮排約2字寬
% Linux 利用指令 fc-list :lang=zh 來查詢可以用的字體名稱。
%\setmainfont{DejaVu Sans} % ==\setromanfont
%\setmonofont[Ligatures=Historical]{DejaVu Sans Mono}
% \setCJKmainfont{AR PL UMing TW MBE} % 襯線字體(\rmfamily)，中文設為明體
% \setCJKsansfont{AR PL UKai TW MBE} % 原意為無襯線字體(\sffamily)，中文設為楷體
% \setCJKmonofont[Scale=0.9]{AR PL UMing TW MBE} % (\ttfamily)

%%%%%%%%%%% Auto select font %%%%%%%%%%%%%%
% Use ifplatform package to determine OS and overwrite \OS.
% It's need option ``-shell-escape'' to XeLaTeX.
% If no this option , It's only determine windows.
% (Texstudio may default use -shell-escape)
\iflinux
    \def\OS{linux}
\else\ifwindows
    \def\OS{win}
\fi\fi
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
\ifthenelse{\boolean{disableChinese}}{}{
    \ifx\CJKmainfont\empty
        \ifthenelse{\equal{\OS}{linux}}{
            % linux os
            \setCJKmainfont{AR PL UMing TW}  % 明體
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
            \setCJKsansfont{AR PL UKai TW}  % 楷體
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
            \setCJKmonofont{AR PL UMing TW} % 明體
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
}
%%%%%%%%%%%% Auto select font end %%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Chinese, for document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifzh{
    \RequirePackage{zhnumber} % Translate number to Chinese number.
    
    % 中文化變數
    \renewcommand{\chaptername}{章}
    \renewcommand{\figurename}{圖}
    \renewcommand{\tablename}{表}
    %\renewcommand{\refname}{參考資料} % book class no \refname
    \renewcommand{\bibname}{參考文獻} % biblatex need setting by \defbibheading 
    \renewcommand{\appendixname}{附錄}
    \renewcommand\contentsname{目錄}
    \renewcommand\listfigurename{圖目錄}
    \renewcommand\listtablename{表目錄}
    % \cref setting in the last .
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Style
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%設定頁面配置
\RequirePackage[a4paper, top=2.5cm, bottom=2.5cm, inner=3cm, outer=2cm, marginparwidth=2.0cm]{geometry}% use showframe in class option for check. marginparwidth for todonotes
%http://tex.stackexchange.com/questions/5180/how-can-i-get-todonotes-in-the-left-marginparwidth
\RequirePackage{xcolor}  % Coloured text etc.
\RequirePackage{indentfirst} % 章節首行縮排
% \setcounter{secnumdepth}{3}  % 顯示至\subsubsection 的標號，LaTeX 預設2 , move to config.tex

% ---------------------- Packages for title and TOC ---------------------------
\RequirePackage{titlesec}
\RequirePackage{titletoc}

% ---------------------- Chapter title style ---------------------------
% 1. Change title to zhnumber when lang=zh (in config.tex).
% 2. Add header to abstract. (depend on chapter title)
% ref: LaTeX 章節名稱及目錄改為中文 http://lzsh00262.blogspot.tw/2013/02/xelatex.html
% \titleformat{\chapter}{\centering\Huge\bfseries}{\zhnumber{\thechapter}、}{1em} {} 
% Little hack here because need add header to abstract. You should use \titleformat(above) to do that, if you don't need header.(\titleformat is not compatible for this hack.)

% abstract use special header(copy and modify from book.cls)
\def\abstractHeaderZh{\centering\abstractHeaderStyle\titleZh}
\def\abstractHeaderEn{\centering\abstractHeaderStyle\titleEn}
% modify \chapter, add hearer if abstract. use zhnumber if mainmatter, all centering.
\def\@makechapterhead#1{%
  \vspace*{10\p@} % modify by sppmg
  \ifthenelse{\equal{#1}{摘要}}{{\abstractHeaderZh\par}}
    {\ifthenelse{\equal{#1}{Abstract}}{{\abstractHeaderEn\par}}{\vspace*{20\p@}}} % modify by sppmg
    % \abstractHeader don't forget {} for \centering
  \vspace*{20\p@}%  orig = 50pt
  \ifzh{
    % Chinese
    {\parindent \z@ \centering \normalfont % modify by sppmg
        \ifnum \c@secnumdepth >\m@ne
            \if@mainmatter
                \chapterTitleStyle \zhnumber{\thechapter}、\makebox[0.5em]{} % modify by sppmg
            \fi
        \fi
        \chapterTitleStyle #1\par\nobreak % modify by sppmg
        \vskip 40\p@
    }
  }{
    % English
    {\parindent \z@ \raggedright \normalfont 
        \ifnum \c@secnumdepth >\m@ne
            \if@mainmatter
                \chapterTitleNumStyle \@chapapp\space \thechapter % modify by sppmg
                \par\nobreak
                \vskip 20\p@
            \fi
        \fi
        \interlinepenalty\@M
        \chapterTitleStyle #1\par\nobreak % modify by sppmg
        \vskip 40\p@
    }
  }}
% modify \chapter*, all centering. (TOC/LOF/LOT use \chapter*)
\def\@makeschapterhead#1{%
    \vspace*{50\p@}%
    {
    \ifzh{
        % Chinese
        \parindent \z@ \centering % modify by sppmg
    }{
        % English
        \parindent \z@ \raggedright
    }
    \normalfont
    \interlinepenalty\@M
    \chapterTitleStyle  #1\par\nobreak
    \vskip 40\p@
  }}
% 修改每章首頁的標題格式
%\titleformat{\chapter}{\centering\Huge\bfseries}{\zhnumber{\thechapter}、}{1em} {}
%\titlespacing{\chapter}{0cm}{-1.3cm}{1em}  % 修改章節上方空白的大小


% --------------------- title's style and font style ----------------------------
% http://tex.stackexchange.com/questions/59726/change-size-of-section-subsection-subsubsection-paragraph-and-subparagraph-ti
\titleformat*{\section}{\sectionTitleStyle}
\titleformat*{\subsection}{\subsectionTitleStyle}
\ifcase \titleStyle
    \titleformat*{\subsubsection}{\subsubsectionTitleStyle}
    \titleformat*{\paragraph}{\paragraphTitleStyle}
\or
    \titleformat{\subsubsection}{\subsubsectionTitleStyle}{\arabic{subsubsection}.}{0.5em}{}
    \titlespacing*{\subsubsection}{\indentBlockSSS}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
    \titleformat{\paragraph}[hang]{\paragraphTitleStyle}{(\arabic{paragraph})}{0.5em}{}
    \titlespacing*{\paragraph}{\indentBlockPar}{3.25ex plus 1ex minus .2ex}{1em}
\fi
\titleformat*{\subparagraph}{\subparagraphTitleStyle}

% --------------------- TOC style ----------------------------
% 修改目錄的風格（縮排）

\ifzh{ % TOC 章級標號形式設定
    \gdef\thecontentslabel@chapter{\zhnumber{\thecontentslabel}、}
    \gdef\thecontentslabel@chapter@app{\appendixname\thecontentslabel}
}{
    \gdef\thecontentslabel@chapter{\thecontentslabel}
    \gdef\thecontentslabel@chapter@app{\thecontentslabel}
}

% TOC 章級風格
\ifcase \tocStyleChapter 
    % \tocStyleChapter == 0 近原始 LaTeX, 向上間距、粗體、無點線
    \def\tocStyleChapterFiller{\bfseries\hfill\contentspage}
    \def\tocStyleChapterAbove{\addvspace{1em}}
    \def\tocStyleChapterAboveApp{\tocStyleChapterAbove} % appendix same
    \def\tocStyleChapterFont{\bfseries}  
\or
    % \tocStyleChapter == 1 向上間距(至 \mainmatter 才增加)、粗體、無點線
    \def\tocStyleChapterFiller{\bfseries\hfill\contentspage}
    \def\tocStyleChapterAbove{}
    \def\tocStyleChapterAboveApp{\addvspace{1em}} % appendix same
    \def\tocStyleChapterFont{\bfseries}
    \appto{\mainmatter}{ % 至 \mainmatter 才增加 chapter 向上間距
        \titlecontents{chapter}[\tocNumSpaceC@Before]
        {\addvspace{1em}}
        {\tocStyleChapterFont\makebox[\tocNumSpaceC@Total][l]{\thecontentslabel@chapter}}
        {\tocStyleChapterFont}
        {\tocStyleChapterFiller}
    }{}{}
\or 
    % \tocStyleChapter == 2 正常間距、正常字體、點線
    \def\tocStyleChapterFiller{\titlerule*[0.4pc]{.}\contentspage}
    \def\tocStyleChapterAbove{}
    \def\tocStyleChapterAboveApp{\tocStyleChapterAbove} % appendix same
    \def\tocStyleChapterFont{}
\fi

% \tocNumSpaceC@Before = 數字到文字框邊 , \tocNumSpaceC@Total = 數字到章名間距
% \appendix will change \titlecontents{chapter}, see below.
\ifcase \tocStyleAlign
    % \tocStyleAlign == 0 , (en == LaTeX default)
    \def\tocNumSpaceC@Before  {0em}     % chapter
    \ifzh{
        \def\tocNumSpaceC@Total   {3.8em}   % en = 1.5 zh = 3.8
    }{
        \def\tocNumSpaceC@Total   {1.5em}
    }
    \def\tocNumSpaceS@Before  {1.5em}   % section
    \def\tocNumSpaceS@Total   {2.3em}
    \def\tocNumSpaceSS@Before {3.8em}   % subsection
    \def\tocNumSpaceSS@Total  {3.0em}
\or
    % \tocStyleAlign == 1
    \def\tocNumSpaceC@Before  {0em}
    \def\tocNumSpaceC@Total   {6em}
    \def\tocNumSpaceS@Before  {2em}
    \def\tocNumSpaceS@Total   {4em}
    \def\tocNumSpaceSS@Before {3em}
    \def\tocNumSpaceSS@Total  {3em}
\fi

% \titlecontents{section}[left (to margin)]
%     {above} % 數字到文字框(頁)邊
%     {before with labal (\chapter{})}
%     {before without labal (\chapter*{})}
%     {filler}[after]
% 僅接受定義當下值，後面要改須重使用 \titlecontents
% 這裡使用 \makebox 拉開標號至標題文字間距。
\titlecontents{chapter}[\tocNumSpaceC@Before] 
{\tocStyleChapterAbove}
{\tocStyleChapterFont\makebox[\tocNumSpaceC@Total][l]{\thecontentslabel@chapter}}
{\tocStyleChapterFont}
{\tocStyleChapterFiller}
% ----------------------------
\titlecontents{section}[\tocNumSpaceS@Before]
{}{\makebox[\tocNumSpaceS@Total][l]
{\thecontentslabel}}{}
{\titlerule*[0.4pc]{.}\contentspage}%0.4 = 點距
% ----------------------------
\titlecontents{subsection}[\tocNumSpaceSS@Before]
{}{\makebox[\tocNumSpaceSS@Total][l]
{\thecontentslabel}}{}
{\titlerule*[0.4pc]{.}\contentspage}

% 各目錄增加「頁次」文字
\ifzh{\def\@textPage{頁次}}{\def\@textPage{page}}
\addtocontents{toc}{~\hfill\textbf{\@textPage}\par}
\addtocontents{lof}{~\hfill\textbf{\@textPage}\par}
\addtocontents{lot}{~\hfill\textbf{\@textPage}\par}

% --------------------- Header of each page ----------------------------
% http://latexfly.com/docs/packages/fancyhdr.html
% http://tex.stackexchange.com/questions/228362/get-sectionmark-in-fancyhdr-without-chapter-number
\RequirePackage{fancyhdr}
\pagestyle{fancy} % 使用自訂的頁面風格

% http://tex.stackexchange.com/questions/290400/remove-chapter-0-from-header-in-frontmatter-chapters-with-fancyhdr
\ifzh{
\renewcommand{\chaptermark}[1]{\markboth{%
    \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter % mainmatter 才進行中文化
            \expandafter\ifx\@chapapp\appendixname % in \appendix
                \thechapter、\ % 
            \else
                \zhnumber{\thechapter}、\ %
            \fi
        \fi
    \fi
    #1}{}}
}

% \renewcommand{\chaptermark}[1]{\markboth{第\arabic{chapter}章\quad  #1 }{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
\fancyhead{} % 清除頁眉
\fancyhead[LE]{\pageHeaderStyle\leftmark}
\fancyhead[RO]{\pageHeaderStyle\rightmark}
\fancyfoot{} % 清除頁尾
\fancyfoot[C]{\pageFooterStyle\thepage}
\renewcommand{\headrulewidth}{0pt} % remove line
\renewcommand{\footrulewidth}{0pt}

% Redefine the plain page style (\chapter page will use plain style)
\fancypagestyle{plain}{%
    \fancyhf{}%
    \fancyfoot[C]{\pageFooterStyle\thepage}%
    \renewcommand{\headrulewidth}{0pt} % remove line
    \renewcommand{\footrulewidth}{0pt}
}

% ---------------------- appendix title, header & TOC ---------------------------
% 修改附錄的章格式，因為附錄使用字母A,B,C所以要另外定義。這裡使用etoolbox 附加指令到\appendix。
\apptocmd{\appendix}{
    \ifzh{
        \titleformat{\chapter}{\centering\chapterTitleStyle}{\appendixname\thechapter}{1em}{} % 改章首
    }{}
    \titlecontents{chapter} % 改目錄
        [\tocNumSpaceC@Before]
        {\tocStyleChapterAboveApp}
        {\tocStyleChapterFont\makebox[\tocNumSpaceC@Total][l]{\thecontentslabel@chapter@app}}
        {\tocStyleChapterFont}
        {\tocStyleChapterFiller}
    \@mainmattertrue % \appendix 置於 \backmatter 之後
}{}{}

% --------------------- Some color definition ----------------------------
% Require xcolor . color values Red, Green, Blue
\definecolor{mygreen}{RGB}{28,172,0} 
\definecolor{mylilas}{RGB}{170,55,241}
\definecolor{OliveGreen}{rgb}{0,0.6,0} % for todonotes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Text & bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{lmodern}
\RequirePackage{setspace} % for setstretch
\setstretch{\baseLineStretch} % 行距

% bibliography use biber(external program) and biblatex(package)
% \RequirePackage[nottoc,numbib]{tocbibind} % add bibliography to TOC, not require for biblatex
%\renewcommand{\tocbibname}{參考文獻} % no effect
\ifthenelse{\boolean{bibStyleNameYear}}{
    \RequirePackage[backend=biber,style=nature, citestyle=authoryear-comp, sorting=nyt]{biblatex}
}{
    \RequirePackage[backend=biber,style=nature]{biblatex} 
    % use biblatex and sort by citation order
}
% http://tex.stackexchange.com/questions/51434/biblatex-citation-order
% use \addbibresource{bib.bib} in preamble
% \defbibheading{\bibname} % biblatex use \defbibheading
\def\bibfont{\bibFontStyle\setstretch{\bibLineStretch}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        figure & float env.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx} % include graphics
\graphicspath{ {./figures/} {../figures/} } % add path
\RequirePackage{pdfpages} % Insert PDF file by  \includepdf[pages={1,3,5}]{myfile.pdf}
\RequirePackage[format=hang]{caption}
\RequirePackage{subcaption}  % subfigure
\captionsetup{subrefformat=parens} % \subref style is (a)
\DeclareCaptionFont{myCaptionStyle}{\captionFontStyle}
\captionsetup{font={myCaptionStyle,stretch=\captionLineStretch}}
\DeclareCaptionFont{myCaptionSubStyle}{\subcaptionFontStyle}
\captionsetup[sub]{font=myCaptionSubStyle}

% FloatBarrier http://tex.stackexchange.com/questions/279/how-do-i-ensure-that-figures-appear-in-the-section-theyre-associated-with/235312#235312
% Make sure figure in the subsection.
\RequirePackage{placeins}
\let\Oldsection\section
\renewcommand{\section}{\FloatBarrier\Oldsection}
\let\Oldsubsection\subsection
\renewcommand{\subsection}{\FloatBarrier\Oldsubsection}
\let\Oldsubsubsection\subsubsection
\renewcommand{\subsubsection}{\FloatBarrier\Oldsubsubsection}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{tabularx}   % for table which specified width. tabulary also can do it.
\RequirePackage{multirow}   % for table
\RequirePackage{colortbl} % color table
\renewcommand{\arraystretch}{\tableLineStretch}
\RequirePackage{floatrow} % set caption position of table
\floatsetup[table]{capposition=top}
\DeclareFloatFont{myFloatStyle}{\floatFontStyle} % see, floatrow pkg. 3.6.3 float font option
\floatsetup{font=myFloatStyle}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Math/Science
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{amsmath}
\RequirePackage{siunitx}
\sisetup{per-mode=symbol, range-phrase=$\:\sim\:$} % \per default use / not ^-1 , change ``to'' to ``~''
% set a new ``molar'' unit
\DeclareSIUnit\molar{\mole\per\cubic\deci\metre}
\DeclareSIUnit\Molar{\textsc{m}}

\RequirePackage[version=3]{mhchem} % usage \ce{KH2PO4}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Misc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------- todonotes ----------------------------
\ifthenelse{\boolean{publish}}{
    \RequirePackage[disable]{todonotes}     % hide notes
}{
    \RequirePackage[colorinlistoftodos,prependcaption,textsize=footnotesize]{todonotes}
}
\reversemarginpar % add this after loading the geometry and todonotes packages
%http://tex.stackexchange.com/questions/5180/how-can-i-get-todonotes-in-the-left-margin
% textsize=footnotesize

% --------------------- Program code ----------------------------
% 程式碼
\RequirePackage{listingsutf8} % for program source.
\newcommand*\lstinputpath[1]{\lstset{inputpath=#1}}
\lstinputpath{./codes/}

% --------------------- graphics ----------------------------
% creating graphics programmatically
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

% --------------------- show LaTeX  ----------------------------
% This is for \parindent in LTXexample env. \parindentsave in macros_preamble.tex,
% so creat \parindentsave here even did not use showexpl package.
% see. http://tex.stackexchange.com/questions/98302/how-to-prevent-ltxexample-from-ignoring-the-paragraph-indentation
\newlength{\parindentsave}
\AtBeginDocument{\setlength{\parindentsave}{\parindent}}

% --------------------- Break long url ----------------------------
% Break long url. Only for break, \url{} from hyperref package. bibliography url can break without this package.
% \RequirePackage[hyphens, allowmove]{url}
% \makeatletter
% \g@addto@macro{\UrlBreaks}{\UrlOrds}
% \makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Load/set user's macro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input users preamble
\IfFileExists{./macros_preamble.tex}{\input{./macros_preamble.tex}}{} % search only in the current directory use ./file
% A hook for run cmd ever begin{document}
\IfFileExists{./macros_document.tex}{\AtBeginDocument{\input{./macros_document.tex}}}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Last pkg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this 2 pkg should in the last.
\RequirePackage{hyperref}       % url and PDF bookmarks
\providecommand\phantomsection{} % with hyperref
% http://tex.stackexchange.com/questions/44088/when-do-i-need-to-invoke-phantomsection
% PDF Metadata with hyperref in LaTeX  https://www.karlrupp.net/2016/01/pdf-metadata-in-latex-documents/
\hypersetup{
pdftitle={\title},
pdfsubject={\ifx\subtitle\empty\title\else\subtitle\fi},
pdfauthor={\author},
pdfkeywords={\keywordsZh,\ \keywordsEn}
}
\ifthenelse{\boolean{pdfLinkBoxDisplay}}{}{
    \hypersetup{pdfborder = {0 0 0 0}} } % 0 -> Don't draw box on link in the pdf

\RequirePackage{cleveref}
% each of the following has two versions
%   \crefname{environmentname}{singular}{plural}, to be used mid-sentence
%   \Crefname{environmentname}{singular}{plural}, to be used at the beginning of a sentence
\ifzh{
\crefname{figure}{圖}{圖}
\crefname{table}{表}{表}
\Crefname{figure}{圖}{圖}
\Crefname{table}{表}{表}
\crefname{section}{章節}{章節}
\Crefname{section}{章節}{章節}
\crefname{equation}{式}{式}
\Crefname{equation}{式}{式}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        My tools
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

% make circle around letters (use tikz, copy from other guy)
\newcommand*\circhar[1]{%
\begin{tikzpicture}
    \node[draw,circle,inner sep=1pt] {#1};
\end{tikzpicture}}


\endinput % this must be the last command.