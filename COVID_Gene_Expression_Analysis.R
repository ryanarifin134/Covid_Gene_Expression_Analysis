library(readr)

file_path <- "/Users/administrator/Documents/Classes/Introduction_to_Computational_Systems_Biology/COVID_Gene_Expression_Analysis/expression_data.tsv"

non_covid_non_icu_samples <- c('NC4', 'NC5', 'NC9', 'NC11', 'NC21', 'NC22', 'NC23', 'NC24', 'NC25')
expression_data = read_tsv(file_path, col_types = cols_only(col_factor(non_covid_non_icu_samples)))

print("a")

