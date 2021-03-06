% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ana_r.R
\name{ana_r_ghm_ambu_dms}
\alias{ana_r_ghm_ambu_dms}
\title{~ ANA - Analyse des taux ambulatoires et DMS sur un périmètre GHM à définir}
\usage{
ana_r_ghm_ambu_dms(p, periode = list(an = 2018, moi = 12), requete)
}
\arguments{
\item{p}{Noyau de paramètres}

\item{periode}{paramètres année et mois de l'envoi}

\item{requete}{liste de requêtes à définir (nomensland)}
}
\value{
Taux ambulatoire et DMS > 0 nuit par finess géographique, au globa, par racine et par DA
}
\description{
~ ANA - Analyse des taux ambulatoires et DMS sur un périmètre GHM à définir
}
\examples{
\dontrun{

library(dplyr, warn.conflicts = FALSE)
library(pmeasyr)

p <- noyau_pmeasyr(finess = '290000017',
                   annee  = 2018,
                   mois   = 12,
                   path   = '~/Documents/data/mco', 
                   tolower_names = TRUE,
                   n_max = Inf)


library(nomensland)

ghmc_7r <- get_liste('chir_ambu_ghm_C_7_racines')

periodes <- list(
  list(an = 2013, moi = 12),
  list(an = 2014, moi = 12),
  list(an = 2015, moi = 12),
  list(an = 2016, moi = 12),
  list(an = 2017, moi = 12),
  list(an = 2018, moi = 12),
  list(an = 2019, moi = 11))

result <- periodes \%>\% purrr::map_dfr(ana_r_ghm_ambu_dms, p = p, requete = ghmc_7r)
result <- result \%>\% arrange(niveau, Requete, `Période`)


pivot_result <- result \%>\% 
  select(niveau, Requete, nofiness, taux_ambu, `Nb total`, `Période`) \%>\% 
  mutate(stat = paste0(scales::percent(taux_ambu), ' (', `Nb total`, ')')) \%>\% 
  select(-taux_ambu, - `Nb total`) \%>\% 
  tidyr::spread(`Période`, stat, '')


ghmk <- list(nom = 'GHM K', rsatype = 'K', Thematique = 'GHM K', abrege = 'ghmk')

lancer_requete(rsa, ghmk)


}

}
