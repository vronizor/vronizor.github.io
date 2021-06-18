---
layout: post
title: Minimal LaTeX start-up document
author: Vincent Thorne
---

A super minimal setup that will work for most LaTeX documents. Includes some examples on how to include figures and tables.

```latex
\documentclass[a4paper, 11pt]{article}
% Basic info about your document: a4 paper, 11pt font size, article style.
% Comments start with '%'.

\usepackage{graphicx} % Enables adding figures
\usepackage{subcaption} % Enables figures side-by-side
\usepackage{booktabs} % Makes nicer tables
\usepackage{geometry} % Let's you adjust the margins
\usepackage{setspace} % Let's you change the line spacing
\usepackage{hyperref} % Let's you add links (\url{<link>}) and clickable labels to naviguate through the document
\usepackage{microtype} % Improves the typesetting of your document by managing better the space between letters, hyphens etc.

\usepackage[T1]{fontenc} % Font encoding, don't worry about this too much.

\graphicspath{
	{the/path/where/tables/and/graphs/are}
	{another/folder/with/stuff}
}
% Tells LaTeX where all graphs and tables are so you don't need to
% write the full path when you want to integrate them.

%-------Info---------
\title{The Title}

\date{Month Year}
\author{Author}

%-------Content--------
\begin{document}
	
	
	\maketitle % Prints whatever is in the info

  \onehalfspacing % Sets line spacing to 1.5 after the title for the rest of the document

	\section{First section}
	
	Some content. Super to be here, thanks for inviting me.

	\section{Figures}
	
	This section is about figures.

	A figure:

	\begin{figure}
		\centering % makes sure it is centered
			\includegraphics[width=.6\textwidth]{a_figure.png} % notice the width adjustment
		\caption{A great figure}
	\end{figure}

	Two figures side-by-side: 
	\begin{figure}
			\centering
			\begin{subfigure}{.49\textwidth}
				\includegraphics[width=\textwidth]{first_file.png}
				\caption{First caption}
			\end{subfigure}
			~
			\begin{subfigure}{.49\textwidth}
				\includegraphics[width=\textwidth]{second_file.png}
				\caption{Second caption}
			\end{subfigure}
		\caption{General caption} % the caption for both
	\end{figure}

	\section{Tables}

	Directly in the document:
	
	\begin{table}[]
		\begin{tabular}{@{}lll@{}}
			\toprule
			Observations & $\alpha$ & $\beta$ \\ \midrule
			John         & 0.62     & 4.5     \\
			Mark         & 0.21     & 3.6     \\
			Paul         & 0.80     & 7.6     \\ \bottomrule
		\end{tabular}
	\end{table}

	Stored in another file (cleaner: the code doesn't clutter the content):

	{\small \input{path/to/a/table.tex}}
	% the \small command prints everything smaller between the outter {}
	
	% In fact, you can use \input to add any bit of LaTeX in another LaTeX file!
	% Pretty useful for big documents: you'll have a "master" that loads
	% all the packages and individual section files on one hand, and one 
	% LaTeX file per section (for example) that let's you focus on the content.

\end{document} % Don't forget this last one.
```