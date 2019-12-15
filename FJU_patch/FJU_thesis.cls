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
    \vspace*{1ex} \\
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
%        Redefine other configure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\geometry{includefoot, top=3cm, bottom=3cm, inner=3cm, outer=3cm}

\endinput % this must be the last command.