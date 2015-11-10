@echo off
set F=Praesentation
set TEX=pdflatex -quiet
set BIBTEX=bibtex %F% -quiet
set BUILDTEX=%TEX% -synctex=1 -interaction=nonstopmode %F%.tex
set INDEX=makeindex %F%.idx

goto clean-all
goto all
goto clean

:clean-all
	echo - removing old files
	del /s /f *.ps *.dvi *.aux *.toc *.idx *.ind *.ilg *.log *.out *.brf *.blg *.bbl *.lof *.lol *.lot *.gz %F%.pdf  *eps-converted-to.pdf

:all
	echo - pdflatex plods...
    	%BUILDTEX%
	echo - pdflatex plods...					
	%BUILDTEX%
	echo - bibtex plods...	
	%BIBTEX%
	echo - bibtex plods...	
	%BIBTEX%
	echo - makeindex plods...
	%INDEX%
    echo - pdflatex plods... 
	%BUILDTEX%
    echo - pdflatex plods... 
	%BUILDTEX%

:clean
	echo - removing temp files
    del /s /f *.ps *.dvi *.aux *.toc *.idx *.ind *.ilg *.log *.out *.brf *.blg *.bbl *.lof *.lol *.lot *.gz *eps-converted-to.pdf
:check	
	set /p o=Open PDF? [yn]
	if "%o%"=="n" goto END
	if "%o%"=="y" goto OPEN
:OPEN
	start %F%.pdf
:END