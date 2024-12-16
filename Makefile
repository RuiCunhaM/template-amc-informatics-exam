MAIN=main

all:
	lualatex -shell-escape $(MAIN).tex

v:
	zathura $(MAIN).pdf &	

clean:
	rm *.amc *.aux *.log $(MAIN).pdf
