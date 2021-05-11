setwd("C:/Users/pthunga/Documents/PhD/PFAS data/code")
rm(list = ls())
source('plotHist.r')
source('plotHistLegend.r')

# BMD functions
getBMD <- function(fit, bmr = 0.1, type = 'extra') {
  if ( is.null(fit) || bmr < 0 || bmr > 0.9 ) return(NULL)
  if ( type == 'extra' ) {
    lnBMD <- (log(bmr / (1 - bmr)) - fit$par[2]) / fit$par[3] # extra risk
  } else {
    lnBMD <- (log(bmr / (1 - fit$par[1] - bmr)) - fit$par[2]) / fit$par[3] # added risk
  }
  return(c('bmr' = bmr, 'bmd' = exp(lnBMD)))
}
getBoundedBMD <- function(fit, df, bmr = 0.1, type = 'extra', mag = 0) {
  bmd <- getBMD(fit, bmr, type)
  if ( is.null(bmd) || nrow(df) < 2 )                                       return(c(bmr,   NA))
  if ( bmd[2] < df$conc[2] / 10^mag || bmd[2] > tail(df$conc, 1) * 10^mag ) return(c(bmr,   NA))
  if ( bmd[2] < df$conc[2] )                                                return(c(bmr, -Inf))
  if ( bmd[2] > tail(df$conc, 1) )                                          return(c(bmr,  Inf))
  return(bmd)
}

# Load data
nrvs <- readRDS('save_pfas_subset.rds')
nrvs <- readRDS('C:/Users/pthunga/Documents/PhD/PFAS data/results/gui/zfishgui_v3_0_beta_20210319_yvonne.rds')



# Morphology histogram examples
plotHistLegend(nrvs$analysis$morph$range, twoSided = F)
plotHist(nrvs$analysis$morph$bmd, nrvs$analysis$morph$range)
plotHist(nrvs$analysis$morph$ed, nrvs$analysis$morph$range)
plotHist(nrvs$analysis$morph$lel, nrvs$analysis$morph$range)

# Behavior histogram examples
fileID <- names(nrvs$fileSelect$behav)[1]
plotHistLegend(nrvs$analysis$behav[[fileID]]$computation$range)
plotHist(nrvs$analysis$behav[[fileID]]$computation$lelConc,
         nrvs$analysis$behav[[fileID]]$computation$range,
         type = nrvs$analysis$behav[[fileID]]$computation$lelType)


# Morphology ECx examples
bdr <- nrvs$analysis$morph$bdrs[[1]][[14]] # [[group]][[endpoint]]
bmr <- 0.8 # EC80
getBMD(bdr$fit, bmr)
getBoundedBMD(bdr$fit, bdr$df, bmr) # BMD value must be within certain range of tested concentrations
bmr <- 0.5 # EC50
getBMD(bdr$fit, bmr)
getBoundedBMD(bdr$fit, bdr$df, bmr)

