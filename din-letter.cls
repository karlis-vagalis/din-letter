\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{din-letter}[2022/09/28 DIN 5008 style letter]

\RequirePackage{tikz}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

\newcounter{adrtype}
\newcounter{datetype}
\newcounter{pagenumtype}
\newcounter{footertype}
\newcounter{justificationtype}

\setcounter{adrtype}{1} %0 for center, 1 for offset with return, 2 for offset without return
\setcounter{datetype}{0}
\setcounter{pagenumtype}{1}
\setcounter{footertype}{1}
\setcounter{justificationtype}{0}

\RequirePackage{xcolor}
\definecolor{mycolor2}{HTML}{ffd100} %TO LABEL

\def\addressfrom#1{\def\@addressfrom{#1}}
\def\addressto#1{\def\@addressto{#1}}
\def\addressreturn#1{\def\@addressreturn{#1}}
\def\place#1{\def\@place{#1}}
\def\date#1{\def\@date{#1}}

\addressfrom{
Erika Mustermann\\
Musterstraße 2\\
00000 Musterstadt
}
\addressto{
Max Mustermann\\
Musterstraße 1\\
00000 Musterstadt
}
\addressreturn{}
\place{Musterstadt}
\date{\today}

\newcommand{\formalletterdetails}{%
Ihr Zeichen: abc123\\
Ihre Nachricht vom: 2021-07-01\\
Unser Zeichen: abc123\\
Unsere Nachricht vom: 2021-06-24\\\\
Name: \myfirstname{} \mylastname{}\\
Telefon: \myphonenumber{}\\
E-Mail: \myemail{}\\\\
Datum: \today%
}%

\newcommand{\footer}{Test footer}

% Set letter type
\newcounter{lettertype}
\DeclareOption{A}{\setcounter{lettertype}{0}}
\DeclareOption{B}{\setcounter{lettertype}{1}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[a4paper]{article}

\RequirePackage{fontspec}

\DeclareOption{bahnschrift}{
	\newcommand{\fontnormalweight}{320}
	\newcommand{\fontboldweight}{650}
	\newcommand{\fontitalicslant}{0.2}
	\setmainfont[Ligatures=TeX,
		    	UprightFont =*,
		       	UprightFeatures={RawFeature={+axis={wght=\fontnormalweight}}},
		    	ItalicFont=*,
		    	ItalicFeatures={FakeSlant=\fontitalicslant, RawFeature={+axis={wght=\fontnormalweight}}},
		    	BoldFont=*,
		    	BoldFeatures={RawFeature={+axis={wght=\fontboldweight}}},
		    	BoldItalicFont=*,
		    	BoldItalicFeatures={RawFeature={+axis={wght=\fontboldweight}}, FakeSlant=\fontitalicslant},
	]{Bahnschrift}
}
\ProcessOptions\relax

\RequirePackage[a4paper,
				left=2.5cm,
				right=2cm,
				top=2cm,
				bottom=2.2cm,
				footskip=1cm,
                showframe,
				]{geometry}
\RequirePackage
%[grid,gridunit=mm,gridcolor=black!30,subgridcolor=gray!10]
{eso-pic}
\RequirePackage{datetime2}

\AddToShipoutPictureBG{
    \ifnum\value{lettertype}=0{
        %TYPE A
    	{%
    	\multiput %UPPER
    	(5mm,\LenToUnit{210mm})				%X,Y Coord
    	(2mm,0)									%Delta X, Delta Y
    	{1}										%number of copies
    	{\line(1,0){\LenToUnit{5mm}}}			%object
    	\multiput %LOWER
    	(5mm,\LenToUnit{105mm})
    	(2mm,0)
    	{1}
    	{\line(1,0){\LenToUnit{5mm}}}
        }
    } \else {
        %TYPE B
    	{%
    	\multiput %OBERE FALZMARKE, TYP B
    	(5mm,\LenToUnit{192mm})				%X,Y Coord
    	(2mm,0)									%Delta X, Delta Y
    	{1}										%number of copies
    	{\line(1,0){\LenToUnit{5mm}}}			%object
    	\multiput %UNTERE FALZMARKE, TYP B
    	(5mm,\LenToUnit{87mm})
    	(2mm,0)
    	{1}
    	{\line(1,0){\LenToUnit{5mm}}}
        }
    }
    \fi


    	\multiput	%LOCHMARKE
    	(5mm,\LenToUnit{\paperheight/2})
    	(2mm,0)
    	{1}
    	{\line(1,0){\LenToUnit{7.5mm}}}
}

\renewcommand{\maketitle}{
    \newgeometry{left=2.5cm,right=2cm,top=10cm,bottom=2.2cm,footskip=1cm,} 
    \begin{tikzpicture}[remember picture, overlay]

	%---FROM
	\node[anchor = north east,
	inner xsep = 0.0mm,
	inner ysep = 0.0mm,
	align = right]
	at ([yshift = -20mm, xshift = -20mm]current page.north east) {\@addressfrom}
	{};
	
	%---TO			
	\ifnum\value{adrtype}=0{%
		\node[draw, rectangle,
		anchor = north west,
		inner xsep = 0mm,
		align = left]
		at ([yshift = -62.7mm, xshift = 25mm]current page.north west) {\@addressto}
		{};
		{\fontsize{6pt}{8pt}\selectfont
			\node[draw,
			anchor=south west,
			%outer ysep = -62.7mm,
			%outer xsep = 25mm,
			inner xsep = 0mm,
			%inner ysep = 3pt,
			align=left] (RetAdr)
			at ([yshift = -62.7mm, xshift = 25mm]current page.north west)
            {\@addressreturn}
			{};}
	} \else {
		\ifnum\value{adrtype}=1 {%
			{\fontsize{6pt}{8pt}\selectfont
			\node[
			anchor=south west,
			%outer ysep = -62.7mm,
			%outer xsep = 25mm,
			inner xsep = 5mm,
			%inner ysep = 3pt,
			align=left] (RetAdr)
			at ([yshift = -62.7mm, xshift = 25mm]current page.north west)
            {\@addressreturn}
			{};}
		} \else {} \fi
	\node[
	anchor = north west,
	%outer ysep = 62.7mm,
	%outer xsep = 25mm,
	inner xsep = 5mm,
	align=left] (ToAdr)
	at ([yshift = -62.7mm, xshift = 25mm]current page.north west) {\@addressto}
	{};
	}
	
	\ifnum\value{adrtype}=2 {
		\pgfpointdiff{\pgfpointanchor{ToAdr}{south east}}{\pgfpointanchor{ToAdr}{north east}}
	} \else {
		\pgfpointdiff{\pgfpointanchor{ToAdr}{south east}}{\pgfpointanchor{RetAdr}{north east}}
	}
	\fi
	\pgfmathsetmacro\mytemptikz{\csname pgf@y\endcsname}
         
	\node[rectangle, opacity=1.0, anchor=south west, inner sep = 0mm, outer ysep = 0mm, outer xsep = 0.0cm,  left color = mycolor2, right color = mycolor2, minimum width = 2.5mm, minimum height = \mytemptikz+3pt] at (ToAdr.south west) {};
	%\node[rectangle, opacity=1.0, anchor=north east, outer ysep = 45mm, outer xsep = -2.0cm,  left color = mycolor2, right color = mycolor2, minimum width = 1.5cm, minimum height = 45mm] at (current page.north west) {};
	
	\fi
	
	%---DATE
	\ifnum\value{datetype}=0{%
	\node[%draw,
	anchor = north east,
	inner xsep = 0mm,
	align = right]
	at ([yshift = -90mm, xshift = -20mm]current page.north east)
    {\@place, \@date}
	{};
	} \else {			
	\node[anchor=north west,outer ysep = 50mm,outer xsep = -85mm, inner xsep = 0mm,align = left] at (current page.north east) {\formalletterdetails{}};
	}
	\fi
    \end{tikzpicture}%
    \restoregeometry
}


\setlength{\parindent}{0em}
\renewcommand{\headrulewidth}{0mm}
\pagestyle{fancy}
\fancyfoot{}
\fancyfoot[R]{\ifnum\value{pagenumtype}=0{}\else{Seite \thepage \hspace{1pt} von \pageref{LastPage}}\fi}

\fancypagestyle{letcust}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}\fancyfoot[R]{\ifnum\value{pagenumtype}=0{}\else{Seite \thepage \hspace{1pt} von \pageref{LastPage}}\fi}\fancyfoot[L]{\ifnum\value{footertype}=0{}\else{\setfooter}\fi}}
