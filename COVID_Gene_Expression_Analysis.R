library(data.table)
library(dplyr)
library(DESeq2)

# CHANGE THIS FOR YOUR LOCAL VERSION
file_path <- '/Users/administrator/Documents/Classes/Introduction_to_Computational_Systems_Biology/COVID_Gene_Expression_Analysis/expression_data.tsv'

genes = row.names(read.table(file_path, sep='\t', header = FALSE, row.names=1))

non_covid_patients <- c('NC4', 'NC5', 'NC9', 'NC11', 'NC21', 'NC22', 'NC23', 'NC24', 'NC25')
covid_icu_patients <- c('C8', 'C9', 'C10', 'C12', 'C14', 'C15', 'C20', 'C21', 'C22', 'C23', 'C24', 'C25', 'C26', 'C27', 'C28', 'C29', 'C30', 'C31', 'C32', 'C38', 'C39', 'C40', 'C41', 'C42', 'C43', 'C44', 'C45', 'C46', 'C47', 'C48', 'C49', 'C50', 'C55', 'C62', 'C63', 'C64', 'C67', 'C68', 'C71', 'C74', 'C76', 'C77', 'C80', 'C85', 'C87', 'C92', 'C93', 'C97', 'C99', 'C101')
all_patients = c(as.character(covid_icu_patients), as.character(non_covid_patients))

expression_data = fread(file_path, sep='\t', header = TRUE, data.table = FALSE, select = all_patients)
# TODO: Round data to integer?
expression_data <- mutate_all(expression_data, function(x) as.integer(as.character(x)))
row.names(expression_data) <- genes
condition <- c('Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid',
               'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid',
               'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid' ,
               'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid' ,
               'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid', 'Covid' ,
               'Control', 'Control', 'Control', 'Control', 'Control', 'Control', 'Control', 'Control', 'Control')  #vector of column names for the data frame
colData <- data.frame(row.names=all_patients, condition=factor(condition, levels=c('Control','Covid')))

dataset <- DESeqDataSetFromMatrix(countData = expression_data,
                                  colData = colData,
                                  design = ~condition)
dds <- DESeq(dataset)
result <- results(dds, contrast=c('condition','Covid','Control'))
result <- result[complete.cases(result),] 

target_genes = c('NUP98', 'RAE1', 'FN1', 'AHCTF1', 'NUP35', 'NUP160', 'NUP37', 'SEH1L')
target_result = result[target_genes,]


