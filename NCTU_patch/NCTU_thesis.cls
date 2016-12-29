% This class is a link to real class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NCTU_thesis}[2016/11/18 by sppmg]
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

\def\abstractHeaderZh{\centering
    \abstractHeaderStyle\titleZh\par
    \vspace*{1ex}
    \normalsize
    { \renewcommand{\arraystretch}{1}
    \begin{tabularx}{\textwidth}{rlXrl}
    學生：   & \authorZh  &  & 指導教授：& \mprofZh \\
    \ifx \sprofi\empty\else 
            & \sprofiZh  &  &         &  \sprofiZh  \\ \fi
    \ifx \sprofiiZh\empty\else
            & \sprofiiZh &  &         &  \sprofiiZh \\ \fi
    \end{tabularx}\par }
    \vspace*{1em}
    國立交通大學\; \deptZh  \degreeZh 班 \par
}
\def\abstractHeaderEn{\centering
    \abstractHeaderStyle\titleEn\par
    \vspace*{1ex}
    \normalsize
    { \renewcommand{\arraystretch}{1}
    \begin{tabularx}{\textwidth}{rlXrl}
    Student: & \authorEn  &  & Advisors：& \mprofEn \\
    \ifx \sprofi\empty\else 
             & \sprofiEn  &  &           &  \sprofiEn  \\ \fi
    \ifx \sprofiiEn\empty\else
             & \sprofiiEn &  &           &  \sprofiiEn \\ \fi
    \end{tabularx}\par }
    \vspace*{1.5em}
    
    \deptEn \par
    National Chiao Tung University \par
}

\endinput % this must be the last command.