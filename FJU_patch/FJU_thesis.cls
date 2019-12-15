% This class is a link to real class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{FJU_thesis}[2019/12/15 by Retso]
% pass no defined option to book class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{thesis_base}}
% terminates the option processing.
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Load base class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass{thesis_base}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Redefine header of abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage[page,xspace]{totalcount}
\def\mcShift{\hspace{-6.0pt}} % It's for align non-multicolumn cell .
\def\abstractHeaderZh{\centering
    \abstractHeaderStyle
    \normalsize
    { \renewcommand{\arraystretch}{1}
    \begin{tabularx}{\textwidth}{l@{\hspace*{0.4em}}lXl@{\hspace*{0.4em}}l}

    \textbf{論文名稱：{\titleZh}} & & \textbf{總頁數：{\totalpages}} \\
    \par \\
    \textbf{校(院)所組別：{\collegeZh}{\deptZh}} \\
    \textbf{畢業時間：{\degreedAcademic}} \\
    \textbf{研究生：{\authorZh}} & & \textbf{指導教授：{\profsZh}} \\
    
    \end{tabularx}\par }
}

\def\abstractHeaderEn{\centering
    \abstractHeaderStyle
    \normalsize
    \textbf{\titleEn}
    { \renewcommand{\arraystretch}{1}
    \begin{tabularx}{\textwidth}{l@{\hspace*{0.4em}}XXl@{\hspace*{0.4em}}l}
    \textbf{Student:{\authorEn}} & & \textbf{Advisor:{\profsEn}} \\
    \end{tabularx}\par }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Redefine Chapter Title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@makechapterhead#1{%
  \ifzh{
    \vspace*{-1.3cm}{}
    % zh
    {
      % Abstract Header
      \ifthenelse{\equal{#1}{摘要}}{
        {\abstractHeaderZh\par}
      }{
        \ifthenelse{\equal{#1}{Abstract}}{
          {\abstractHeaderEn\par}
        }{}
      }

      % Chapter Title
      % The zh abstract title shouldn't be centering
      \ifthenelse{\equal{#1}{摘要}}{
        \normalfont \noindent #1\par
      }{
        {
          \parindent \z@ \centering \normalfont % modify by sppmg
          % The en abstract title should be base font
          \ifthenelse{\equal{#1}{Abstract}}{
            #1\par\nobreak
          }{
            \ifnum \c@secnumdepth >\m@ne
                \if@mainmatter
                    \chapterTitleStyle \zhnumber{\thechapter}、\makebox[0.5em]{} % modify by sppmg
                \fi
            \fi
            \chapterTitleStyle #1\par\nobreak % modify by sppmg
            \vskip 40\p@
          }
        }
      }
    }
  }{
    % en
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
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Redefine TOC/LOF/LOT Title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@makeschapterhead#1{%
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
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Redefine other configure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\geometry{includefoot, top=3cm, bottom=3cm, inner=3cm, outer=3cm}

\endinput % this must be the last command.