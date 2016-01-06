\name{adapt.select}
\alias{adapt.select}
\title{
Function to select fragments according to the flanking restriction sites.
}
\description{
Given a vector of sequences representing DNA fragments digested by two restriction enzymes (RE1 and RE2), the function will return fragments flanked by either the same restriction size (E1-E1 fragments typically for RESTseq method) or different restriction sites (RE1 and RE2, for ezRAD and ddRAD methods).
}
\usage{
adapt.select(sequences, type = "AB+BA", cut_site_5prime1, cut_site_3prime1, 
             cut_site_5prime2, cut_site_3prime2)
}
\arguments{
  \item{sequences}{
a vector of DNA sequences representing DNA fragments after digestion by two restriction enzymes, typically the output of the \code{\link{insilico.digest}} function.
}
  \item{type}{
type of fragments to return. Options are "AA": fragments flanked by two restriction enzymes 1 sites, "AB+BA": the default, fragments flanked by two different restriction enzyme sites, "BB": fragments flanked by two restriction enzymes 2 sites. For flexibility, "AB" and "BA" options are also available and will return directional digested fragments but such fragments are of no use in current GBS methods as yet. 
}
  \item{cut_site_5prime1}{
5 prime side (left side) of the recognized restriction site of the restriction enzyme 1. 
}
  \item{cut_site_3prime1}{
3 prime side (right side) of the recognized restriction site of the restriction enzyme 1. 
}
  \item{cut_site_5prime2}{
5 prime side (left side) of the recognized restriction site of the restriction enzyme 2. 
}
  \item{cut_site_3prime2}{
3 prime side (right side) of the recognized restriction site of the restriction enzyme 2. 
}
}
\details{
This function will be generally needed when simulating double digest ddRAD methods where fragments flanked by two different restriction site are selected during library construction (type="AB+BA"). \cr\cr In addition, when simulating RESTseq method, type = "AA" can be used to exclude fragments that contained the restriction site of enzyme 2, as an alternative or in complement to subsequent DNA fragment exclusion by additional restriction site (see function \code{\link{exclude.seqsite}}). 
}
\value{
A vector of DNA fragment sequences.
}
\references{
Lepais O & Weir JT. 2014. SimRAD: an R package for simulation-based prediction of the number of loci expected in RADseq and similar genotyping by sequencing approaches. Molecular Ecology Resources, 14, 1314-1321. DOI: 10.1111/1755-0998.12273.\cr\cr
Peterson et al. 2012. Double Digest RADseq: an inexpensive method for de novo SNP discovery and genotyping in model and non-model species. PLoS ONE 7: e37135. doi:10.1371/journal.pone.0037135 \cr\cr
Stolle & Moritz 2013. RESTseq - Efficient benchtop population genomics with RESTriction fragment SEQuencing. PLoS ONE 8: e63960. doi:10.1371/journal.pone.0063960
}
\author{
Olivier Lepais
}
\seealso{\code{\link{insilico.digest}}, \code{\link{exclude.seqsite}}, \code{\link{size.select}}.}
\examples{
# simulating some sequence:
simseq <-  sim.DNAseq(size=10000, GCfreq=0.433)

#Restriction Enzyme 1
#PstI
cs_5p1 <- "CTGCA"
cs_3p1 <- "G"

#Restriction Enzyme 2
#MseI
cs_5p2 <- "T"
cs_3p2 <- "TAA"

# double digestion:
simseq.dig <- insilico.digest(simseq, cs_5p1, cs_3p1, cs_5p2, cs_3p2, verbose=TRUE)
#selection of AB type fragments
simseq.selected <- adapt.select(simseq.dig, type="AB+BA", cs_5p1, cs_3p1, cs_5p2, cs_3p2)
# number of selected fragments:
length(simseq.selected)

}

\keyword{ double digestion }
\keyword{ restriction enzyme }
\keyword{ library construction }
\keyword{ adaptator ligation }
\keyword{ fragment selection }
\keyword{ ddRAD }
\keyword{ RESTseq }