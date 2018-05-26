% This class is a patch to base class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{YM_thesis}[2018/05/27 by sppmg]
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
%        Presetting for NTU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifzh{ % TOC 章級標號形式設定
    \gdef\thecontentslabel@chapter{第\zhnumber{\thecontentslabel}章}
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

\endinput % this must be the last command.