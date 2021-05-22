\def\lxdef{\long\xdef}

% This class name
\def\@classname {thesis}



% METADATA AND OPTIONS
% --------------------

% Define thesis template version and other metadata
\gdef\@templateVersion{1}
\gdef\@templateDate{21-05-2020}
\gdef\@templateAuthor{Ramachandra Bangari}

% It provides this class
\ProvidesClass{\@classname}[\@templateDate \@templateVersion \@templateAuthor]

% We need LaTeX2e at least
\NeedsTeXFormat{LaTeX2e}

% Article class
\LoadClass[12pt]{report}





% PACKAGES
% --------


% Packages
\RequirePackage{amsmath}
% --
\RequirePackage{ifthen}
\RequirePackage{xkeyval}
%\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[T1]{fontenc} % font types and character verification
\RequirePackage[UKenglish]{babel}
\RequirePackage[UKenglish]{isodate}
\RequirePackage[utf8]{inputenc}
\RequirePackage{xparse}
\RequirePackage{longtable}
\RequirePackage{blindtext}
\RequirePackage{parskip}
\RequirePackage{setspace}
\RequirePackage{geometry}
\RequirePackage{layout}
\RequirePackage{courier}
\RequirePackage{subcaption}
\RequirePackage{url}
\RequirePackage{hyperref}
\RequirePackage[table,figure]{totalcount}
\RequirePackage{appendix}
% -----------------
\RequirePackage{csquotes}
\RequirePackage{titlesec}
\RequirePackage{datetime2}
\RequirePackage{fancyhdr}
\RequirePackage{lmodern}




% FANCY DATE STUFF
% -----------------

\newcommand{\monthyeardate}{%
  \DTMenglishmonthname{\@dtm@month} \@dtm@year
}

\newcommand{\yeardate}{%
  \@dtm@year
}

% Another handy macro to test if there's an option
\def\ifClassOption [#1]#2 {
    \@ifclasswith{\@classname}{#1}{#2}{\empty}
}

% Another handy macro to test if there's an option + else
\def\ifClassOptionElse [#1]#2#3 {
    \@ifclasswith{\@classname}{#1}{#2}{#3}
}


% THESIS TEMPLATE VARIABLES
% -------------------------


% Define variables relevant to this thesis
\lxdef \@logo           {logo}
\newcommand{\thesisLogoPath}[1]{\xdef\@logo{#1}}
\lxdef \@date           {\monthyeardate}
\newcommand{\thesisSubmissionDate}[1]{\xdef\@date{#1}}
\lxdef \@degree         {Bachelor of Science (Research)}
\newcommand{\thesisDegree}[1]{\xdef\@degree{#1}}
\lxdef \@programme      {Physics}
\newcommand{\thesisProgramme}[1]{\xdef\@programme{#1}}
\lxdef \@schoolname     {Undergraduate}
\newcommand{\thesisSchool}[1]{\xdef\@schoolname{#1}}
\lxdef \@collegename    {Department Of Instrumentation and Applied Physics}
\newcommand{\thesisCollege}[1]{\xdef\@collegename{#1}}
\lxdef \@universityname {Indian Institute of Science}
\newcommand{\thesisUniversity}[1]{\xdef\@universityname{#1}}
% -----
\newcommand{\thesisSupervisor}[1]{\xdef\@supervisor{#1}}
\newcommand{\thesisSecondSupervisor}[1]{\xdef\@secondsupervisor{#1}}
\newcommand{\thesisThirdSupervisor}[1]{\xdef\@thirdsupervisor{#1}}


% START OF THESIS
% --------------

\fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhf{}%
    \fancyfoot[R]{\footnotesize\textbf{\thepage}}%    
}

\fancypagestyle{mainStyle}{
	\renewcommand{\headrulewidth}{0pt}%
	\fancyhf{}%
	\fancyfoot[R]{\footnotesize\emph{\leftmark} \hspace{0.25cm} \footnotesize\textbf{\thepage}}%   
	
	\@ifundefined{@includeheaders}{
	
	}{
    	\fancyhead[R]{\textit{\footnotesize \@modulecode~\@modulename}}
    	\fancyfoot[L]{\footnotesize \@author \hspace{0.5cm} \@studentnumber}
	}
}


\newcommand{\thesisBodyStart}{

    % Clear the page so we don't number the last page
    \cleardoublepage
    
    % Set page numbering back to 1, 2, 3 .. 
    \pagenumbering{arabic} 
}



% TABLE OF CONTENTS, FIGURES AND TABLES
% ---------------------------

\newcommand{\thesisTOF}{
    \iftotalfigures
        \cleardoublepage
        \listoffigures
    \fi
}

\newcommand{\thesisTOT}{
    \iftotaltables
        \cleardoublepage
        \listoftables
    \fi
}

\newcommand{\thesisTables}{
    \cleardoublepage
    \renewcommand{\contentsname}{Contents}
    \setcounter{tocdepth}{3}
    {\setstretch{1.25}
        \tableofcontents
        \thesisTOF
        \thesisTOT
    }
    
    \setlength{\abovedisplayskip}{1pt}
    \setlength{\belowdisplayskip}{15pt}
}



% ABSTRACT
% -------------------------

\renewenvironment{abstract}
    {\cleardoublepage
     \chapter*{\abstractname}
    }
    {}




% ACKNOWLEDGEMENTS
% ----------------

\newenvironment{acknowledgements}
    {\cleardoublepage
     \chapter*{Acknowledgements}
    }
    {}




% AFTER TITLE PAGE BUT BEFORE THESIS CONTENT
% ------------------------------------------
\newcommand{\afterTitlePage}{
    
    \setlength{\parindent}{4em}
    \setlength{\parskip}{1em}
    % Set margins for the rest of the thesis. UoL guidelines 
    % state that: [left >= 40mm], [others >= 15mm]
    \newgeometry{
        nohead, 
        top=15mm,
        bottom=25mm,
        right=30mm,
        left=30mm,
        marginparwidth=0cm,
        marginparsep=0cm
    }

    % Set spacing and reset numbering
    \pagenumbering{roman}
            
    % Set double spacing (from cleanthesis.sty)
    \setstretch{1.5}
    \clubpenalty = 10000
    \widowpenalty = 10000
    \displaywidowpenalty = 10000
}









% TITLE PAGE
% -------------


% Print out submission text
\newcommand{\submissionStatement}{
    \setstretch{1.25}
    \@ifundefined{@submissiontext}{Submitted in partial satisfaction of the requirements for the \\Degree of \@degree \\ in \@programme}{\@submissiontext}
}

% Print out supervisors
\newcommand{\printSupervisor}{
    %{\footnotesize \textit{Supervisor}~\@supervisor }
    %\@ifundefined{@secondsupervisor}{}
    %{\footnotesize \textit{Second Supervisor}~\@secondsupervisor }
    
    \footnotesize\begin{tabular}{rl}
        \@ifundefined{@supervisor}{}
        {\textit{Supervisor} & \@supervisor \\}
        
        \@ifundefined{@secondsupervisor}{}
        {\textit{Second Supervisor} & \@secondsupervisor \\}
        
        \@ifundefined{@thirdsupervisor}{}
        {\textit{Third Supervisor} & \@thirdsupervisor }
    \end{tabular}
}

% The default title page: title, then logo, then author
\newcommand{\@titlepage}{
    \begin{titlepage}

    % Make the title
    \makeatletter
    \centering{\LARGE \@title \par} \vspace{1.5cm}
    
    % Make the logo
    \includegraphics[height=1.5in]{\@logo}\par 
    
    % Some space, then the author, then the school and university
    % name
    \vspace{1.5cm}
    {\large \@author \@ifundefined{@studentnumber}{}{\\ \@studentnumber} \par}\vspace{0.45cm}
    {\footnotesize \@schoolname \\ \vspace{0.25cm} \@collegename \\  \vspace{0.25cm}  \@universityname \par}
    
    % Some space and the submission statement
    \vspace{2.5cm}
    {\footnotesize \submissionStatement \par}
    
    % Print out the supervisor
    \vspace{1cm}
    \printSupervisor
    
    % Then the fancy date!
    \vspace{1cm}
    {\footnotesize \@ifundefined{@modulecode}{}{\@modulecode \\} \@date \par}
    
	\end{titlepage}
}

\newcommand{\beforeTitlePage}{
    % Set margins for the rest of the thesis. UoL guidelines 
    % state that: [left >= 40mm], [others > 15mm]
    \newgeometry{
        nohead, 
        top=40mm,
        bottom=25mm,
        right=30mm,
        left=40mm,
        marginparwidth=0cm,
        marginparsep=0cm
    }
}


% The default title page style is the title, logo, author style
\def \@defaultTitlePage {\@titlepage}


% Lets renew the make title command so we don't have to 
% make a custom one
\RenewDocumentCommand{\maketitle}{o}{%

  % Call function for before title page
  \beforeTitlePage
  
  % Then check which title page style to use
  \IfNoValueTF{#1}
    {\@defaultTitlePage}
    {\ifthenelse{\equal{#1}{logo-first}}
        {\@altTitlePage}
        {\@defaultTitlePage}}
    
  % Call function for after title page       
  \afterTitlePage
}






% TITLE / CHAPTERS / FIGURES / TITLESEC SPACING
% ---------------------------------------------

% Set the chapter title style
\titleformat{\chapter}[display]
{\normalfont\huge\bfseries}{\chaptertitlename\ \thechapter}{0pt}{\Huge}

% And space it out a bit
\titlespacing*{\chapter} {0pt}{0pt}{20mm}

% A fake chapter title command to emulate chapter titles
% without actually adding a chapter
\newcommand{\chapterTitle}[1]{
	\vspace*{-20mm} 
	{\normalfont\huge\bfseries#1 \par} 
	\vspace*{20mm}
}








% REFERENCING
% -----------

% Fake harvard referencing, instead of using natbib -- because
% natbib makes biblatex blow up.
\def\@importHarvard {
    \RequirePackage[
        defernumbers=true,
        backend=biber,
        bibencoding=utf8,
        natbib=true,
        hyperref=true,
        backref=true,
        urldate=long,
        style=authoryear,
        citestyle=authoryear,
        sorting=nyt
    ]{biblatex}
}

% Otherwise use ieee's style and numeric citation
\def\@importBibLaTeX {
    \RequirePackage[
        defernumbers=true,
        backend=biber,
        bibencoding=utf8,
        natbib=true,
        hyperref=true,
        backref=true,
        urldate=long,
        style=ieee,
        citestyle=numeric,
        sorting=nyt
    ]{biblatex}
}

% Import harvard if [harvard] is specified, otherwise
% standard biblatex!
\ifClassOptionElse[harvard]{\@importHarvard}{\@importBibLaTeX}


% BLANK PAGE / QUOTE PAGE
% -----------------------

% For quote pages, copyright notices, or whatever else
\newenvironment{blankpage}[1][\unskip]{%
	
	% Check if [c] is specified, if so, then 
	% make it vertically align.. if not, then
	% just clear a double page and write some stuff
    \ifthenelse{\equal{#1}{c}}{
        \cleardoublepage
        \topskip0pt
        \vspace*{\fill}
    }{
    \cleardoublepage
    \topskip0pt
    \vspace*{1in}
    }
}{
        \vspace*{\fill}
}


% Set the page style to the main style. Set up the chapter
% mark style so that it shows the title of the chapter only.
\pagestyle{mainStyle}
\renewcommand{\chaptermark}[1]{\markboth{{#1}}{}}