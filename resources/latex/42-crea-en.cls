%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 42.cls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Authors:
% - Maxime "zaz" Montinet
% - David "Thor" Giron
%
% Contributors:
% - Mathieu Mahé
% - Gaëtan JUVIN
% - Unknown for now
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This class provides a layout for teaching material at 42.
%
% This class is organized this way :
%
% I - Documentation
%  1. Incompatibilites
% II - General LaTeX boilerplate
%  1. Definition
%  2. Class options and parent class
%  3. Imports
% III - Lengths and color redefinitions
%  1. Lenghts
%  2. Colors
%  3. Hyperlinks
%  4. Listings
%  5. Page layout
%  6. Roman numerals for chapters
% IV - Frontpage customization
%  1. Custom fields
%  2. Redefinition of \maketitle
%  3. Exercice number
% V - Custom helper commands
%  1. Hint/warn
%  2. Lisibility helper
%  3. Exercise headers
%  4. Reproduction from man

%%
%% I - Documentation
%%

%% I.1 - Incompatibilities

% Package ulem:
% The package ulem has a lot of oddities. Using it is not always a
% good idea. If you really want to do so, you should import it with
% the [normalem] option, as such :
%   \usepackage[normalem]{ulem}
% Otherwise, it overrides \emph to underline the emphasized text. So
% far so good, but underlined text is typesetted in a box, which means
% that linebreaks don't happen automatically. Since \abstract (among
% others) uses \emph, the abstract is unreadable by default.
% Please read thoroughly ulem's doc before using it.
% See also: http://www.tex.ac.uk/cgi-bin/texfaq2html?label=underline

%%
%% II - General LaTeX boilerplate
%%

%% II.1 - Definition

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{42-en}[2014/08/22 v2.1
  LaTeX class for 42-themed documents]

%% II.2 - Class options and parent class

\newcommand{\summarytitle}{Summary}%

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{report}
}

\ProcessOptions\relax
\LoadClass[a4paper,12pt,onecolumn]{report}

%% II.3 - Imports

\usepackage[top=1in,bottom=1in,left=1in,right=1in]{geometry}
\usepackage[pdftex]{graphicx}
\usepackage{url}
\usepackage{fancyhdr}
\usepackage{array}
\usepackage[table]{xcolor}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{lmodern}
\usepackage{listings}
\usepackage{tabularx}
\usepackage{textcomp}
\usepackage{color}
\usepackage[pdftex]{hyperref}
\usepackage{fancybox}
\usepackage{float}
\usepackage{atbeginend} % provided locally : atbeginend.sty
\usepackage{tocloft} % provided locally : tocloft.sty
\usepackage{multirow} % provided locally : multirow.sty
\usepackage[english]{babel}
\usepackage{minted} % provided locally : minted.sty
% Minted requires the Python "Pygments" librairy (http://pygments.org/).
% Pygments can be easily installed with the "easy_install" paquet manager
% from the "python-setuptools" paquet (sudo easy_install Pygments).
\usepackage{pifont,mdframed}
\usepackage{wallpaper}

%% III - Lengths and color redefinitions

%% III.1 - Lengths

\AfterBegin{enumerate}{
  \itemsep10pt%
}
\AfterBegin{itemize}{
  \itemsep10pt%
  \renewcommand{\labelitemi}{$\bullet$}%
  \renewcommand{\labelitemii}{$\circ$}%
}

\BeforeBegin{enumerate}{\vspace{15pt}}
\AfterEnd{enumerate}{\vspace{15pt}}

\BeforeBegin{itemize}{\vspace{15pt}}
\AfterEnd{itemize}{\vspace{15pt}}

\BeforeBegin{lstlisting}{\vspace{15pt}}
\AfterEnd{lstlisting}{\vspace{15pt}}

\BeforeBegin{tabularx}{\vspace{15pt}}
\AfterEnd{tabularx}{\vspace{15pt}}

%% III.2 - Colors

\definecolor{nicergreen}{rgb}{0,0.502,0}
\definecolor{nicerblue}{rgb}{0,0.302,1}
\definecolor{nicerorange}{rgb}{1,0.502,0}
\definecolor{nicergrey}{rgb}{0.502,0.502,0.502}
\definecolor{nicerred}{rgb}{0.626,0,0}
\definecolor{hintbg}{rgb}{1.0,1.0,0.75}
\definecolor{warnbg}{rgb}{1.0,0.75,0.75}
\definecolor{infobg}{rgb}{0.75,0.75,1.0}
\definecolor{bibliotechbg}{RGB}{239,253,255}
\definecolor{lightgrey}{rgb}{0.95,0.95,0.95}
\definecolor{darkgrey}{rgb}{0.1,0.1,0.1}
\definecolor{assholeblack}{rgb}{0,0,0}

%% III.3 - Hyperlinks

\hypersetup
{
  colorlinks,
%  citecolor=black,                %
%  filecolor=black,                %
  linkcolor=black,                % black links
  urlcolor=blue                   % blue URLs
}

%% III.4 - Listings

\lstset
{
  backgroundcolor=\color{gray!15},
  basicstyle=\small\ttfamily,
  breaklines=true,
  columns=fullflexible,
  frame=lines,
  tabsize=4,
  numbers=none, %numbers=left,
  numberstyle=\scriptsize\ttfamily,
  numbersep=5pt,
  showspaces=false,
  showstringspaces=false,
  showtabs=false,
  breaklines=true,
  upquote=true,
  float
}

%% III.5 - Page layout

\makeatletter
\pagestyle{fancy}
\lhead{\@title}
\rhead{\@subtitle}
\cfoot{\thepage}
\makeatother

%% III.6 - Roman chapter style

% custom sections style

\renewcommand{\thechapter}{\Roman{chapter}}

% Using  roman  numerals  makes  the  TOC  section/subsection  numbers
% overflow on the  right. This adds some margin to  avoid that kind of
% problems. (requires \usepackage{tocloft})
\setlength{\cftchapnumwidth}{1.5cm}
\setlength{\cftsecnumwidth}{1.5cm}
\setlength{\cftsubsecnumwidth}{1.3cm}
\setlength{\cftsubsubsecnumwidth}{1.6cm}
\setlength{\cftaftertoctitleskip}{0.5cm}

%% IV - Frontpage customization

%% IV.1 - Custom fields
\makeatletter
\newcommand{\website}[1]{\def \@website {#1}}
\website{}

\newcommand{\subtitle}[1]{\def \@subtitle {#1}}
\subtitle{}

\newcommand{\schoollogo}[1]{\def \@schoollogo {#1}}
\schoollogo{42_logo.pdf}

\newcommand{\summary}[1]{\def \@summary {#1}}
\summary{}

\edef\@authors{}
\newcommand{\member}[2]{%
  \protected@edef\@authors{\@authors #1 \protect\url{#2}\\}
  \author{\@authors}
}
\author{}

%% IV.2 - Redefine \maketitle

\makeatletter
\def \maketitle {
  \begin{titlepage}
    \begin{center}
	%\begin{figure}[t]
	\includegraphics[height=8cm]{\@schoollogo}
	%\end{figure}
      \vskip 5em
      {\huge \@title}
      \vskip 2em
      {\LARGE \@subtitle}
      \vskip 4em
    \end{center}
    \begin{center}
	  \@author
    \end{center}
	\vskip 5em
	\begin{center}
    \emph{\summarytitle : \@summary}
	\end{center}
  \end{titlepage}
}
\makeatother

\TileWallPaper{\paperwidth}{\paperheight}{back}
%% IV.3 - Exercice number

\newcounter{exerciceCounter}
\newcommand*{\exercicenumber}{
  \ifnum\value{exerciceCounter}<10 0\fi
  \arabic{exerciceCounter}
}

\newcommand*{\startexercices}{
  \setcounter{exerciceCounter}{0}
}

\newcommand*{\nextexercice}{
  \stepcounter{exerciceCounter}
}

\newcounter{itemizeCounter}
\setcounter{itemizeCounter}{0}
\BeforeBegin{itemize}{
  \addtocounter{itemizeCounter}{1}
}

\AfterEnd{itemize}{
  \addtocounter{itemizeCounter}{-1}
  \ifnum\value{itemizeCounter} = 0
    \stepcounter{exerciceCounter}
  \fi
}

%% V - Custom helper commands

%% V.1 - Hint/Warn

% hint command

\newcommand{\kbox}[3]
{
  \vskip 15pt
  \noindent
  \colorbox{#1}
  {
    \begin{tabular*}{0.97\textwidth}{m{4em}m{0.8\textwidth}}
        \includegraphics[width=4em]{#2}
      & {\ttfamily\footnotesize #3}\\
    \end{tabular*}
  }
  \vskip 15pt
}

\newcommand{\hint}[1]{\kbox{hintbg}{helphint.pdf}{#1}}
\newcommand{\warn}[1]{\kbox{warnbg}{warn.pdf}{#1}}
\newcommand{\info}[1]{\kbox{infobg}{info.pdf}{#1}}

%% V.2 Lisibility helper

\makeatletter
\newcommand{\mso}[1]{
  \ttfamily #1 \normalfont
}

%% V.3 Exercise headers

\makeatletter
\newcommand{\turnindir}[1]{\def \@turnindir {#1}}
\newcommand{\daypiscine}[1]{\def \@daypiscine {#1}}
\newcommand{\extitle}[1]{\def \@extitle {#1}}
\newcommand{\exnumber}[1]{\def \@exnumber {#1}}
\newcommand{\exscore}[1]{\def \@exscore {#1}}
\newcommand{\exflags}[1][-W -Wall -Werror]{\def \@exflags {#1}}
\newcommand{\excompil}[1][gcc]{\def \@excompil {#1}}
\newcommand{\exrules}[1][n/a]{\def \@exrules {#1}}
\newcommand{\exfiles}[1]{\def \@exfiles {#1}}
\newcommand{\exnotes}[1][n/a]{\def \@exnotes {#1}}
\newcommand{\exauthorize}[1]{\def \@exauthorize {#1}}
\newcommand{\exforbidden}[1]{\def \@exforbidden {#1}}
\newcommand{\exdocres}[1]{\def \@exdocres {#1}}
\newcommand{\exdocsize}[1]{\def \@exdocsize {#1}}
\newcommand{\excolormode}[1]{\def \@excolormode {#1}}
\newcommand{\exmake}[1][No]{\def \@exmake {#1}}


% Default values
\turnindir{}
\daypiscine{}
\extitle{}
\exnumber{}
\exscore{}
\exflags{}
\excompil{}
\exrules{}
\exfiles{}
\exnotes{}
\exauthorize{None}
\exforbidden{None}
\exmake{}

%Header pour exercices sans rien a "rendre"
\newcommand{\makeheaderbasic}
{
  \noindent
  \begin{tabularx}{\textwidth}{|X X  X X|}
    \hline
  \multicolumn{1}{|>{\raggedright}m{1cm}|}
  {\vskip 2mm \includegraphics[height=1cm]{\@schoollogo}} &
  \multicolumn{2}{>{\centering}m{12cm}}{\small Exercise : \@exnumber } &
  \multicolumn{1}{ >{\raggedleft}p{1.5cm}|}
%%              {\scriptsize points : \@exscore} \\ \hline
              {} \\ \hline

  \multicolumn{4}{|>{\centering}m{15cm}|}
              {\small \@extitle} \\ \hline

   \multicolumn{4}{|>{\raggedright}m{15cm}|}
               {\small Notes : \ttfamily \@exnotes }
               \\ \hline
\end{tabularx}
\exnotes
\exrules
\exmake
\exauthorize{None}
\exforbidden{None}
\extitle{}
\exnumber{}
}

%Header pour exercices sans code mais fichiers a rendre
\newcommand{\makeheaderfiles}
{
  \noindent
  \begin{tabularx}{\textwidth}{|X X  X X|}
    \hline
  \multicolumn{1}{|>{\raggedright}m{1cm}|}
  {\vskip 2mm \includegraphics[height=1cm]{\@schoollogo}} &
  \multicolumn{2}{>{\centering}m{12cm}}{\small Exercise \@exnumber } &
  \multicolumn{1}{ >{\raggedleft}p{1.5cm}|}
%%              {\scriptsize points : \@exscore} \\ \hline
              {} \\ \hline

  \multicolumn{4}{|>{\centering}m{15cm}|}
              {\small \@extitle} \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Turn-in directory : \ttfamily
                $ex\@exnumber/$ }
              \\ \hline
  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Files to turn in : \ttfamily \@exfiles }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Allowed functions : \ttfamily \@exauthorize }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Notes : \ttfamily \@exnotes }
              \\ \hline
\end{tabularx}
\exnotes
\exrules
\exmake
\exauthorize{None}
\exforbidden{None}
\extitle{}
\exnumber{}
}

%Header pour exercices sans code mais fichiers a rendre
\newcommand{\makeheaderfilesforbidden}
{
  \noindent
  \begin{tabularx}{\textwidth}{|X X  X X|}
    \hline
  \multicolumn{1}{|>{\raggedright}m{1cm}|}
  {\vskip 2mm \includegraphics[height=1cm]{\@schoollogo}} &
  \multicolumn{2}{>{\centering}m{12cm}}{\small Exercise \@exnumber } &
  \multicolumn{1}{ >{\raggedleft}p{1.5cm}|}
%%              {\scriptsize points : \@exscore} \\ \hline
              {} \\ \hline

  \multicolumn{4}{|>{\centering}m{15cm}|}
              {\small \@extitle} \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Turn-in directory : \ttfamily
                $ex\@exnumber/$ }
              \\ \hline
  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Files to turn in : \ttfamily \@exfiles }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Forbidden functions : \ttfamily \@exforbidden }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Remarks : \ttfamily \@exnotes }
              \\ \hline
\end{tabularx}
\exnotes
\exrules
\exmake
\exauthorize{None}
\exforbidden{None}
\extitle{}
\exnumber{}
}

%Header pour exercices de code
\newcommand{\makeheadercode}
{
  \noindent
  \begin{tabularx}{\textwidth}{|X X  X X|}
    \hline
  \multicolumn{1}{|>{\raggedright}m{1cm}|}
  {\vskip 2mm \includegraphics[height=1cm]{\@schoollogo}} &
  \multicolumn{2}{>{\centering}m{12cm}}{\small Exercise \@exnumber } &
  \multicolumn{1}{ >{\raggedleft}p{1.5cm}|}
  %%              {\scriptsize Score : \@exscore} \\ \hline
              {} \\ \hline

  \multicolumn{4}{|>{\centering}m{15cm}|}
              {\small \@extitle} \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Turn-in directory: \ttfamily
                $ex\@exnumber/$ }
              \\ \hline

  \multicolumn{2}{|>{\raggedright}m{7.5cm}}
              {\small Compiler: \ttfamily \@excompil } &
  \multicolumn{2}{|>{\raggedright}m{7.5cm}|}
              {\small Compilation flags:
                \ttfamily \@exflags }
              \\ \hline

  \multicolumn{2}{|>{\raggedright}m{7.52cm}}
              {\small Makefile: \ttfamily{\@exmake}} &
  \multicolumn{2}{|>{\raggedright}m{7.5cm}|}
              {Makefile rules: \ttfamily \@exrules } \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Files to turn in: \ttfamily \@exfiles }
              \\ \hline

   \multicolumn{4}{|>{\raggedright}m{15cm}|}
               {\small Notes : \ttfamily \@exnotes }
               \\ \hline

   \multicolumn{4}{|>{\raggedright}m{15cm}|}
               {\small Forbidden fonctions: \ttfamily \@exforbidden }
               \\ \hline
\end{tabularx}
\exnotes
\exrules
\exmake
\exforbidden{None}
\exauthorize{None}
\extitle{}
\exnumber{}
}

%Header pour exercices sur Photoshop

\newcommand{\makephotoshopheader}
{
  \noindent
  \begin{tabularx}{\textwidth}{|X X  X X|}
    \hline
  \multicolumn{1}{|>{\raggedright}m{1cm}|}
  {\vskip 2mm \includegraphics[height=1cm]{\@schoollogo}} &
  \multicolumn{2}{>{\centering}m{12cm}}{\small Exercice : \@exnumber } &
  \multicolumn{1}{ >{\raggedleft}p{1.5cm}|}
%%              {\scriptsize points : \@exscore} \\ \hline
              {} \\ \hline

  \multicolumn{4}{|>{\centering}m{15cm}|}
              {\small \@extitle} \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Turn-in directory : \ttfamily
                $ex\@exnumber/$ }
              \\ \hline
  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Document size : \ttfamily \@exdocsize }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Document resolution : \ttfamily \@exdocres }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Color mode : \ttfamily \@excolormode }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Forbidden functions : \ttfamily \@exforbidden }
              \\ \hline

\end{tabularx}
\exnotes
\exrules
\exmake
\exdocres{300dpi}
\exdocsize{1980x1080px}
\excolormode{RGB}
\exforbidden{Aucune}
\extitle{}
\exnumber{}
}


\newcommand{\exmandatory}{Mandatory exercise}
\newcommand{\exretrovalid}{Retrovalidated exercise}
\newcommand{\exoptional}{Optional exercise}

\newcommand{\exercice}{Exercise}

%% V.4 Reproduction from man
\newcommand{\reproductionfromman}[1]{Reproduce the behavior of the function \texttt{#1} (man #1).}

%% VI - Syntactic highlights


%% Styles:
%% ~~~~~~~
%% * monokai:
%%     This style mimics the Monokai color scheme.
%% * manni:
%%     A colorful style, inspired by the terminal highlighting style.
%% * rrt:
%%     Minimalistic ``rrt'' theme, based on Zap and Emacs defaults.
%% * perldoc:
%%     Style similar to the style used in the perldoc code blocks.
%% * borland:
%%     Style similar to the style used in the borland IDEs.
%% * colorful:
%%     A colorful style, inspired by CodeRay.
%% * default:
%%     The default style (inspired by Emacs 22).
%% * murphy:
%%     Murphy's style from CodeRay.
%% * vs:
%%
%% * trac:
%%     Port of the default trac highlighter design.
%% * tango:
%%     The Crunchy default Style inspired from the color palette from the Tango Icon Theme Guidelines.
%% * fruity:
%%     Pygments version of the ``native'' vim theme.
%% * autumn:
%%     A colorful style, inspired by the terminal highlighting style.
%% * bw:
%%
%% * emacs:
%%     The default style (inspired by Emacs 22).
%% * vim:
%%     Styles somewhat like vim 7.0
%% * pastie:
%%     Style similar to the pastie default style.
%% * friendly:
%%     A modern style based on the VIM pyte theme.
%% * native:
%%     Pygments version of the ``native'' vim theme.



%\usemintedstyle{monokai}
%\usemintedstyle{manni}
%\usemintedstyle{rrt}
%\usemintedstyle{perldoc}
%\usemintedstyle{borland}
%\usemintedstyle{colorful}
%\usemintedstyle{default}
%\usemintedstyle{murphy}
%\usemintedstyle{vs}
%\usemintedstyle{trac}
%\usemintedstyle{tango}
%\usemintedstyle{fruity}
%\usemintedstyle{autumn}
%\usemintedstyle{bw}
%\usemintedstyle{emacs}
%\usemintedstyle{vim}
%\usemintedstyle{pastie}
%\usemintedstyle{friendly}
%\usemintedstyle{native}

\makeatletter
\newenvironment{42ccode}{%
  \VerbatimEnvironment
  \usemintedstyle{emacs}
  \minted@resetoptions
  \setkeys{minted@opt}{bgcolor=black,formatcom=\color{lightgrey},fontsize=\scriptsize}
  \begin{figure}[ht!]
    \centering
    \begin{minipage}{16cm}
      \begin{VerbatimOut}{\jobname.pyg}}
{%
      \end{VerbatimOut}
      \minted@pygmentize{c}
      \DeleteFile{\jobname.pyg}
    \end{minipage}
\end{figure}}
\makeatother

\makeatletter
\newenvironment{42phpcode}{%
  \VerbatimEnvironment
  \usemintedstyle{emacs}
  \minted@resetoptions
  \setkeys{minted@opt}{bgcolor=black,formatcom=\color{lightgrey},fontsize=\scriptsize}
  \begin{figure}[ht!]
    \centering
    \begin{minipage}{16cm}
      \begin{VerbatimOut}{\jobname.pyg}}
{%
      \end{VerbatimOut}
      \minted@pygmentize{html+php}
      \DeleteFile{\jobname.pyg}
    \end{minipage}
\end{figure}}
\makeatother

\makeatletter
\newenvironment{42yamlcode}{%
  \VerbatimEnvironment
  \usemintedstyle{native}
  \minted@resetoptions
  \setkeys{minted@opt}{bgcolor=black,formatcom=\color{lightgrey},fontsize=\scriptsize}
  \begin{figure}[ht!]
    \centering
    \begin{minipage}{16cm}
      \begin{VerbatimOut}{\jobname.pyg}}
{%
      \end{VerbatimOut}
      \minted@pygmentize{yaml}
      \DeleteFile{\jobname.pyg}
    \end{minipage}
\end{figure}}
\makeatother

\definecolor{darcula-back}{RGB}{35, 37, 37}

\makeatletter
\newenvironment{42javacode}{%
  \VerbatimEnvironment
  \usemintedstyle{monokai}
  \minted@resetoptions
  \definecolor{dark}{RGB}{35, 37, 37}
  \setkeys{minted@opt}{bgcolor=darcula-back,formatcom=\color{lightgrey},fontsize=\scriptsize}
  \begin{figure}[ht!]
    \centering
    \begin{minipage}{16cm}
      \begin{VerbatimOut}{\jobname.pyg}}
{%[
      \end{VerbatimOut}
      \minted@pygmentize{java}
      \DeleteFile{\jobname.pyg}
    \end{minipage}
\end{figure}}
\makeatother

\makeatletter
\newenvironment{42xmlcode}{%
  \VerbatimEnvironment
  \usemintedstyle{native}
  \minted@resetoptions
  \setkeys{minted@opt}{bgcolor=darcula-back,formatcom=\color{lightgrey},fontsize=\scriptsize}
  \begin{figure}[ht!]
    \centering
    \begin{minipage}{16cm}
      \begin{VerbatimOut}{\jobname.pyg}}
{%[
      \end{VerbatimOut}
      \minted@pygmentize{xml}
      \DeleteFile{\jobname.pyg}
    \end{minipage}
\end{figure}}
\makeatother

\makeatletter
\newenvironment{42cppcode}{%
  \VerbatimEnvironment
  \usemintedstyle{native}
  \minted@resetoptions
  \setkeys{minted@opt}{bgcolor=black,formatcom=\color{lightgrey},fontsize=\scriptsize}
  \begin{figure}[ht!]
    \centering
    \begin{minipage}{16cm}
      \begin{VerbatimOut}{\jobname.pyg}}
{%
      \end{VerbatimOut}
      \minted@pygmentize{c++}
      \DeleteFile{\jobname.pyg}
    \end{minipage}
\end{figure}}
\makeatother


\makeatletter
\newenvironment{42ocamlcode}{%
  \VerbatimEnvironment
  \usemintedstyle{native}
  \minted@resetoptions
  \setkeys{minted@opt}{bgcolor=black,formatcom=\color{lightgrey},fontsize=\scriptsize}
  \begin{figure}[ht!]
    \centering
    \begin{minipage}{16cm}
      \begin{VerbatimOut}{\jobname.pyg}}
{%
      \end{VerbatimOut}
      \minted@pygmentize{ocaml}
      \DeleteFile{\jobname.pyg}
    \end{minipage}
\end{figure}}
\makeatother


\makeatletter
\newenvironment{42asmcode}{%
  \VerbatimEnvironment
  \usemintedstyle{native}
  \minted@resetoptions
  \setkeys{minted@opt}{bgcolor=black,formatcom=\color{lightgrey},fontsize=\scriptsize}
  \begin{figure}[ht!]
    \centering
    \begin{minipage}{16cm}
      \begin{VerbatimOut}{\jobname.pyg}}
{%
      \end{VerbatimOut}
      \minted@pygmentize{nasm}
      \DeleteFile{\jobname.pyg}
    \end{minipage}
\end{figure}}
\makeatother

\lstnewenvironment{42console} {
	  \lstset {
        basicstyle=\color{lightgrey}\scriptsize\ttfamily,
		backgroundcolor=\color{assholeblack},
		breaklines=true,
		numberstyle=\scriptsize,
        columns=flexible,
        keepspaces=true,
	  }
}{}

\newenvironment{42warning}
  {\vspace*{1\baselineskip}
  \par\begin{mdframed}[linewidth=2pt,linecolor=red]%
  \begin{list}{}{\leftmargin=1cm
  				\labelwidth=\leftmargin}\item[\Large\ding{43}]}
   {\end{list}\end{mdframed}\par \vspace*{1\baselineskip}}
