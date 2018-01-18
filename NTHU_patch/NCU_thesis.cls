% This class is a link to real class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NCU_thesis}[2018/01/18 by sppmg]
% pass no defined option to book class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{NTHU_thesis}}
% terminates the option processing.
\ProcessOptions\relax
% Load base class
\LoadClass{NTHU_thesis}
%%%%% Load additional packages and commands.

\endinput % this must be the last command.