.PHONY: all clean scratch

all:
	make index.html

data/clean/titanic_clean.csv: 01-load_clean.py data/original/titanic.csv
	python 01-load_clean.py --file_path=data/original/titanic.csv --output_path=data/clean/titanic_clean.csv

index.html: report.qmd output/coefficients.csv output/fig.png
	quarto render report.qmd --output index.html

output/coefficients.csv output/fig.png: 04-analyze.py output/model.joblib
	python 04-analyze.py --model=output/model.joblib --output_coef=output/coefficients.csv --output_fig=output/coef_plot.png

output/model.joblib: 03-model.py data/clean/titanic_clean.csv
	python 03-model.py --file_path=data/clean/titanic_clean.csv --output_path=output/model.joblib

output/titanic1.png: 02-eda.py data/clean/titanic_clean.csv
	python 02-eda.py --input_path=data/clean/titanic_clean.csv --output_path=output/titanic1.png


clean:
	rm -f output/*
	rm -f data/clean/*
	rm -f report.html
	rm -f index.html
	rm -f *.pdf

scratch:
	make clean
	python 01-load_clean.py --file_path=data/original/titanic.csv --output_path=data/clean/titanic_clean.csv
	python 02-eda.py --input_path=data/clean/titanic_clean.csv --output_path=output/titanic1.png
	python 03-model.py --file_path=data/clean/titanic_clean.csv --output_path=output/model.joblib
	python 04-analyze.py --model=output/model.joblib --output_coef=output/coefficients.csv --output_fig=output/coef_plot.png
	quarto render report.qmd --output index.html
