%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 42-pt.cls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Autores:
% - Maxime "zaz" Montinet
% - David "Thor" Giron
%
% Colaboradores:
% - Mathieu Mahé
% - Gaëtan JUVIN
% - Desconhecido por enquanto
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Esta classe fornece o layout do material de ensino na 42.
%
% Esta classe é organizada como segue:
%
% I - Documentação
%  1. Incompatibilidades
% II - Clichês gerais LaTeX
%  1. Definição
%  2. Opções de classe e classe pai
%  3. Importações
% III - Comprimentos e redefinições de cores
%  1. Comprimentos
%  2. Cores
%  3. Hiperlinks
%  4. Listagens
%  5. Layout da página
%  6. Numerais romanos para os capítulos
% IV - Personalização da primeira página
%  1. Campos personalizados
%  2. Redefinição de \maketitle
%  3. Número do exercício
% V - Comandos de auxiliar personalizados
%  1. Dica/aviso
%  2. Auxiliar de legibilidade
%  3. Cabeçalho dos exercícios
%  4. Reprodução de man

%%
%% I - Documentação
%%

%% I.1 - Incompatibilidades

% Pacote ulem:
% O pacote ulem tem muitas peculiaridades. Nem sempre é uma
% boa ideia usá-lo. Se quiser mesmo usá-lo, você deve importá-lo com
% a opção [normalem], como:
%   \usepackage[normalem]{ulem}
% Se não fizer assim, ele substituirá o \emph para sublinhar o texto destacado. Até
% aqui, tudo bem, mas o texto sublinhado é composto em uma caixa, o que significa
% que as quebras de linha não acontecem automaticamente. Uma vez que \abstract (entre
% outros) usa \emph, o abstract fica ilegível por padrão.
% Leia o doc do ulem cuidadosamente antes de usá-lo.
% Veja também: http://www.tex.ac.uk/cgi-bin/texfaq2html?label=underline

%%
%% II - Clichês gerais LaTeX
%%

%% II.1 - Definição

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{42-pt}[2010/07/15 v2.0 
  Classe LaTeX para documentos com o tema da 42]

%% II.2 - Opções de classe e classe pai

\newcommand{\summarytitle}{Sumário}%

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{report}
}

\ProcessOptions\relax
\LoadClass[a4paper,12pt,onecolumn]{report}

%% II.3 - Importações

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
\usepackage{atbeginend} % fornecido localmente : atbeginend.sty
\usepackage{tocloft} % fornecido localmente : tocloft.sty
\usepackage{multirow} % fornecido localmente : multirow.sty
\usepackage[portuguese]{babel}
\usepackage{minted} % fornecido localmente : minted.sty
% Minted exige uma biblioteca "Pygments" Python (http://pygments.org/).
% Pygments pode ser instalado com facilidade com o gerenciador de pacotes "easy_install"
% do pacote "python-setuptools" (sudo easy_install Pygments).
\usepackage{pifont,mdframed}
\usepackage{wallpaper}

%% III - Comprimentos e redefinições de cores

%% III.1 - Comprimentos

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

%% III.2 - Cores

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

%% III.3 - Hiperlinks

\hypersetup
{
  colorlinks,
%  citecolor=black,                %
%  filecolor=black,                %
  linkcolor=black,                % links em preto
  urlcolor=blue                   % URLs em azul
}

%% III.4 - Listagens

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

%% III.5 - Layout da página

\makeatletter
\pagestyle{fancy}
\lhead{\@title}
\rhead{\@subtitle}
\cfoot{\thepage}
\makeatother

%% III.6 - Estilo de capítulo romano

% estilo de seções personalizadas

\renewcommand{\thechapter}{\Roman{chapter}}

% Usar numerais romanos faz os números da seção/subseção TOC
% estourarem à direita. Isto adiciona margem para evitar esse tipo de
% problema. (exige \usepackage{tocloft})
\setlength{\cftchapnumwidth}{1.5cm}
\setlength{\cftsecnumwidth}{1.5cm}
\setlength{\cftsubsecnumwidth}{1.3cm}
\setlength{\cftsubsubsecnumwidth}{1.6cm}
\setlength{\cftaftertoctitleskip}{0.5cm}

%% IV - Personalização da primeira página

%% IV.1 - Campos personalizados
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

%% IV.2 - Redefinir \maketitle

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
%% IV.3 - Número do exercício

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

%% V - Comandos de auxiliar personalizados

%% V.1 - Dica/Aviso

% comando de dica

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

%% V.2 Auxiliar de legibilidade

\makeatletter
\newcommand{\mso}[1]{
  \ttfamily #1 \normalfont
}

%% V.3 Cabeçalhos de exercícios

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
\newcommand{\exmake}[1][Non]{\def \@exmake {#1}}

% Valores padrão
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
\exauthorize{Nenhuma}
\exforbidden{Nenhuma}
\exmake{}

%Cabeçalho para exercícios sem nada para "entregar"
\newcommand{\makeheaderbasic}
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

%%    \multicolumn{4}{|>{\raggedright}m{15cm}|}
%%                {\small Notas: \ttfamily \@exnotes }
%%                \\ \hline
\end{tabularx}
%% \exnotes
\exrules
\exmake
%\exauthorize
\exforbidden{Nenhuma}
\extitle{}
\exnumber{}
}

%Cabeçalho para exercícios sem código mas com arquivos para entregar
\newcommand{\makeheaderfiles}
{
  \noindent
  \begin{tabularx}{\textwidth}{|X X  X X|}
    \hline
  \multicolumn{1}{|>{\raggedright}m{1cm}|}
  {\vskip 2mm \includegraphics[height=1cm]{\@schoollogo}} &
  \multicolumn{2}{>{\centering}m{12cm}}{\small Exercício : \@exnumber } &
  \multicolumn{1}{ >{\raggedleft}p{1.5cm}|}
%%              {\scriptsize points : \@exscore} \\ \hline
              {} \\ \hline

  \multicolumn{4}{|>{\centering}m{15cm}|}
              {\small \@extitle} \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Pasta de entrega : \ttfamily
                $ex\@exnumber/$ }
              \\ \hline
  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Arquivos para entregar : \ttfamily \@exfiles }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Funções autorizadas : \ttfamily \@exauthorize }
              \\ \hline

%%   \multicolumn{4}{|>{\raggedright}m{15cm}|}
%%               {\small Notas : \ttfamily \@exnotes }
%%               \\ \hline
\end{tabularx}
%% \exnotes
\exrules
\exmake
\exauthorize{Nenhuma}
\exforbidden{Nenhuma}
\extitle{}
\exnumber{}
}

%Cabeçalho para exercícios sem pasta de entrega
\newcommand{\makeheaderfilesnodirectory}
{
  \noindent
  \begin{tabularx}{\textwidth}{|X X  X X|}
    \hline
  \multicolumn{1}{|>{\raggedright}m{1cm}|}
  {\vskip 2mm \includegraphics[height=1cm]{\@schoollogo}} &
  \multicolumn{2}{>{\centering}m{12cm}}{\small Exercício: \@exnumber } &
  \multicolumn{1}{ >{\raggedleft}p{1.5cm}|}
%%              {\scriptsize points : \@exscore} \\ \hline
              {} \\ \hline

  \multicolumn{4}{|>{\centering}m{15cm}|}
              {\small \@extitle} \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Arquivos para entregar : \ttfamily \@exfiles }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Funções autorizadas : \ttfamily \@exauthorize }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Notas: \ttfamily \@exnotes }
              \\ \hline
\end{tabularx}
\exnotes
\exrules
\exmake
\exauthorize{Nenhuma}
\exforbidden{Nenhuma}
\extitle{}
\exnumber{}
}

%Cabeçalho para exercícios sem código mas com arquivos para entregar
\newcommand{\makeheaderfilesforbidden}
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
              {\small Pasta de entrega : \ttfamily
                $ex\@exnumber/$ }
              \\ \hline
  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Arquivos para entregar : \ttfamily \@exfiles }
              \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Funções não permitidas : \ttfamily \@exforbidden }
              \\ \hline

%%   \multicolumn{4}{|>{\raggedright}m{15cm}|}
%%               {\small Notas : \ttfamily \@exnotes }
%%               \\ \hline
\end{tabularx}
%% \exnotes
\exrules
\exmake
\exauthorize{Nenhuma}
\exforbidden{Nenhuma}
\extitle{}
\exnumber{}
}


%Cabeçalho para exercícios de código
\newcommand{\makeheadercode}
{
  \noindent
  \begin{tabularx}{\textwidth}{|X X  X X|}
    \hline
  \multicolumn{1}{|>{\raggedright}m{1cm}|}
  {\vskip 2mm \includegraphics[height=1cm]{\@schoollogo}} &
  \multicolumn{2}{>{\centering}m{12cm}}{\small Exercício : \@exnumber } &
  \multicolumn{1}{ >{\raggedleft}p{1.5cm}|}
  %%              {\scriptsize points : \@exscore} \\ \hline
              {} \\ \hline

  \multicolumn{4}{|>{\centering}m{15cm}|}
              {\small \@extitle} \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Pasta de entrega: \ttfamily
                $ex\@exnumber/$ }
              \\ \hline

  \multicolumn{2}{|>{\raggedright}m{7.5cm}}
              {\small Compilador : \ttfamily \@excompil } &
  \multicolumn{2}{|>{\raggedright}m{7.5cm}|}
              {\small Sinalização de compilação:
                \ttfamily \@exflags }
              \\ \hline

  \multicolumn{2}{|>{\raggedright}m{7.52cm}}
              {\small Makefile : \ttfamily{\@exmake}} &
  \multicolumn{2}{|>{\raggedright}m{7.5cm}|}
              {R\`{e}gles : \ttfamily \@exrules } \\ \hline

  \multicolumn{4}{|>{\raggedright}m{15cm}|}
              {\small Arquivos para entregar : \ttfamily \@exfiles }
              \\ \hline

   \multicolumn{4}{|>{\raggedright}m{15cm}|}
               {\small Notas: \ttfamily \@exnotes }
               \\ \hline

   \multicolumn{4}{|>{\raggedright}m{15cm}|}
               {\small Funções não permitidas : \ttfamily \@exforbidden }
               \\ \hline
\end{tabularx}
\exnotes
\exrules
\exmake
\exforbidden{Nenhuma}
\extitle{}
\exnumber{}
}

\newcommand{\ftname}[1]{\def \@ftname {#1}}
\newcommand{\ftprototype}[1]{\def \@ftprototype {#1}}
\newcommand{\ftdesc}[1]{\def \@ftdesc {#1}}
\newcommand{\ftparams}[1]{\def \@ftparams {#1}}
\newcommand{\ftret}[1]{\def \@ftret {#1}}
\newcommand{\ftfuncts}[1]{\def \@ftfuncts {#1}}
\newcommand{\ftturnin}[1]{\def \@ftturnin {#1}}
\newcommand{\ftmakefile}[1]{\def \@ftmakefile {#1}}
\newcommand{\ftlibft}[1]{\def \@ftlibft {#1}}
\newcommand{\ftcompil}[1]{\def \@ftcompil {#1}}

\ftname{}
\ftprototype{}
\ftdesc{}
\ftparams{}
\ftret{}
\ftfuncts{}
\ftturnin{}
\ftmakefile{}
\ftlibft{}
\ftcompil{}


\newcolumntype{s}{>{\hsize=.5\hsize}X}
\newcolumntype{b}{>{\hsize=1.5\hsize}X}
\newcommand{\makeheaderfct}
{
  \noindent

  \begin{tabularx}{\textwidth}{| s | b |} \hline

    \textbf{Nome da função} & \texttt{\@ftname} \\ \hline    
    \textbf{Protótipo} & \texttt{\@ftprototype} \\ \hline
    \textbf{Arquivos de entrega} & \texttt{\@ftturnin} \\ \hline
    \textbf{Parâmetros} & \texttt{\@ftparams} \\ \hline
    \textbf{Valor de retorno} & \texttt{\@ftret} \\ \hline
    \textbf{Funções externas autorizadas} & \texttt{\@ftfuncts} \\ \hline
    \textbf{Descrição} & \texttt{\@ftdesc} \\ \hline

\end{tabularx}
}

\newcommand{\makeheaderlib}
{
  \noindent

  \begin{tabularx}{\textwidth}{| s | b |} \hline

    \textbf{Nome do programa} & \texttt{\@ftname} \\ \hline
    \textbf{Arquivos de entrega} & \texttt{\@ftturnin} \\ \hline
    \textbf{Makefile} & \texttt{\@ftmakefile} \\ \hline
    \textbf{Funções externas autorizadas} & \texttt{\@ftfuncts} \\ \hline
    \textbf{Libft autorizado} & \texttt{\@ftlibft} \\ \hline
    \textbf{Descrição} & \texttt{\@ftdesc} \\ \hline

\end{tabularx}
}

\newcommand{\makeheaderprg}
{
  \noindent

  \begin{tabularx}{\textwidth}{| s | b |} \hline

    \textbf{Nome do programa} & \texttt{\@ftname} \\ \hline
    \textbf{Arquivos de entrega} & \texttt{\@ftturnin} \\ \hline
    \textbf{Makefile} & \texttt{\@ftmakefile} \\ \hline
    \textbf{Argumentos} & \texttt{\@ftparams} \\ \hline
    \textbf{Funções externas autorizadas} & \texttt{\@ftfuncts} \\ \hline
    \textbf{Libft autorizado} & \texttt{\@ftlibft} \\ \hline
    \textbf{Descrição} & \texttt{\@ftdesc} \\ \hline

\end{tabularx}
}


\newcommand{\exmandatory}{Exercício obrigatório}
\newcommand{\exretrovalid}{Exercício retrovalidável}
\newcommand{\exoptional}{Exercício bônus}

\newcommand{\exercice}{Exercício}

%% V.4 Reprodução de man
\newcommand{\reproductionfromman}[1]{Reproduzir de forma idêntica o funcionamento da função \texttt{#1} (man #1).}

%% VI - Destaques sintáticos


%% Estilos:
%% ~~~~~~~
%% * monokai:
%%     Este estilo imita o esquema de cores Monokai.
%% * manni:
%%     Um estilo colorido, inspirado pelo estilo de destaque terminal.
%% * rrt:
%%     Tema "rrt'' minimalista, baseado nos padrões Zap e Emacs.
%% * perldoc:
%%     Estilo semelhante ao estilo usado nos blocos de código perldoc.
%% * borland:
%%     Estilo semelhante ao estilo usado nos IDEs do borland.
%% * colorful:
%%     Um estilo colorido inspirado em CodeRay.
%% * default:
%%     O estilo padrão (inspirado em Emacs 22).
%% * murphy:
%%     Estilo do Murphy do CodeRay.
%% * vs:
%%
%% * trac:
%%     Porta do design do marca-texto trac padrão.
%% * tango:
%%     O estilo padrão Crunchy inspirado na paleta de cores das diretrizes do tema do ícone Tango.
%% * fruity:
%%     Versão de Pygments do tema "nativo'' vim.
%% * autumn:
%%     Um estilo colorido, inspirado pelo estilo de destaque terminal.
%% * bw:
%%
%% * emacs:
%%     O estilo padrão (inspirado em Emacs 22).
%% * vim:
%%     Estilos parecidos com vim 7.0
%% * pastie:
%%     Estilo semelhante ao estilo padrão pastie.
%% * friendly:
%%     Estilo moderno baseado no tema VIM pyte.
%% * native:
%%     Versão de Pygments do tema "nativo'' vim.



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
{%[
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
\newenvironment{42jscode}{%
  \VerbatimEnvironment
  \usemintedstyle{emacs}
  \minted@resetoptions
  \setkeys{minted@opt}{bgcolor=black,formatcom=\color{lightgrey},fontsize=\scriptsize}
  \begin{figure}[ht!]
    \centering
    \begin{minipage}{16cm}
      \begin{VerbatimOut}{\jobname.pyg}}
{%[
      \end{VerbatimOut}
      \minted@pygmentize{js}
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
        extendedchars=true,
        literate={✓}{{\checkmark}}1,
        basicstyle=\color{lightgrey}\scriptsize\ttfamily,
        backgroundcolor=\color{assholeblack},
        breaklines=true,
        numberstyle=\scriptsize,
        columns=flexible,
        keepspaces=false,
    }
}{}

\newenvironment{42warning}
  {\vspace*{1\baselineskip}
  \par\begin{mdframed}[linewidth=2pt,linecolor=red]%
  \begin{list}{}{\leftmargin=1cm
          \labelwidth=\leftmargin}\item[\Large\ding{43}]}
   {\end{list}\end{mdframed}\par \vspace*{1\baselineskip}}
