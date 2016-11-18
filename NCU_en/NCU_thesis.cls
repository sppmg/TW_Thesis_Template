% This class is a link to real class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NCU_thesis}[2016/11/18 by sppmg]
% pass no defined option to book class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{NCU_thesis_extbook}}
% terminates the option processing.
\ProcessOptions\relax
% Load base class
\LoadClass{NCU_thesis_extbook}
%%%%% Load additional packages and commands.

\endinput % this must be the last command.