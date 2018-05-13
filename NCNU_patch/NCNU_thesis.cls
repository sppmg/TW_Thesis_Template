% This class is a link to real class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NCNU_thesis}[2018/05/13 by sppmg]
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

% I use LaTeX3 to automatically generate name table. 
% Below \ExplSyntaxOn to \ExplSyntaxOff perpare prof. table contents,
% it will save contents to `\profsTableContent''. 
% You can ignore this block even you want make table by yourself.
\ExplSyntaxOn


\cs_new:Npn \sppmg_makeAbsTableContent:NNNn #1#2#3#4 {
    % Copy prof. list from config.tex
    \clist_gclear_new:N \g_sppmg_profs_cl
    \clist_gset:NV \g_sppmg_profs_cl #1

    % get total number of prof. . Omitted language will not display.
    \int_gzero_new:N \g_sppmg_profTotal_int 
    \int_gset:Nn \g_sppmg_profTotal_int {\clist_count:N \g_sppmg_profs_cl} 

    % NOTE: ``tabularx'' will  processes its contents more than once 
    % for calculate width, so ``gpop'' can't put in tabularx env.
    \tl_gclear_new:N \g_sppmg_tableContent_tl

    % For abstractHeader. pop Advisor first.
    \clist_gpop:NNTF \g_sppmg_profs_cl \l_tmpa_tl {}{ \tl_clear:N \l_tmpa_tl}
    \cs_gset_eq:NN #2 \l_tmpa_tl

    % Use a inline function for pop list , and save table content 
    % Input(#1) switch 3 case, 1 = Advisor, 2 = committee member , 3+ is more.
    % Use ``for'' loop to get all prof.
    \int_step_inline:nnnn {2}{1}{\g_sppmg_profTotal_int}{
        \clist_gpop:NNTF \g_sppmg_profs_cl \l_tmpa_tl {}{ \tl_clear:N \l_tmpa_tl}
        \tl_gput_right:Nx \g_sppmg_tableContent_tl {
            \int_case:nnTF {##1}{
%                 {1} {指導教授： & \l_tmpa_tl & 博士 & \exp_not:n {\\} }
                {2} { & & & 
                        \tl_if_eq:nnTF {#4}{zh}{共同指導：}{Co-advisor:} 
                    & \l_tmpa_tl \exp_not:n {\\} }
            }{}{
                & & & & \l_tmpa_tl  \exp_not:n {\\} 
            }
        }
    }

    % Copy contents to LaTeX2e macro.
    \cs_gset_eq:NN #3 \g_sppmg_tableContent_tl
}

\sppmg_makeAbsTableContent:NNNn \profsZh \mprofZh \profsTableContentAbsZh {zh}
\sppmg_makeAbsTableContent:NNNn \profsEn \mprofEn \profsTableContentAbsEn {en}

\cs_undefine:N \sppmg_makeAbsTableContent:NNNn

\ExplSyntaxOff

% \AfterEndDocument{\label{LastPage}}%\pageref{LastPage}
\usepackage[page,xspace]{totalcount}
\def\mcShift{\hspace{-6.0pt}} % It's for align non-multicolumn cell .
% \multicolumn{2}{l}{\mcShift 國立暨南國際大學 \collegeZh \deptZh} & 頁數：\pageref{LastPage} \\
\def\abstractHeaderZh{\centering
%     \abstractHeaderStyle\titleZh\par
    \vspace*{1ex}
%     \normalsize
    \footnotesize
    { \renewcommand{\arraystretch}{1}
    \begin{tabularx}{\textwidth}{l@{\hspace*{0.4em}}lXl@{\hspace*{0.4em}}l}
%         \multicolumn{4}{l}{\mcShift \titleZh }
    論文名稱 & \multicolumn{4}{l}{\mcShift ：\titleZh } \\
    校院系   & \multicolumn{3}{l}{\mcShift ：國立暨南國際大學 \collegeZh{} \deptZh} & 頁數：\totalpages \\
    畢業時間 & ：\degreeyearROC / \degreemonth & & 學位別 & ：\deptZh \\
    研究生   & ：\authorZh  &  & 指導教授 & ： \mprofZh \\
    
    \profsTableContentAbsZh
    
    \end{tabularx}\par }
}
\def\abstractHeaderEn{\centering
%     \abstractHeaderStyle\titleEn\par
    \vspace*{1ex}
%     \normalsize
    \footnotesize
    { \renewcommand{\arraystretch}{1}
    \begin{tabularx}{\textwidth}{l@{\hspace*{0.4em}}XXl@{\hspace*{0.4em}}l}
        
    Title of Thesis & \multicolumn{4}{l}{\mcShift : \titleEn } \\
    Name of Institute & \multicolumn{3}{l}{\mcShift : 
        \begin{tabular}[t]{l}
        National Chi Nan University \\
        \collegeEn \\
        \deptEn \\
        \end{tabular}
    } & Pages: \totalpages \\
%     Name of Institute & National Chi Nan University \collegeEn{} \deptEn & & & Pages: \pageref{LastPage} \\
    Graduation Time & : \degreemonth / \degreeyearEn & & Degree Conferred & : \deptEn \\
    
    Student Name & : \authorEn  &  & Advisor Name: & \mprofEn \\
    
    \profsTableContentAbsEn
    
    \end{tabularx}\par }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Redefine other configure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\geometry{includefoot, top=2.3cm, bottom=3.5cm, inner=3cm, outer=2.5cm}

\endinput % this must be the last command.