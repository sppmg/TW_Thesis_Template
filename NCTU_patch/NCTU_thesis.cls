% This class is a link to real class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NCTU_thesis}[2018/01/18 by sppmg]
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


\def\abstractHeaderZh{\centering
    \abstractHeaderStyle\titleZh\par
    \vspace*{1ex}
    \normalsize
    { \renewcommand{\arraystretch}{1}
    \begin{tabularx}{\textwidth}{r@{\hspace*{0.4em}}lXr@{\hspace*{0.4em}}l}
    學生：   & \authorZh  &  & 指導教授：& \mprofZh \\
    
    \profsTableContentAbsZh
    
    \end{tabularx}\par }
    \vspace*{1em}
    國立交通大學\; \deptZh  \degreeZh 班 \par
}
\def\abstractHeaderEn{\centering
    \abstractHeaderStyle\titleEn\par
    \vspace*{1ex}
    \normalsize
    { \renewcommand{\arraystretch}{1}
    \begin{tabularx}{\textwidth}{r@{\hspace*{0.4em}}lXr@{\hspace*{0.4em}}l}
    Student: & \authorEn  &  & Advisor: & \mprofEn \\
    
    \profsTableContentAbsEn
    
    \end{tabularx}\par }
    \vspace*{1.5em}
    
    \deptEn \par
    National Chiao Tung University \par
}

\endinput % this must be the last command.