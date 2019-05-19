\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chapter}[2019/05/19 v0.1 the Future Family]

\def\chapter@baseclass{manuscript}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\chapter@baseclass}}
\ProcessOptions\relax

\LoadClass{\chapter@baseclass}

\newcommand{\page}[1]{\reversemarginpar\marginnote{\color{gray}\scriptsize$\mathrm{pp.~#1}$}\normalmarginpar}
\newenvironment{summary}{\maketitle\begin{abstract}}{\end{abstract}}
\newcommand{\chapter}[1]{\title[#1]{\Large #1\\[5pt]\small \normalfont \textsc{Book Notes}}}
\AtEndEnvironment{document}{\colorem{black}\bigskip\bibliography{../bibliography.bib}}
