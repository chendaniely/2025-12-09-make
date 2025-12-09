data/clean/titanic_clean.csv: 01-load_clean.py data/original/titanic.csv
	python 01-load_clean.py --file_path=data/original/titanic.csv --output_path=data/clean/titanic_clean.csv

clean:
	rm -f output/*
	rm -f data/clean/*
	rm -f report.html
	rm -f index.html
	rm -f *.pdf
