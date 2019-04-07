\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis_base}[2019/04/07 by sppmg]
% pass no defined option to book class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extbook}}
% terminates the option processing.
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        LaTeX tools
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{iftex}  % Check using TeX en­gine.(Only XeTeX.)
\ifXeTeX\else
    \ClassError{TW_Thesis_Template}{XeTeX is required.}{Please use XeLaTeX to compile this document.}
\fi

\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{ifplatform}  % only for auto select CJK font.
\RequirePackage{xparse} % advanced macro package, similar with xargs
% \RequirePackage{xargs}  % Use more than one optional parameter in a new commands , for orig todonotes macro, not require now.
% \RequirePackage{mmap} % testing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Load config.tex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifx\undefined\configured
    % --------- Define option for config.tex ----------
    \provideboolean{publish} % publish ? Set true before publish. 發佈前設true
    \provideboolean{disableChinese} % Disable chinese, for English user.
    \provideboolean{printcopyright} % print copyright text on titlepage or cover.
    \provideboolean{pdfLinkBoxDisplay} % Draw box on link in the pdf viewer.
    \provideboolean{bibStyleNameYear} % Bibliography use name,year to sort and cite.
    \provideboolean{reallyBlankPage} % Really blank pages between chapters
    \provideboolean{tocEntryToToc} % Add TOC entry to TOC
    \provideboolean{lofEntryToToc} % Add LOF entry to TOC
    \provideboolean{lotEntryToToc} % Add LOT entry to TOC
    
    % --------- Load config.tex ----------
    \IfFileExists{./config.tex}{\input{./config.tex}\gdef\configured{}}{} % search only in the current directory use ./file

    % Easy check Chinese sitting. It will not disable Chinese font.
    % Usage: \ifzh{zh}{non-zh} or \ifzh{zh}
    \ProvideDocumentCommand{\ifzh}{+m +G{}}{
    \ifthenelse{\NOT \boolean{disableChinese} \AND \equal{\lang}{zh}}{#1}{#2}
    } 
\fi
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
\RequirePackage{fontspec} % no need these package now : inputenc,xltxtra,xunicode
\ifthenelse{\boolean{disableChinese}}{}{
    \XeTeXlinebreaklocale "zh"   % 設定斷行演算法為中文
    \RequirePackage[CJKmath=true,
        slantfont,
        boldfont,
        EmboldenFactor=\fakeBoldFactor]{xeCJK} % [啟用斜體,粗體]
    \xeCJKDeclareSubCJKBlock{GreekCoptic}{ "0370 -> "03FF }% Unicode block of Greek and Coptic
}

% \setlength{\parindent}{2em} % 縮排2字寬(TL2012放導言有bug，會無效，須放內文區。TL2016可放導言)
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
\else\ifmacosx
    \def\OS{mac}
\else\ifwindows
    \def\OS{win}
\fi\fi\fi
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
            \def\CJKmainfont{AR PL UMing TW}  % 明體
        }{
            \ifthenelse{\equal{\OS}{mac}}{
                \def\CJKmainfont{LiSong Pro}  % 儷宋 Pro (明體)
            }{
                \ifthenelse{\equal{\OS}{win}}{
                    \def\CJKmainfont{MingLiU}  % 細明體
                }{
        }}}
    \fi
    \setCJKmainfont{\CJKmainfont}
    %%%
    \ifx\CJKsansfont\empty
        \ifthenelse{\equal{\OS}{linux}}{
            \def\CJKsansfont{AR PL UKai TW}  % 楷體
        }{
            \ifthenelse{\equal{\OS}{mac}}{
                \def\CJKsansfont{Kaiti TC Regular}  % 楷體-繁
            }{
                \ifthenelse{\equal{\OS}{win}}{
                    \def\CJKsansfont{DFKai-SB}  % 標楷體
                    \xeCJKDeclareSubCJKBlock{cjkO}{ `〇 } % 標楷體缺此字，issue #4 
                    \setCJKfallbackfamilyfont{cjkO}{MingLiU}
                }{
        }}}
    \fi
    \setCJKsansfont{\CJKsansfont}
    %%%
    \ifx\CJKmonofont\empty
        % 無論何種OS均設為 \CJKmainfont
        \edef\CJKmonofont{\CJKmainfont}
    \fi
    \setCJKmonofont{\CJKmonofont}
}
%%%%%%%%%%%% Auto select font end %%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Change default command behaver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---------------------- Disable \cleardoublepage in openany ---------------------------
% Disable \cleardoublepage in openany because TOC will use
% \cleardoublepage even set openany.
% And people maybe no need this in openany.
\if@openright\else
    \let\cleardoublepage\clearpage
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Chinese, for document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{disableChinese}}{}{
    \RequirePackage{zhnumber} % Translate number to Chinese number.
}

\ifzh{% 中文化變數
    \renewcommand{\chaptername}{章}
    \renewcommand{\figurename}{圖}
    \renewcommand{\tablename}{表}
    %\renewcommand{\refname}{參考資料} % book class no \refname
    \renewcommand{\bibname}{參考文獻} % biblatex need setting by \defbibheading 
    \renewcommand{\appendixname}{附錄}
    \renewcommand{\contentsname}{目錄}
    \renewcommand{\listfigurename}{圖目錄}
    \renewcommand{\listtablename}{表目錄}
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

% Use 0.1 format in \frontmatter (chapter == 0 )
% The book.cls disable ``\thechapter.'' when chapter <= 0'
\renewcommand{\theequation} {\thechapter.\arabic{equation}}
\renewcommand{\thefigure}   {\thechapter.\arabic{figure}}
\renewcommand{\thetable}    {\thechapter.\arabic{table}}


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
\ifcase \titleNumStyle
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
\ifx\undefined\thecontentslabel@chapter
\ifzh{ % TOC 章級標號形式設定
    \gdef\thecontentslabel@chapter{\zhnumber{\thecontentslabel}、}
    \gdef\thecontentslabel@chapter@app{\appendixname\thecontentslabel}
}{
    \gdef\thecontentslabel@chapter{\thecontentslabel}
    \gdef\thecontentslabel@chapter@app{\thecontentslabel}
}
\fi

% TOC 章級風格
\ifcase \tocStyleChapter 
    % \tocStyleChapter == 0 近原始 LaTeX, 向上間距、粗體、無點線
    \def\tocStyleChapterFiller{\bfseries\hfill\contentspage}
    \def\tocStyleChapterAbove{\addvspace{1em}}
    \def\tocStyleChapterAboveApp{\tocStyleChapterAbove} % appendix same
    \def\tocStyleChapterFontFM{}
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
    \def\tocStyleChapterFontFM{}
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
%     {before with label (\chapter{})}
%     {before without label (\chapter*{})}
%     {filler}[after]
% 僅接受定義當下值，後面要改須重使用 \titlecontents
% 這裡使用 \makebox 拉開標號至標題文字間距。
\titlecontents{chapter}[\tocNumSpaceC@Before] 
{\tocStyleChapterAbove}
{\tocStyleChapterFont\tocStyleChapterFontFM\makebox[\tocNumSpaceC@Total][l]{\thecontentslabel@chapter}}
{\tocStyleChapterFont\tocStyleChapterFontFM}
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
    % Chinese, translate \thechapter and remove \MakeUppercase .
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
    \renewcommand{\sectionmark}[1]{\markright {%
        \ifnum \c@secnumdepth >\z@
            \thesection \ %
        \fi
        #1}}
}{
    % English, copy from book.cls, because fancyhdr remove \if@mainmatter .
    \renewcommand{\chaptermark}[1]{\markboth {\MakeUppercase{%
            \ifnum \c@secnumdepth >\m@ne
            \if@mainmatter
                \@chapapp\ \thechapter. \ %
            \fi
            \fi
            #1}}{}}
    \renewcommand{\sectionmark}[1]{\markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
            \thesection. \ %
        \fi
        #1}}}
}

% \renewcommand{\chaptermark}[1]{\markboth{第\arabic{chapter}章\quad  #1 }{}}
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

% Really blank pages between chapters
% ref: http://www.tex.ac.uk/FAQ-reallyblank.html
\ifthenelse{\boolean{reallyBlankPage}}{
    \let\origdoublepage\cleardoublepage
    \newcommand{\clearemptydoublepage}{%
    \clearpage
    {\thispagestyle{empty}\origdoublepage}%
    }
    \let\cleardoublepage\clearemptydoublepage
}{}

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
%        TOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auto add \contentsname to TOC, similar to \listfigurename, \listtablename
\ifthenelse{\boolean{tocEntryToToc}}{
    \preto{\tableofcontents}{
        \cleardoublepage
        \phantomsection
        \addcontentsline{toc}{chapter}{\contentsname}
    }
}{}
\ifthenelse{\boolean{lofEntryToToc}}{
    \preto{\listoffigures}{
        \cleardoublepage
        \phantomsection
        \addcontentsline{toc}{chapter}{\listfigurename}
    }
}{}
\ifthenelse{\boolean{lotEntryToToc}}{
    \preto{\listoftables}{
        \cleardoublepage
        \phantomsection
        \addcontentsline{toc}{chapter}{\listtablename}
    }
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Text & bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{setspace} % for setstretch
\setstretch{\baseLineStretch} % 行距

\ifcase \bibManType
    % 0 == Embedded
    \RequirePackage[nottoc,numbib]{tocbibind} % add bibliography to TOC.
\or
    % 1 == BibTeX
    \RequirePackage[nottoc,numbib]{tocbibind} % add bibliography to TOC.
%     \renewcommand{\tocbibname}{參考文獻} % Need tocbibind pkg , auto get \bibname
\or
    % 2 == biber / BibLaTeX
    % Add bibliography by \addbibresource{bibfile.bib} in macros_preamble.tex
    \ifthenelse{\boolean{bibStyleNameYear}}{
        \RequirePackage[backend=biber,style=\bibStyle, citestyle=authoryear-comp, sorting=nyt]{biblatex}
        % sorting see doc or https://tex.stackexchange.com/a/51439
    }{
        \RequirePackage[backend=biber,style=\bibStyle]{biblatex}
        % use biblatex and sort by citation order
    }
    \def\bibfont{\bibFontStyle\setstretch{\bibLineStretch}} % font setting of BibLaTeX
    % BibLaTeX no need tocbibind 
    % \bibname and \refname can't work with BibLaTeX, so use option of \printbibliography.
    
    % Add style dependent packages and setting.
    \ifthenelse{\equal{\bibStyle}{apa}}{
        \RequirePackage{csquotes}
        \DeclareLanguageMapping{english}{american-apa}
    }{}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        figure & float env.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------- graphics ----------------------------
% creating graphics programmatically
\RequirePackage{tikz} % To avoid transparent problem in 1st page, it must load before ``pdfpages''.

\RequirePackage{graphicx} % include graphics
\graphicspath{ {./figures/} {../figures/} } % add path

\RequirePackage{pdfpages} % Insert PDF file by  \includepdf[pages={1,3,5}]{myfile.pdf}

% --------------------- float env. ----------------------------
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

% --------------------- watermark ----------------------------
% 浮水印及自動填單
\RequirePackage{eso-pic}% The zero point of the coordinate systemis the lower left corner of the page (the default).

% Add logo to every page after \startWatermark.
% Package (\wmMethod) bug / disadvantages:
% background: Background failed in \includepdf page.
% eso-pic: Opacity failed in first image.
\ifthenelse{\boolean{publish} \AND \NOT \equal{\wmContent}{}}{
    % Determine use text or image (if exist).
    \IfFileExists{./figures/\wmContent}{
        \def\realWmContent{\includegraphics{\wmContent}}
    }{
        \def\realWmContent{\wmContent}
    }
    
    \ifcase \wmMethod
        % 0 == background package 
        % background package use xshift of node in tikzpicture with scale,
        % So shift also scaled. here define ``length'' type variable because
        % need calculate : ShiftFromCenter / Scale
        \newlength{\wmBgShiftFromCenterX}
        \setlength{\wmBgShiftFromCenterX}{\wmShiftFromCenterX}
        \newlength{\wmBgShiftFromCenterY}
        \setlength{\wmBgShiftFromCenterY}{\wmShiftFromCenterY}
        
        \RequirePackage[
            pages=all,
            scale=\wmScale,
            angle=\wmAngle,
            opacity=\wmOpacity,
            hshift=\wmBgShiftFromCenterX/\wmScale, % x=0 for center
            vshift=\wmBgShiftFromCenterY/\wmScale, % y=0 for center
            contents={} % Clean default BgContents (before \startWatermark, don't add \realWmContent in here).
        ]{background}
        
        \newcommand{\startWatermark}{
            \ifthenelse{\NOT \boolean{wmStarted} }{
                \backgroundsetup{contents={\realWmContent}}
                \setboolean{wmStarted}{true}
            }{}
        }
        
    \or
        % 1 == eso-pic package, 
        % \RequirePackage{eso-pic} % Readey in above.
        \newcommand{\startWatermark}{
            \ifthenelse{\NOT \boolean{wmStarted} }{
                \AddToShipoutPictureBG{%
                    \AtPageCenter{%
                        \put(
                            \LenToUnit{\wmShiftFromCenterX},
                            \LenToUnit{\wmShiftFromCenterY}
                        ){
                            \tikz[overlay] 
                                \node[opacity=\wmOpacity, inner sep=0pt, rotate=\wmAngle, scale=\wmScale] {
                                    \realWmContent
                                };
                        }
                    }
                }
                
                \setboolean{wmStarted}{true}
            }{}
        }
        
    \fi
    
    % Lazy version \startWatermark
    % It will stay in cover/titlepage and start watermark automaticlly.
    \newcommand{\lazyStartWatermark}{
            \stepcounter{phyPage}
            
            \ifcase \wmMethod
                % 0 == background package 
                \ifthenelse{\boolean{wmStarted} \OR \value{phyPage}>\wmStartPage \OR \value{phyPage}=\wmStartPage}{
                    \startWatermark
                    \BgThispage
                }{} % It's only way for work with everypage in my case ....
            \or
                % 1 == eso-pic package, 
                \ifnum\value{phyPage}=\wmStartPage
                    \startWatermark
                \fi
            \fi
    }
    \newboolean{wmStarted}
    \setboolean{wmStarted}{false} % mark wm started by \startWatermark .
    \newcounter{phyPage} % The ``page'' counter always 1 in titlepage, so count by ourselves.

    \RequirePackage{everypage}
    \AddEverypageHook{\lazyStartWatermark}
    
}{
    \newcommand{\startWatermark}{}
}

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

\RequirePackage[version=4]{mhchem} % usage \ce{KH2PO4}

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
    \crefname{figure}{\figurename}{\figurename}
    \Crefname{figure}{\figurename}{\figurename}
    \crefname{table}{\tablename}{\tablename}
    \Crefname{table}{\tablename}{\tablename}
    \crefname{equation}{式}{式}
    \Crefname{equation}{式}{式}
    \crefname{section}{章節}{章節}
    \Crefname{section}{章節}{章節}
    \crefname{appendix}{\appendixname}{\appendixname}
    \Crefname{appendix}{\appendixname}{\appendixname}
}

% Load packages after ``hyperref'' from ``macros_preamble.tex''
\macrosAfterHyperref

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        My tools
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{sppmgTools}

\endinput % this must be the last command.
