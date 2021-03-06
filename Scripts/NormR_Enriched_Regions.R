library("normr")
countConfigSE <- countConfigSingleEnd(binsize = snakemake@params[["binsize"]], shift = 100)
genome <- read.table(snakemake@input[["lengths"]])
fit <- enrichR(treatment = snakemake@input[["treatment"]], control = snakemake@input[["control"]], genome = genome, verbose=FALSE, countConfig=countConfigSE)
summary(fit)
exportR(fit, filename=snakemake@output[["regions"]], type="bed", fdr=snakemake@params[["fdr"]])
