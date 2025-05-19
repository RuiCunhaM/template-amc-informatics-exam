\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{informatics}
  [2024/12/26 v1.0 - Maintainer: Rui Cunha Monteiro (rui.p.monteiro@inesctec.pt)]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Packages %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[T1]{fontenc}
\RequirePackage[portuguese]{babel}
\RequirePackage{multicol}
\RequirePackage{verbatimbox}
\RequirePackage{MnSymbol}
\RequirePackage[a4paper]{geometry}

\LoadClass[a4paper]{article}

\RequirePackage[box,insidebox,completemulti,lang=PT]{automultiplechoice}
\setdefaultgroupmode{withoutreplacement}
\def\multiSymbole{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Counters %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{poolQCounter}
\newcounter{groupCounter}
\newcounter{QItemCounter}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Header %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Based on professor jop's version
\newcommand{\header}[7]{
  \newcommand{\discipline}{#1}
  \newcommand{\examtype}{#2}
  \newcommand{\course}{#3}
  \newcommand{\examdate}{#4}
  \newcommand{\duration}{#5}
  \newcommand{\maxscore}{#6}
  \newcommand{\instructions}{#7}

  \begin{minipage}{0.75\linewidth}
    \namefield{{
      \begin{minipage}{\linewidth}
        \textbf{Nome:}\dotfill
        \vspace*{0.5cm}
      \end{minipage}}
    }
    \textsc{\course} ~ -- ~ \textsc{Universidade do Minho}\\[1ex]
    {\Large \textbf{{\examtype} de {\discipline}}}\\[1ex]
    \examdate{} -- Duração: \duration ~\\[1ex]
    \mbox{}\\[0.5ex]
    \fbox{
      \begin{minipage}{.98\linewidth}
        {\textbf{Instruções: }{\it\instructions}}
      \end{minipage}
    }
  \end{minipage}
  ~~~~
  \begin{minipage}{0.25\linewidth}
    \textbf{Número:}\dotfill{\hphantom{numero}}
    \par
    \vspace*{.2cm}
    \AMCcode{numero}{6}
  \end{minipage}\\[.1ex]
  \vspace*{0.2cm}
  \hrule
  \vspace*{0.3cm}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Question group %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\questiongroup}[1]{
	\stepcounter{groupCounter}
	{\textbf{Grupo \Roman{groupCounter}}} \hfill \fbox{\textit{#1}}\\
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% True question %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\truequestion}[2]{
  \begin{question}{#1}\scoring{\truefalseScore}
    \AMCBoxOnly{ordered=true}{\correctchoice[V]{v}\wrongchoice[F]{f}}
    \par
    #2
  \end{question}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% False question %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\falsequestion}[2]{
  \begin{question}{#1}\scoring{\truefalseScore}
    \AMCBoxOnly{ordered=true}{\wrongchoice[V]{v}\correctchoice[F]{f}}
    \par
    #2
  \end{question}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multiple answers question %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\multiple}[3]{
  \begin{questionmult}{#1}\scoring{\multipleScore}
    #2
    \begin{choices}
      #3
    \end{choices}
  \end{questionmult}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Question item %%%%%%%
%%%%%%% used for open %%%%%%% 
%%%%%% answer questions %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\qitem}{
  \stepcounter{QItemCounter}
  ~\\{\bf \alph{QItemCounter})}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Open answer question %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\open}[2]{
  \begin{question}{#1}
    #2
    \AMCOpen{lineup=true}{\scorebox}
  \end{question}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Open answer question %%%%
%%%% with question items %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\itemsopen}[3]{
  \setcounter{QItemCounter}{0}
  \begin{question}{#1}
    #2
    \AMCOpen{lineup=true}{\scorebox}
    #3
  \end{question}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Open answer question %%%%
%%%% with answer lines %%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\openLines}[3]{
  \begin{question}{#1}
    #3
    \AMCOpen{lines=#2,lineheight=.3cm}{\scorebox}
  \end{question}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Open answer question %%%%
%%%% with question items %%%%
%%%%% and answer lines %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\itemsopenLines}[4]{
  \setcounter{QItemCounter}{0}
  \begin{question}{#1}
    #3
    #4
    \AMCOpen{lines=#2,lineheight=.3cm}{\scorebox}
  \end{question}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Pool environment %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{pool}[1]{
  \renewcommand{\truequestion}[1]{
    \element{#1}{
      \stepcounter{poolQCounter}
      \begin{question}{#1-Q\arabic{poolQCounter}}\scoring{\truefalseScore}
        \AMCBoxOnly{ordered=true}{\correctchoice[V]{v}\wrongchoice[F]{f}}
        \par
        ##1
      \end{question}
    }       
  }

  \renewcommand{\falsequestion}[1]{
    \element{#1}{
      \stepcounter{poolQCounter}
      \begin{question}{#1-Q\arabic{poolQCounter}}\scoring{\truefalseScore}
        \AMCBoxOnly{ordered=true}{\wrongchoice[V]{v}\correctchoice[F]{f}}
        \par
        ##1
      \end{question}
    }       
  }

  \renewcommand{\multiple}[2]{
    \element{#1}{
      \stepcounter{poolQCounter}
      \begin{questionmult}{#1-Q\arabic{poolQCounter}}\scoring{\multipleScore}
        ##1
        \begin{choices}
          ##2
        \end{choices}
      \end{questionmult}
    }
  }

  \renewcommand{\open}[1]{
    \element{#1}{
      \stepcounter{poolQCounter}
      \begin{question}{#1-Q\arabic{poolQCounter}}
        ##1
        \AMCOpen{lineup=true}{\scorebox}
      \end{question}
    }
  }

  \renewcommand{\itemsopen}[2]{
    \element{#1}{
      \stepcounter{poolQCounter}
      \setcounter{QItemCounter}{0}
      \begin{question}{#1-Q\arabic{poolQCounter}}
        ##1
        \AMCOpen{lineup=true}{\scorebox}
        ##2
      \end{question}
    }
  }

  \renewcommand{\openLines}[2]{
    \element{#1}{
      \stepcounter{poolQCounter}
      \begin{question}{#1-Q\arabic{poolQCounter}}
        ##2
        \AMCOpen{lines=##1,lineheight=.3cm}{\scorebox}
      \end{question}
    }
  }

  \renewcommand{\itemsopenLines}[3]{
    \element{#1}{
      \stepcounter{poolQCounter}
      \setcounter{QItemCounter}{0}
      \begin{question}{#1-Q\arabic{poolQCounter}}
        ##2
        ##3
        \AMCOpen{lines=##1,lineheight=.3cm}{\scorebox}
      \end{question}
    }
  }

} { }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Insert pool command %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\insertpool}[2][-1]{
  \setcounter{poolQCounter}{0}
  \insertgroup[#1]{#2}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Clear pool command %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\clearpool}[1]{
  \cleargroup{#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Copy pool command %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\copypool}[3][-1]{
  \copygroup[#1]{#2}{#3}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Combinepool command %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Based on the article at: 
% https://davidyat.es/2016/07/27/writing-a-latex-macro-that-takes-a-variable-number-of-arguments/
% NOTE: We do not automatically insert the pool since different users may prefer to do it in different
% ways, like for example, in a multicol environment
\makeatletter
\newcommand{\combinepool}[1]{
  \clearpool{#1}
  \checknextarg{#1}
}
\newcommand{\checknextarg}[1]{\@ifnextchar\bgroup{\gobblenextarg{#1}}{  }}
\newcommand{\gobblenextarg}[2]{\copypool[1]{#2}{#1}\@ifnextchar\bgroup{\gobblenextarg{#1}}{  }}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Misc commands %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\groupintro}[1]{{\small\noindent\it #1}}
