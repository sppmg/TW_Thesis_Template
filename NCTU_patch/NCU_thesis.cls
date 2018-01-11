% This class is a link to real class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NCTU_thesis}[2018/01/11 by sppmg]
% pass no defined option to book class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{NCTU_thesis}}
% terminates the option processing.
\ProcessOptions\relax
% Load base class
\LoadClass{NCTU_thesis}
%%%%% Load additional packages and commands.

\endinput % this must be the last command.