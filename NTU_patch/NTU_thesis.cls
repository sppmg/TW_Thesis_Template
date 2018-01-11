% This class is a patch to NCU class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NTU_thesis}[2018/01/11 by sppmg]
% pass no defined option to book class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{thesis_base}}
% terminates the option processing.
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        LaTeX tools (before base class)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{ifthen}
\RequirePackage{xparse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Load config.tex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifx\undefined\configured
    % --------- Define option for config.tex ----------
    \provideboolean{publish} % publish ? Set true before publish. 發怖前設true
    \provideboolean{disableChinese} % Disable chinese, for English user.
    \provideboolean{printcopyright} % print copyright text on titlepage or cover.
    \provideboolean{pdfLinkBoxDisplay} % Draw box on link in the pdf viewer.
    \provideboolean{bibStyleNameYear} % bibliography use name,year to sort and cite.
    \provideboolean{reallyBlankPage} % Really blank pages between chapters
    
    % --------- Load config.tex ----------
    \IfFileExists{./config.tex}{\input{./config.tex}\gdef\configured{}}{} % search only in the current directory use ./file

    % Easy check Chinese sitting. It will not disable Chinese font.
    % Usage: \ifzh{zh}{non-zh} or \ifzh{zh}
    \ProvideDocumentCommand{\ifzh}{+m +G{}}{
        \ifthenelse{\NOT \boolean{disableChinese} \AND \equal{\lang}{zh}}{#1}{#2}
    } 
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Presetting for NTU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifzh{ % TOC 章級標號形式設定
    \gdef\thecontentslabel@chapter{第\,\zhnumber{\thecontentslabel}\,章}
    \gdef\thecontentslabel@chapter@app{\appendixname\thecontentslabel}
}{
    \gdef\thecontentslabel@chapter{\thecontentslabel}
    \gdef\thecontentslabel@chapter@app{\thecontentslabel}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Load base class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass{thesis_base}

%%%%% Load additional packages and commands.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Change setting for NTU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ---------------------- Margin of content ---------------------------
\geometry{top=3cm, bottom=2cm, inner=3cm, outer=3cm}

% ---------------------- Chapter title style ---------------------------
\ifzh{
    \patchcmd{\@makechapterhead}
    {\zhnumber{\thechapter}、\makebox[0.5em]{}}
    {第\zhnumber{\thechapter}章\makebox[0.5em]{}}{}{}
}
% ---------------------- Page header ---------------------------
\ifzh{
    % \mainmatter
    \patchcmd{\chaptermark}
    {\zhnumber{\thechapter}、}
    {第\zhnumber{\thechapter}章}{}{}
    % \appendix
    \patchcmd{\chaptermark}
    {\thechapter、}
    {附錄\thechapter\enspace}{}{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Command for NTU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---------------------- Vertical CJK ---------------------------
\ifthenelse{\boolean{disableChinese}}{}{
% Vertical with fixed base line in a rotatebox box.
% ref: http://tex.stackexchange.com/questions/11913/baseline-shift-with-fontspec
\newCJKfontfamily{\vCJKFamily}[Vertical=RotatedGlyphs]{\CJKsansfont}
% Fix base line of Vertical CJK
\def\vCJKShiftSymbol#1{\raise.35em\hbox{#1}}
\def\vCJKBL{\let\CJKsymbol\vCJKShiftSymbol
             \let\CJKpunctsymbol\vCJKShiftSymbol} 
\def\vCJK#1{\vCJKBL\vCJKFamily\rotatebox{270}{#1}} % Short macro to do all thing of vertical typing.
}


% ---------------------- Book spine ---------------------------
% Add book spine in this page
\newcommand{\addBookSpineThisPage}{
    \ifthenelse{\boolean{disableChinese}}{}{
        \AddToShipoutPictureFG*{% 
            \AtPageUpperLeft{%
                \put(\LenToUnit{1.5mm},\LenToUnit{0mm}){\vCJK {
                    \renewcommand{\arraystretch}{1}
                    \setstretch{1}
                    \begin{tabularx}{290mm}{lXcXcXcXrl} 
                    \fs{12}國立臺灣大學 & 
                    \multirow{2}{*}{} &
                    \multirow{2}{*}{\fs{12}\degreeZh 論文} &
                    \multirow{2}{*}{} &
                    \multirow{2}{*}{\fs{14}\title} & 
                    \multirow{2}{*}{} &
                    \multirow{2}{*}{\fs{14}\author \quad 撰} & 
                    \multirow{2}{*}{} &
                    \multirow{2}{*}{\rotatebox[origin=r]{90}{\fs{14}\degreeyearROC}} &
                    \multirow{2}{*}{\raisebox{-0.6em}{\rotatebox[origin=r]{90}{\fs{14}\degreesemesterROC}}} \\ 
                    \fs{12}\deptZh   & & & & & & & & & \\ % 
                    \end{tabularx} 
                }
                \vrule
            }} % 
        }
    }% disableChinese
} 


% ---------------------- DOI ---------------------------
% Add DOI to every page after this command.
\newcommand{\startDOI}{
\ifx\doi\empty\else
\AddToShipoutPictureBG{%
    \AtPageUpperLeft{%
        \makebox[\paperwidth][r]{% Move over to right so right aligns with right of text block
            \raisebox{-\paperheight}{% Drop down so top aligns with top of text block
                \put(\LenToUnit{-1cm},\LenToUnit{1cm}){%
                    \makebox[0pt][r]{\fs{12}\href{http://dx.doi.org/\doi}{doi:\doi}}
                }
        }}
    }%
}
\fi}


\endinput % this must be the last command.
