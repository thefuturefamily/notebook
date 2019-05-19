\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notebook}

\def\notebook@baseclass{extbook}

\newif\if@usempar\@usemparfalse
\DeclareOption{mpar}{\@usempartrue}

\newif\ifclassical\classicalfalse
\DeclareOption{classical}{\classicaltrue}

\newif\ifcn\cnfalse
\DeclareOption{cn}{\cntrue}

\newif\ifcentertitle\centertitlefalse
\newcommand\CenteringTheTitle{\centertitletrue}
\DeclareOption{centertitle}{\centertitletrue}

\newif\ifpublish\publishfalse
\DeclareOption{publish}{\publishtrue}

\newif\ifonlyformal\onlyformalfalse
\DeclareOption{formal}{\onlyformaltrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\notebook@baseclass}}
\ProcessOptions\relax

\LoadClass{\notebook@baseclass}

%% Geometry
%--------------------------------------------------------------------------
\RequirePackage{geometry}
\if@usempar
  \geometry{top=1in,bottom=1in,outer=2in,inner=1in,marginparwidth=1.5in,marginparsep=0.2in}
\else
  \geometry{top=1in,bottom=1in,outer=1in,inner=1in,marginparwidth=0.7in,marginparsep=0.2in}
\fi

% Fonts
%--------------------------------------------------------------------------
\RequirePackage{kpfonts}

%% Colors
%--------------------------------------------------------------------------
\RequirePackage{xcolor,colortbl}

\definecolor{hand}{RGB}{160,32,240}
\definecolor{handformal}{RGB}{243,102,25}
\definecolor{module}{RGB}{137,207,240}
\definecolor{submodule}{RGB}{251,255,242}
\definecolor{lstbackground}{RGB}{255,255,255}

\definecolor{skyblue}{RGB}{60,120,234}
\definecolor{steelblue}{RGB}{70,130,180}
\definecolor{forestgreen}{RGB}{21,122,81}
\definecolor{lightorange}{RGB}{255,185,88}

%% Lengths
%--------------------------------------------------------------------------
\RequirePackage{calc}
\RequirePackage[nomessages]{fp}

\newlength{\fsizept}
\setlength{\fsizept}{\f@size pt}

\newlength{\fsizeline}
\setlength{\fsizeline}{\f@size\baselineskip}

\newlength{\titleruleheight}
\setlength{\titleruleheight}{0.075\fsizept}

\newlength{\charskip}
\setlength{\charskip}{\widthof{i}}

\FPeval{\mparfigsize}{0.033*\f@size+0.03}

%% Useful packages
%--------------------------------------------------------------------------
\RequirePackage{ifthen}

\RequirePackage{fancyhdr}
\RequirePackage{titling}
\RequirePackage{titlesec}
\RequirePackage{titletoc}

\RequirePackage{mdwlist}
\RequirePackage{enumitem}

\RequirePackage{listings}
\lstset
{
  numbers=left,
  numberstyle=\scriptsize\color{gray},
  backgroundcolor=\color{lstbackground},
  breaklines=true,
  frame=L,
  basicstyle=\small\ttfamily,
  %escapeinside={\#}{\#}
}

\RequirePackage[normalem]{ulem}
\RequirePackage[many]{tcolorbox}
\RequirePackage{graphicx}
\graphicspath{{images/}}
\RequirePackage{float}
\RequirePackage{tikz}

\RequirePackage{booktabs}
\RequirePackage{multirow}

\RequirePackage{changepage}
\RequirePackage{perpage}
\strictpagecheck

\RequirePackage{bxtexlogo}
\RequirePackage{blindtext}

\RequirePackage{silence}

%% Maths
%--------------------------------------------------------------------------
\RequirePackage{mathtools}
\allowdisplaybreaks[1] % 0~4
\RequirePackage{amsfonts,amsthm,amssymb,bm}
\RequirePackage{savesym}
\savesymbol{iint}
\savesymbol{iiint}
\savesymbol{iiiint}
\RequirePackage{esint}
\restoresymbol{ES}{iint}
\restoresymbol{ES}{iiint}
\restoresymbol{ES}{iiiint}
\RequirePackage{mathrsfs}

\newcommand*{\dif}{\mathop{}\!\mathrm{d}}

% Graphics
%--------------------------------------------------------------------------
\RequirePackage{graphicx}
\graphicspath{{images/}}
\RequirePackage{tikz}

\newcommand{\thecoverimage}{cover}%
\newcommand{\coverimage}[1]{\renewcommand{\thecoverimage}{#1}}%

\RequirePackage[pages=some]{background}
\backgroundsetup{scale=1,color=black,opacity=1.0,angle=0,
contents={\includegraphics[width=\paperwidth,height=\paperheight]{\thecoverimage}}}

% Header and footer styling
%--------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\RequirePackage{emptypage}
\setlength{\headheight}{15.0pt}
\fancyhf{}
\fancyhead[LE,RO]{\bfseries\thepage}
\fancyhead[RE]{\itshape\sf\nouppercase{\rightmark}}
\fancyhead[LO]{\itshape\sf\nouppercase{\leftmark}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}
{
  \cfoot{\textbf{\thepage}}
}

% Section styling
%--------------------------------------------------------------------------
\titleformat{\section}{\ifcentertitle\center\fi\ifcn\large\bfseries\else\Large\sffamily\fi\color{steelblue}}{\thesection}{1em}{}[{\titlerule[\titleruleheight]}]

% Chapter styling
%--------------------------------------------------------------------------
\makeatletter

\newcommand{\thechapterimage}{background}%
\newcommand{\chapterimage}[1]{\renewcommand{\thechapterimage}{#1}}%

% Numbered chapters (with minitoc)
\renewcommand{\@makechapterhead}[1]{
  \begin{tikzpicture}[remember picture,overlay]
    \node at (current page.north west)
  {
    \begin{tikzpicture}[remember picture,overlay]
      % Background image
      \node[anchor=north west,inner sep=0pt] at (0,0)
           {\includegraphics[width=\paperwidth]{\thechapterimage}};
      % Chapter heading
      \draw[anchor=west, inner sep=0pt] (-0.1cm,-1.5cm) node
           [black,
            ultra thick,
            fill=orange!10,
            fill opacity=.6,
            inner sep=10pt]
           (0,0)
           {\parbox[t][1.3cm][t]{\paperwidth}
           {\huge\bfseries\sffamily\flushleft\hspace{0.9cm}\thechapter. #1}};
      % Chapter contents
      \draw[anchor=west,inner sep=0pt] (8.8cm,-6.5cm) node
           [steelblue,
            ultra thick,
            fill=white,
            fill opacity=.8,
            draw=steelblue,
            draw opacity=1,
            line width=1.5pt,
            rounded corners,
            inner sep=0pt]
           (0,0)
           {\hspace{1cm}\parbox[t][7cm][t]{11cm}
           {\vspace{-1cm}\huge\bfseries\sffamily\flushleft
            \textcolor{black}{\sffamily\minitoc}}};
    \end{tikzpicture}
  };
\end{tikzpicture}
\vspace{7.5cm}
}

% Unnumbered chapters (without minitoc)
\renewcommand{\@makeschapterhead}[1]{
  \begin{tikzpicture}[remember picture,overlay]
    \node at (current page.north west)
  {
    \begin{tikzpicture}[remember picture,overlay]
      % Background image
      \node[anchor=north west,inner sep=0pt] at (0,0)
           {\includegraphics[width=\paperwidth]{\thechapterimage}};
      % Chapter heading
      \draw[anchor=west,inner sep=0pt] (-0.1cm,-1.5cm) node
           [black,
            ultra thick,
            fill=orange!10,
            fill opacity=.6,
            inner sep=10pt]
           (0,0)
           {\parbox[t][1.3cm][t]{\paperwidth}
           {\huge\bfseries\sffamily\flushleft\hspace{0.9cm} #1}};
    \end{tikzpicture}
  };
\end{tikzpicture}
\vspace{8cm}
}

% Minitoc styling
%--------------------------------------------------------------------------
\RequirePackage{minitoc}
\setcounter{minitocdepth}{1}
\dominitoc[n]
\nomtcrule
\nomtcpagenumbers
\renewcommand{\mtifont}{\large\sffamily}
\renewcommand{\mtcfont}{\small\sffamily}
\renewcommand{\mtcSfont}{\small\sffamily}
\renewcommand{\mtcSSfont}{\small\sffamily}
\renewcommand{\mtcSSSfont}{\small\sffamily}

% Table of contents styling
%--------------------------------------------------------------------------
\RequirePackage{titletoc}
\setcounter{tocdepth}{1}

\titlecontents{part}[-1.25cm] % Left indentation
  {\addvspace{20pt}\large\sffamily\bfseries} % Spacing and font options for parts
  {}
  {}
  {}

\titlecontents{chapter}[0cm]
  {\addvspace{12pt}\large\sffamily\bfseries}
  {\color{steelblue}\contentslabel[\Large\thecontentslabel]{1.25cm}}{}
  {\color{steelblue}\normalsize\sffamily\bfseries
  \;\titlerule*[.5pc]{.}\;\thecontentspage}

\titlecontents{section}[0cm]
  {\addvspace{4pt}\sffamily\bfseries}
  {\contentslabel[\thecontentslabel]{1.25cm}}{}
  {\sffamily\hfill\color{black}\thecontentspage}[]

\titlecontents{subsection}[0.5cm]
  {\addvspace{0pt}\small\sffamily}
  {\contentslabel[\thecontentslabel]{1.25cm}}{}
  {\sffamily\hfill\color{black}\thecontentspage}[]

\newcommand{\addchapter}[1]{\phantomsection\addcontentsline{toc}{chapter}{\textcolor{steelblue}{#1}}\mtcaddchapter}
\newcommand{\addsection}[1]{\phantomsection\addcontentsline{toc}{section}{#1}}
\newcommand{\addsubsection}[1]{\phantomsection\addcontentsline{toc}{subsection}{#1}}

%	Mini table of contents in part heads
%--------------------------------------------------------------------------
\titlecontents{lchapter}[0em] % Left indentation
  {\addvspace{15pt}\large\sffamily\bfseries} % Spacing and font options for chapters
  {\color{skyblue}\contentslabel[\Large\thecontentslabel]{1.25cm}\color{skyblue}} % Chapter number
  {}  
  {\color{skyblue}\normalsize\sffamily\bfseries\;\titlerule*[.5pc]{.}\;\thecontentspage} % Page number

\titlecontents{lsection}[0em] % Left indentation
  {\sffamily\small} % Spacing and font options for sections
  {\contentslabel[\thecontentslabel]{1.25cm}} % Section number
  {}
  {}

\titlecontents{lsubsection}[.5em] % Left indentation
  {\sffamily\footnotesize} % Spacing and font options for subsections
  {\contentslabel[\thecontentslabel]{1.25cm}}
  {}
  {}

%	Part headings
%--------------------------------------------------------------------------
% Numbered part in the table of contents
\newcommand{\@partnumtocformat}[2]{%
	\setlength\fboxsep{0pt}%
	\noindent\colorbox{skyblue!20}{\strut\parbox[c][.7cm]{\ecart}{\color{skyblue!70}\Large\sffamily\bfseries\centering#1}}\hskip\esp\colorbox{skyblue!40}{\strut\parbox[c][.7cm]{0.65cm+\linewidth-\ecart-\esp}{\Large\sffamily\centering#2}}%
}

% Unnumbered part in the table of contents
\newcommand{\@parttocformat}[1]{%
	\setlength\fboxsep{0pt}%
	\noindent\colorbox{skyblue!40}{\strut\parbox[c][.7cm]{0.65cm+\linewidth}{\Large\sffamily\centering#1}}%
}

\newlength\esp
\setlength\esp{4pt}
\newlength\ecart
\setlength\ecart{1.2cm-\esp}

\newcommand{\thepartimage}{}%
\newcommand{\partimage}[1]{\renewcommand{\thepartimage}{#1}}%

\def\@part[#1]#2{%
  \startcontents%
  \markboth{}{}%
  {\thispagestyle{empty}%
  \refstepcounter{part}%
  \addcontentsline{toc}{part}{\texorpdfstring{\protect\@partnumtocformat{\thepart}{#1}}{\partname~\thepart\ ---\ #1}} %Numbered part
  \begin{tikzpicture}[remember picture,overlay]%
  \node at (current page.north west){\begin{tikzpicture}[remember picture,overlay]%	
  \fill[skyblue!20](0cm,0cm) rectangle (\paperwidth,-\paperheight);
  \node[anchor=north] at (4cm,-3.25cm){\color{skyblue!40}\fontsize{220}{100}\sffamily\bfseries\thepart}; 
  \node[anchor=south east] at (\paperwidth-1cm,-\paperheight+1cm){\parbox[t][][t]{8.5cm}{
  \printcontents{l}{0}{\setcounter{tocdepth}{1}}% The depth to which the Part mini table of contents displays headings; 0 for chapters only, 1 for chapters and sections and 2 for chapters, sections and subsections
  }};
  \node[anchor=north east] at (\paperwidth-1.5cm,-3.25cm){\parbox[t][][t]{15cm}{\strut\raggedleft\color{white}\fontsize{30}{30}\sffamily\bfseries#2}};
  \end{tikzpicture}};
  \end{tikzpicture}}%
  \@endpart}

\def\@spart#1{%
  \startcontents%
  \phantomsection
  {\thispagestyle{empty}%
  \addcontentsline{toc}{part}{\texorpdfstring{\protect\@parttocformat{#1}}{#1}}%Unumbered part
  \begin{tikzpicture}[remember picture,overlay]%
  \node at (current page.north west){\begin{tikzpicture}[remember picture,overlay]%	
  \fill[skyblue!20](0cm,0cm) rectangle (\paperwidth,-\paperheight);
  \node[anchor=north east] at (\paperwidth-1.5cm,-3.25cm){\parbox[t][][t]{15cm}{\strut\raggedleft\color{white}\fontsize{30}{30}\sffamily\bfseries#1}};
  \end{tikzpicture}};
  \end{tikzpicture}}
  \@endpart}

\def\@endpart{\vfil\newpage
  \if@twoside
  \if@openright
  \null
  \thispagestyle{empty}%
  \newpage
  \fi
  \fi
  \if@tempswa
  \twocolumn
  \fi}

% Front matter
%--------------------------------------------------------------------------
\newcommand{\notebook}[5]{

\pagestyle{empty}

\def\@title{#1}
\def\@author{#2}
\def\@year{#3}
\def\@published{#4}
\def\@printed{#5}

% Cover
\BgThispage
\pagenumbering{Roman}
\begin{center}
  \null
  \bigskip

  \color{white}
  \sffamily

  \fontsize{30pt}{50pt}
  \textsc{\@title}

  \bigskip
  \smallskip

  \LARGE
  \textsc{\@author} \\[1em]
  \Large
  \textsc{\@published}
\end{center}

\pagebreak

% Title page
\colorbox{gray}{
  \parbox[t]{0.93\textwidth}{ % Outer full width box
    \parbox[t]{0.91\textwidth}{ % Inner box for inner right text margin
      \raggedleft % Right align the text
      \fontsize{50pt}{80pt}\selectfont % Title font size, the first argument is the font size and the second is the line spacing, adjust depending on title length
      \vspace{0.7cm} % Space between the start of the title and the top of the gray box
      \@title
      \vspace{0.7cm} % Space between the end of the title and the bottom of the gray box
    }
  }
}
\vfill % Space between the title box and author information
\parbox[t]{0.93\textwidth}{
  \raggedleft
  \large
  {\Large \@author}\\[4pt]
  \hfill\rule{0.2\linewidth}{1pt}\\[2pt]
  \@published\\
}
\pagebreak

% Copyright page
\null
\vfill
\begin{flushleft}
  Copyright \copyright \ \@year \ \@author \\
  \vspace{5mm}
  \textbf{Copying prohibited} \\
  \vspace{5mm}
  All rights reserved. No part of this publication may be reproduced
  or transmitted in any form or by any means, electronic or
  mechanical, including photocopying and recording, or by any
  information storage or retrieval system, without the prior written
  permission of the publisher. \\
  \vspace{5mm}
  Published by \@published \\
  Printed in \@printed
\end{flushleft}

\clearpage
\setcounter{page}{0}
\pagenumbering{roman}

\pagestyle{fancy}

% Table of contents
\tableofcontents

\cleardoublepage
}

%% Bibliography
%--------------------------------------------------------------------------
\usepackage[nil]{babel}
\RequirePackage[square,comma,sort&compress,numbers]{natbib}
\bibliographystyle{abbrvnat}

% Index
%--------------------------------------------------------------------------
\RequirePackage{makeidx}
\makeindex

%% URL wrap
%--------------------------------------------------------------------------
\RequirePackage{url}
\def\UrlBreaks{\do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J
\do\K\do\L\do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V
\do\W\do\X\do\Y\do\Z\do\[\do\\\do\]\do\^\do\_\do\`\do\a\do\b
\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l\do\m\do\n
\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z
\do\.\do\@\do\\\do\/\do\!\do\_\do\|\do\;\do\>\do\]\do\)\do\,
\do\?\do\'\do+\do\=\do\#}

%% Pictures
%--------------------------------------------------------------------------
\newcommand{\ideabulb}[2][0.15]{
  \scalebox{#1}{
  \begin{tikzpicture}
    \filldraw[draw=#2,fill=#2] (0,0) circle [radius=1cm];
    \filldraw[draw=white,fill=white,rounded corners=0.8pt]
        [rotate=20] (-0.26,-0.66) rectangle (-0.06,-0.6)
        [xshift=-0.4mm,yshift=1mm] (-0.26,-0.66) rectangle (0.02,-0.6)
        [xshift=0.4mm,yshift=1mm] (-0.26,-0.66) rectangle (-0.06,-0.6);
    \draw[draw=white,line width=0.7mm] (-0.18,-0.46) 
        .. controls (-0.18,-0.28) and (-0.28,-0.12) ..(-0.4,0.1)
        .. controls (-0.55,0.4) and (-0.3,0.64) ..(0,0.64)
        .. controls (0.3,0.64) and (0.55,0.4) ..(0.4,0.1)
        .. controls (0.28,-0.12) and (0.18,-0.28) ..(0.18,-0.46);
  \end{tikzpicture}}}

\newcommand{\questionmark}[2][0.15]{
  \scalebox{#1}{
  \begin{tikzpicture}
    \filldraw[draw=#2,fill=#2] (0,0) circle [radius=1cm];
      [xshift=0.4mm,yshift=1mm] (-0.26,-0.66) rectangle (-0.06,-0.6);
    \draw[draw=white,line width=1.5mm,yshift=0.5mm,scale=0.8] (-0.4,0.1)
        .. controls (-0.55,0.4) and (-0.3,0.64) ..(0,0.64)
        .. controls (0.3,0.64) and (0.55,0.4) ..(0.4,0.1)
        .. controls (0.28,-0.12) and (0.05,-0.28) ..(0.05,-0.3)
        .. controls (0,-0.36) and (0.0,-0.45) ..(0.0,-0.5);
        \filldraw[draw=white,fill=white,rounded corners=0.4mm] (-0.1,-0.7) rectangle (0.1,-0.5);
  \end{tikzpicture}}}

%% Marginnotes setting
%--------------------------------------------------------------------------
\RequirePackage{marginnote}
\newcommand{\mparadjust}[1]{\renewcommand*{\marginnotevadjust}{#1}}

\makeatletter
\if@twoside
  \tcbset{marginnotestyle/.style={% 
    skin=enhancedmiddle jigsaw,breakable,
    boxrule=0mm,if odd page={leftrule=1mm,rightrule=-0.01mm,left=1mm,right=1mm}{leftrule=0.01mm,rightrule=1mm,left=0mm,right=1mm},boxsep=0mm,top=1mm,bottom=1mm}}
\else
  \tcbset{marginnotestyle/.style={% 
    skin=enhancedmiddle jigsaw,breakable,
    boxrule=0mm,leftrule=1mm,rightrule=-0.01mm,left=1mm,right=1mm,boxsep=0mm,top=1mm,bottom=1mm}}
\fi
\makeatother

% mpar
\newcounter{mparcnt}
\renewcommand\themparcnt{\small{$^{\color{skyblue}{\mathbf{\arabic{mparcnt}}}}$}}
\newcommand\mpar[2][0]{\mbox{
  \refstepcounter{mparcnt}{\hspace{-0.8\charskip}$^{\color{skyblue}{\mathbf{\arabic{mparcnt}}}}$}% 
  \mparadjust{#1\baselineskip}%
  \marginnote{\vskip-\mparliftupfactor\baselineskip%
  \begin{tcolorbox}% 
    [marginnotestyle,colback=skyblue!5!white,colframe=skyblue!80]%
    \linespread{0.0}\themparcnt
    \scriptsize\color{skyblue!70!black}\normalfont #2%
  \end{tcolorbox}}}}

% mparhand
\newcommand\mparhand[2][0]{% 
  {\mparadjust{#1\baselineskip}% 
  \marginnote{\vskip-\mparliftupfactor\baselineskip%
  \begin{tcolorbox}
    [marginnotestyle,colback=hand!3!white,colframe=hand!80]% 
    \linespread{0.0}% 
    \handwriting\scriptsize\color{hand!70!black} #2% 
  \end{tcolorbox}}}}

% mparhandnum
\newcounter{mparhandformal}
\renewcommand\themparhandformal{\small{$^{\color{handformal}\mathbf{\roman{mparhandformal}}}$}}
\newcommand\mparhandnum[2][0]{\mbox{%
  \refstepcounter{mparhandformal}{\hspace{0.4\charskip}$^{\color{handformal}{\mathbf{\roman{mparhandformal}}}}$}%
  \mparadjust{#1\baselineskip}%
  \marginnote{\vskip-\mparliftupfactor\baselineskip%
  \begin{tcolorbox}%
    [marginnotestyle,colback=handformal!3!white,colframe=handformal!75!yellow]% 
    \linespread{0.0}\themparhandformal
    \handwriting\scriptsize\color{handformal!70!black} #2%
  \end{tcolorbox}}}}

% marginal figure
\newlength{\fixfactor}
\newlength{\tmp}
\makeatletter
  \setlength{\fixfactor}{0.1\fsizeline-1.2\baselineskip}

\newcommand\mparfig[2][0]{\par
  \if@twoside\else\reversemarginpar\fi
  \setlength{\tmp}{#1\baselineskip+\fixfactor}\mparadjust{\tmp}
  \marginnote{\!\!\!\!\!\!#2\!\!\!\!}\vspace{0pt} %This should be linked with font size.
  \if@twoside\else\normalmarginpar\fi
  }
\makeatother

\ifxetex % fix marginnote position
  \makeatletter
    \def\pgfsys@hboxsynced#1{%
    {%
      \pgfsys@beginscope%
      \setbox\pgf@hbox=\hbox{%
        \hskip\pgf@pt@x%
        \raise\pgf@pt@y\hbox{%
          \pgf@pt@x=0pt%
          \pgf@pt@y=0pt%
          \special{pdf: content q}%
          \pgflowlevelsynccm% 
          \pgfsys@invoke{q -1 0 0 -1 0 0 cm}%
          \special{pdf: content -1 0 0 -1 0 0 cm q}% translate to original coordinate system
          \pgfsys@invoke{0 J [] 0 d}% reset line cap and dash
          \wd#1=0pt%
          \ht#1=0pt%
          \dp#1=0pt%
          \box#1%
          \pgfsys@invoke{n Q Q Q}%
        }%
        \hss%
      }%
      \wd\pgf@hbox=0pt%
      \ht\pgf@hbox=0pt%
      \dp\pgf@hbox=0pt%
      \pgfsys@hbox\pgf@hbox%
      \pgfsys@endscope%
    }}
  \makeatother
\else\fi

%% Module, Separation line
%--------------------------------------------------------------------------
\newcounter{module}[subsection]
\tcbset{sepline/.style={% 
  sharp corners,rounded corners=all,oversize,
  boxrule=0mm,leftrule=1mm,rightrule=1mm,left=1mm,right=1mm,boxsep=0mm,top=-0.5mm,bottom=2.5mm,borderline={1.6pt}{0pt}{module!30}}}
\newtcolorbox{sltop}{sepline,skin=emptyfirst,toprule=0.6mm,bottomrule=0mm}
\newtcolorbox{slbottom}{sepline,skin=emptylast,toprule=0mm,bottomrule=0.6mm}

\makeatletter
\if@twoside
  \def\seplinetop{\vspace{-\seplineshrink\baselineskip}\begin{sltop}\stepcounter{module}\scriptsize\color{module!90!black!80} \checkoddpage
  \ifoddpage
    \raggedright\hspace{-10ex}\arabic{section}.\ifthenelse{\equal{\arabic{subsection}}{0}}{}{\arabic{subsection}.}\alph{module} %This should be linked with font size.
  \else
    \raggedleft\arabic{section}.\ifthenelse{\equal{\arabic{subsection}}{0}}{}{\arabic{subsection}.}\alph{module}\hspace{-11ex} %This should be linked with font size.
  \fi \vspace{-1ex}\end{sltop}\vspace{-1\baselineskip}}
\else
  \def\seplinetop{\vspace{-\seplineshrink\baselineskip}\begin{sltop}\stepcounter{module}\scriptsize\color{module!90!black!80} \raggedright\hspace{-10ex}\arabic{section}.\ifthenelse{\equal{\arabic{subsection}}{0}}{}{\arabic{subsection}.}\alph{module}\vspace{-1ex}\end{sltop}\vspace{-0.5\baselineskip}} %This should be linked with font size.
\fi
\makeatother
\def\seplinebottom{\vspace{-0.8\baselineskip}\begin{slbottom}\end{slbottom}\vspace{-\seplineshrink\baselineskip}} %This should be linked with font size.

\newenvironment{module}{\seplinetop}{\seplinebottom}

% submodule
\tcbset{subsepline/.style={% 
  sharp corners,rounded corners=all,oversize,
  boxrule=0mm,leftrule=0.4mm,rightrule=0.4mm,left=0.5mm,right=0.5mm,boxsep=0mm,top=0.5mm,bottom=1mm,borderline={1.5pt}{0pt}{submodule!90!black!45}}}
\newtcolorbox{subsltop}{subsepline,skin=emptyfirst,toprule=0.2mm,bottomrule=0mm}
\newtcolorbox{subslbottom}{subsepline,skin=emptylast,toprule=0mm,bottomrule=0.2mm}

\def\subseplinetop{\vspace{-0.4\baselineskip}\vspace{-\seplineshrink\baselineskip}\begin{subsltop}\end{subsltop}\vspace{-0.75\baselineskip}} %This should be linked with font size.
\def\subseplinebottom{\vspace{-1\baselineskip}\begin{subslbottom}\end{subslbottom}\vspace{-\seplineshrink\baselineskip}} %This should be linked with font size.

\newenvironment{submodule}{\subseplinetop}{\subseplinebottom}

%% Boxes for theorems
%--------------------------------------------------------------------------
\newenvironment{boxtheorem}
  {\begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=black!3,colframe=orange]}
  {\end{tcolorbox}}

\newenvironment{boxcorollary}
  {\begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=black!3,colframe=orange]}
  {\end{tcolorbox}}

\newenvironment{boxlemma}
  {\begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=black!3,colframe=orange]}
  {\end{tcolorbox}}

\newenvironment{boxproposition}
  {\begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=black!3,colframe=orange]}
  {\end{tcolorbox}}

\newenvironment{boxconjecture}
  {\begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=purple!5,colframe=purple]}
  {\end{tcolorbox}}

\newenvironment{boxfact}
  {\begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=black!3,colframe=orange]}
  {\end{tcolorbox}}

\ifdefined\pdfsavepos
  \RequirePackage{zref-savepos}

  \newlength{\deftop}
  \newlength{\defbot}
  \newlength{\defsep}
  \newlength{\defpage}
  \newlength{\currentpage}
  \newcounter{def}

  \newenvironment{boxdefinition}
    {\stepcounter{def}
    \zsavepos{def\arabic{def}1}
    \setlength{\global\deftop}{\dimexpr\paperheight - \zposy{def\arabic{def}1} sp}
    \setlength{\global\defsep}{\deftop-\defbot}
    \setlength{\global\currentpage}{\thepage pt}
    \ifthenelse{\lengthtest{\defpage = \currentpage}}
      {\ifthenelse{\lengthtest{\defsep < 3mm}}{\vspace{-3mm}}{}}{}\par
    \begin{tcolorbox}
    [enhanced jigsaw,pad at break*=1mm,breakable,
    colback=lightorange!10!white,boxrule=0pt,frame hidden,
    borderline west={1.5mm}{-1mm}{forestgreen}]}
    {\end{tcolorbox}
    \zsavepos{def\arabic{def}2}
    \setlength{\global\defbot}{\dimexpr\paperheight - \zposy{def\arabic{def}2} sp}
    \setlength{\global\defpage}{\thepage pt}}
\else
  \newenvironment{boxdefinition}
  {\vspace{-1mm}
  \begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=lightorange!10!white,boxrule=0pt,frame hidden,
  borderline west={1.5mm}{-1mm}{forestgreen}]}
  {\end{tcolorbox}
  \vspace{-2mm}}
\fi

\newenvironment{boxexercise}
  {\begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=lightorange!20,boxrule=0pt,frame hidden]}
  {\end{tcolorbox}}

\newenvironment{boxproblem}
  {\begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=yellow!25,boxrule=0pt,frame hidden]}
  {\end{tcolorbox}}

\newenvironment{boxexample}
  {\begin{tcolorbox}
  [enhanced jigsaw,pad at break*=1mm,breakable,
  colback=gray!10,boxrule=0pt,frame hidden]}
  {\end{tcolorbox}}

%% Styling of theorems
%--------------------------------------------------------------------------
\RequirePackage{amsthm}
\newtheoremstyle{styletheorem}
  {0pt}{0pt}{\theoremfont}{0pt}{\small\bfseries\sffamily\color{orange}}{\;}{0.25em}
  {\small\sffamily\color{orange}\thmname{#1}\!\!
  \nobreakspace\thmnumber{\textup{#2}}
  \thmnote{\sffamily\bfseries\color{black} (#3)}}

\newtheoremstyle{styleconjecture}
  {0pt}{0pt}{\theoremfont}{0pt}{\small\bfseries\sffamily\color{purple}}{\;}{0.25em}
  {\small\sffamily\color{purple}\thmname{#1}\!\!
  \nobreakspace\thmnumber{\textup{#2}}
  \thmnote{\sffamily\bfseries\color{purple} (#3)}}

\newtheoremstyle{styledefinition}
  {0pt}{0pt}{\theoremfont}{0pt}{\small\bfseries\sffamily\color{black}}{\;}{0.25em}
  {\small\sffamily\color{forestgreen}\thmname{#1}\!\!
  \nobreakspace\thmnumber{\textup{#2}}
  \thmnote{\sffamily\bfseries\color{black} (#3)}}

\newtheoremstyle{styleexercise}
  {0pt}{0pt}{\theoremfont}{0pt}{\small\bfseries\sffamily\color{black}}{\;}{0.25em}
  {\small\sffamily\color{black}\thmname{#1}\!\!
  \nobreakspace\thmnumber{\textup{#2}}
  \thmnote{\sffamily\bfseries\color{black} (#3)}}

\newtheoremstyle{styleremark}
  {0pt}{0pt}{\itshape}{0pt}{}{}{0pt}
  {\thmnote{\sffamily\bfseries\color{black} (#3)}}

\theoremstyle{styledefinition}
\newtheorem{envdefinition}{\definitiontitle}[section]
\newtheorem*{envdefinition*}{\definitiontitle}

\theoremstyle{styletheorem}
\newtheorem{envtheorem}{\theoremtitle}[section]
\newtheorem*{envtheorem*}{\theoremtitle}
\newtheorem{envcorollary}[envtheorem]{\corollarytitle}
\newtheorem*{envcorollary*}{\corollarytitle}
\newtheorem{envlemma}[envtheorem]{\lemmatitle}
\newtheorem*{envlemma*}{\lemmatitle}
\newtheorem{envproposition}[envtheorem]{\propositiontitle}
\newtheorem*{envproposition*}{\propositiontitle}
\newtheorem{envfact}[envtheorem]{\facttitle}
\newtheorem*{envfact*}{\facttitle}

\theoremstyle{styleconjecture}
\newtheorem{envconjecture}{\conjecturetitle}[section]
\newtheorem*{envconjecture*}{\conjecturetitle}

\theoremstyle{styleexercise}
\newtheorem{envexercise}{\exercisetitle}[section]
\newtheorem*{envexercise*}{\exercisetitle}
\newtheorem{envproblem}{\problemtitle}[section]
\newtheorem*{envproblem*}{\problemtitle}
\newtheorem{envquestion}[envproblem]{\questiontitle}
\newtheorem*{envquestion*}{\questiontitle}
\newtheorem{envexample}{\exampletitle}[section]
\newtheorem*{envexample*}{\exampletitle}

\theoremstyle{styleremark}
\newtheorem*{envremark}{}

%% Environments for theorems
%--------------------------------------------------------------------------
\ifclassical
  \theoremstyle{plain}
  \newtheorem{theorem}{\theoremtitle}[section]
  \newtheorem*{theorem*}{\theoremtitle}
  \newtheorem{definition}[theorem]{\definitiontitle}
  \newtheorem*{definition*}{\definitiontitle}
  \newtheorem{corollary}[theorem]{\corollarytitle}
  \newtheorem*{corollary*}{\corollarytitle}
  \newtheorem{lemma}[theorem]{\lemmatitle}
  \newtheorem*{lemma*}{\lemmatitle}
  \newtheorem{proposition}[theorem]{\propositiontitle}
  \newtheorem*{proposition*}{\propositiontitle}
  \newtheorem{fact}[theorem]{\facttitle}
  \newtheorem*{fact*}{\facttitle}
  \newtheorem{conjecture}{\conjecturetitle}
  \newtheorem*{conjecture*}{\conjecturetitle}
  \newtheorem{exercise}{\exercisetitle}[section]
  \newtheorem*{exercise*}{\exercisetitle}
  \newtheorem{problem}{\problemtitle}
  \newtheorem*{problem*}{\problemtitle}
  \newtheorem{question}[problem]{\questiontitle}
  \newtheorem*{question*}{\questiontitle}
  \newtheorem{example}{\exampletitle}
  \newtheorem*{example*}{\exampletitle}
  \newtheorem{remark}{\remarktitle}
  \newtheorem*{remark*}{\remarktitle}

\else
  \newenvironment{definition}
                {\begin{boxdefinition}\begin{envdefinition}}
                {\end{envdefinition}\end{boxdefinition}}

  \newenvironment{definition*}
                {\begin{boxdefinition}\begin{envdefinition*}}
                {\end{envdefinition*}\end{boxdefinition}}

  \newenvironment{theorem}
                {\begin{boxtheorem}\begin{envtheorem}}
                {\end{envtheorem}\end{boxtheorem}}

  \newenvironment{theorem*}
                {\begin{boxtheorem}\begin{envtheorem*}}
                {\end{envtheorem*}\end{boxtheorem}}

  \newenvironment{corollary}
                {\begin{boxcorollary}\begin{envcorollary}}
                {\end{envcorollary}\end{boxcorollary}}

  \newenvironment{corollary*}
                {\begin{boxcorollary}\begin{envcorollary*}}
                {\end{envcorollary*}\end{boxcorollary}}

  \newenvironment{lemma}
                {\begin{boxlemma}\begin{envlemma}}
                {\end{envlemma}\end{boxlemma}}

  \newenvironment{lemma*}
                {\begin{boxlemma}\begin{envlemma*}}
                {\end{envlemma*}\end{boxlemma}}

  \newenvironment{proposition}
                {\begin{boxproposition}\begin{envproposition}}
                {\end{envproposition}\end{boxproposition}}

  \newenvironment{proposition*}
                {\begin{boxproposition}\begin{envproposition*}}
                {\end{envproposition*}\end{boxproposition}}

  \newenvironment{conjecture}
                {\begin{boxconjecture}\mparfig[0.1]{\questionmark[\mparfigsize]{purple}} %This should be linked with font size.
                  \begin{envconjecture}}
                {\end{envconjecture}\end{boxconjecture}}

  \newenvironment{conjecture*}
                {\begin{boxconjecture}\begin{envconjecture*}}
                {\end{envconjecture*}\end{boxconjecture}}

  \newenvironment{fact}
                {\begin{boxfact}\begin{envfact}}
                {\end{envfact}\end{boxfact}}

  \newenvironment{fact*}
                {\begin{boxfact}\begin{envfact*}}
                {\end{envfact*}\end{boxfact}}

  \newenvironment{exercise}
                {\begin{boxexercise}\begin{envexercise}}
                {\end{envexercise}\end{boxexercise}}

  \newenvironment{exercise*}
                {\begin{boxexercise}\begin{envexercise*}}
                {\end{envexercise*}\end{boxexercise}}

  \newenvironment{problem}
                {\begin{boxproblem}\begin{envproblem}}
                {\end{envproblem}\end{boxproblem}}

  \newenvironment{problem*}
                {\begin{boxproblem}\begin{envproblem*}}
                {\end{envproblem*}\end{boxproblem}}

  \newenvironment{question}
                {\begin{boxproblem}\begin{envquestion}}
                {\end{envquestion}\end{boxproblem}}

  \newenvironment{question*}
                {\begin{boxproblem}\begin{envquestion*}}
                {\end{envquestion*}\end{boxproblem}}

  \newenvironment{example}
                {\begin{boxexample}\begin{envexample}}
                {\end{envexample}\end{boxexample}}

  \newenvironment{example*}
                {\begin{boxexample}\begin{envexample*}}
                {\end{envexample*}\end{boxexample}}

  \newenvironment{remark}
                {\vspace{0.3\baselineskip}\mparfig{\ideabulb[\mparfigsize]{orange}} %This should be linked with font size.
                  \begin{envremark}}
                {\end{envremark}\vspace{0.5\baselineskip}}

  \newenvironment{remark*}
                {\begin{remark}}
                {\end{remark}}
\fi

% Other environments
%--------------------------------------------------------------------------
\newenvironment{summary}
  {\hspace{10pt}\par\small\itshape
  \begin{list}{}{\leftmargin=35pt\rightmargin=25pt}
  \item\ignorespaces\advance\baselineskip -1pt}
  {\end{list}\vspace{-0.5cm}}


% Links
%--------------------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{hidelinks=true,linktoc=all,backref=true,pagebackref=true,hyperindex=true,colorlinks=false,breaklinks=true,urlcolor=skyblue,bookmarks=true,bookmarksopen=false}
\RequirePackage{bookmark}
\bookmarksetup{
open,
numbered,
addtohook={%
\ifnum\bookmarkget{level}=0 % chapter
\bookmarksetup{bold}%
\fi
\ifnum\bookmarkget{level}=-1 % part
\bookmarksetup{color=skyblue,bold}%
\fi
}
}

% Remove extra page
%--------------------------------------------------------------------------
\AtEndDocument{\newbox\mtbox
\def\shipout{\deadcycles=0\setbox\mtbox=}}

% Other useful packages / Adjust
%--------------------------------------------------------------------------
\RequirePackage{docmute}

\newcommand{\page}[1]{\reversemarginpar\marginnote{\color{gray}\scriptsize$\mathrm{pp.~#1}$}\normalmarginpar}

\renewcommand*{\title}[2][]{}
\renewcommand*{\author}[2][]{}
\renewcommand*{\date}[1]{}
\newcommand{\address}[1]{}
\newcommand{\email}[1]{}

%% Language
%--------------------------------------------------------------------------
\RequirePackage{ifxetex}
\RequirePackage{ifplatform}

\RequirePackage[T1]{fontenc}
\RequirePackage{frcursive}

\newcommand{\emcolor}{}
\newcommand{\colorem}[1]{\renewcommand{\emcolor}{#1}}
\ifclassical\colorem{black}\else\colorem{skyblue}\fi

\newcommand\enhandwriting{\fontfamily{frc}\selectfont \bfseries \tiny}
\newcommand\theoremfont{\normalfont}
\newcommand\settheoremfont[1]{\renewcommand\theoremfont{#1}}

\ifcn
  \RequirePackage{indentfirst}

  \newcommand\mparliftupfactor{1.1}
  \newcommand\seplineshrink{0.3} %This should be linked with font size.

  \ifxetex
    \RequirePackage{ctex}

    \RequirePackage[T1]{fontenc}

    \ifwindows
      \setCJKmainfont[ItalicFont={STKaiti}]{DengXian}
      \newCJKfontfamily\handwriting{FZShuTi}
    \else
      \setCJKmainfont[BoldFont={STHeiti},ItalicFont={STKaiti}]{STXihei}
      \newCJKfontfamily\handwriting{HanziPenSC-W5}
    \fi

    \def\theoremtitle{定理}
    \def\definitiontitle{定义}
    \def\prooftitle{证明}
    \def\lemmatitle{引理}
    \def\corollarytitle{推论}
    \def\propositiontitle{命题}
    \def\conjecturetitle{猜想}
    \def\exampletitle{例}
    \def\facttitle{事实}
    \def\problemtitle{问题}
    \def\questiontitle{小问题}
    \def\exercisetitle{练习}
    \def\remarktitle{备注}
    \renewcommand\refname{参考文献}
    \renewcommand\bibname{参考文献}
    \renewcommand\indexname{索引}
    \renewcommand\abstractname{摘要}
    \renewcommand\contentsname{目录}

    \let\emph\relax
    \DeclareTextFontCommand{\emph}{\color{\emcolor}\em}

    \newcommand{\dnf}{{\color{forestgreen}\fbox{\bfseries 这里的内容尚未完成}}}

  \else
    \RequirePackage{CJKutf8}
    \RequirePackage{mparhack}

    \renewcommand{\baselinestretch}{1.2}%

    \AfterBeginDocument{\begin{CJK*}{UTF8}{gbsn}
      
      \def\theoremtitle{定理}
      \def\definitiontitle{定义}
      \def\prooftitle{\begin{CJK*}{UTF8}{gkai}证明\end{CJK*}}
      \def\lemmatitle{引理}
      \def\corollarytitle{推论}
      \def\propositiontitle{命题}
      \def\conjecturetitle{猜想}
      \def\exampletitle{例}
      \def\facttitle{事实}
      \def\problemtitle{问题}
      \def\questiontitle{小问题}
      \def\exercisetitle{练习}
      \def\remarktitle{备注}
      \renewcommand\proofname{\textit{证明}}
      \renewcommand\refname{参考文献}
      \renewcommand\bibname{参考文献}
      \renewcommand\indexname{索引}
      \renewcommand\abstractname{摘要}
      \renewcommand\contentsname{目录}
      \renewcommand\listfigurename{插图目录}
      \renewcommand\listtablename{表格目录}
      \renewcommand\figurename{图}
      \renewcommand\tablename{表}
      \renewcommand\appendixname{附录}
      \renewcommand\today{\number\year 年\number\month 月\number\day 日}}
    \AtEndDocument{\end{CJK*}}

    \makeatletter
    \if@twoside
      \fancyhead[LE,RO]{\bfseries \nouppercase{\begin{CJK*}{UTF8}{gbsn}\rightmark\end{CJK*}}} 
    \else
      \fancyhead[R]{\bfseries \nouppercase{\begin{CJK*}{UTF8}{gbsn}\rightmark\end{CJK*}}} 
    \fi
    \makeatother

    \newcommand{\handwriting}{\color{gray!66}}
    \renewcommand{\emph}[1]{{\color{\emcolor} \begin{CJK}{UTF8}{gkai}\em #1\end{CJK}}}
    \renewcommand{\textit}[1]{{\begin{CJK*}{UTF8}{gkai}\itshape #1\end{CJK*}}}

    \ifclassical\else
    \renewenvironment{remark}
      {\vspace{0.3\baselineskip}\mparfig{\ideabulb[\mparfigsize]{orange}} %This should be linked with font size.
       \begin{envremark}\begin{CJK*}{UTF8}{gkai}}
      {\end{CJK*}\end{envremark}\vspace{0.5\baselineskip}}
    \fi

    \WarningFilter{natbib}{Citation `}

    \newcommand{\dnf}{{\color{forestgreen}\fbox{\bfseries \begin{CJK*}{UTF8}{gbsn}这里的内容尚未完成\end{CJK*}}}}
  \fi

  %highlight
  \newcommand\highlight[2]{\bgroup\markoverwith
  {\textcolor{#1}{\rule[-0.6ex]{0.1pt}{3ex}}}\hspace{0.1ex}\ULon{#2}} %This should be linked with font size.

\else
  \newcommand\handwriting{\fontfamily{frc}\selectfont\small}

  \def\theoremtitle{Theorem}
  \def\definitiontitle{Definition}
  \def\prooftitle{Proof}
  \def\lemmatitle{Lemma}
  \def\corollarytitle{Corollary}
  \def\propositiontitle{Proposition}
  \def\conjecturetitle{Conjecture}
  \def\exampletitle{Example}
  \def\facttitle{Fact}
  \def\problemtitle{Problem}
  \def\questiontitle{Question}
  \def\exercisetitle{Exercise}
  \def\remarktitle{Remark}
  \def\emailaddr{Email address: }

  \newcommand\mparliftupfactor{1.3} %This should be linked with font size.
  \newcommand\seplineshrink{0.1} %This should be linked with font size.

  \newcommand\highlight[1]{\bgroup\markoverwith
  {\textcolor{#1}{\rule[-.5ex]{2pt}{2.5ex}}}\ULon} %This should be linked with font size.

  \let\emph\relax
  \DeclareTextFontCommand{\emph}{\color{\emcolor}\em}

  \newcommand{\dnf}{{\color{forestgreen}\fbox{\bfseries To be finished here}}}
\fi

%% Publish form
%--------------------------------------------------------------------------
\ifpublish
  \renewcommand\handwriting{}
  \renewcommand\enhandwriting{}
  \renewcommand\mparhand[2][0]{}
  \renewcommand\mparhandnum[2][0]{}
\fi

%% Formal form
%--------------------------------------------------------------------------
\newcommand\informal[1]{\ifonlyformal\else#1\fi}
\newenvironment{informaltexts}
  {\ifonlyformal\setbox0\vbox\bgroup\fi}
  {\ifonlyformal\egroup\fi}

%% Badness adjust
%--------------------------------------------------------------------------
\hyphenpenalty=5000
\hbadness=5000
\tolerance=1500
