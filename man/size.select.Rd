\name{size.select}
\alias{size.select}
\title{
Function to select fragments according to their size.
}
\description{
Given a vector of sequences representing DNA fragments digested by one or several restriction enzymes, the function will return fragments within a specified size range which will simulate the size selection step typical of ddRAD, RESTseq and ezRAD methods.
}
\usage{
size.select(sequences, min.size, max.size, graph = TRUE, verbose = TRUE)
}
\arguments{
  \item{sequences}{
a vector of DNA sequences representing DNA fragments after digestion, typically the output of the \code{\link{insilico.digest}} or \code{\link{adapt.select}} functions.
}
  \item{min.size}{
minimum fragment size.
}
  \item{max.size}{
maximum fragment size.
}
  \item{graph}{
if TRUE (the default) the function returns a histogram of distribution of fragment size (in grey) and selected fragments within the specified size range (in red). This may be useful to further adjust the selected size windows to increase or decrease the targeted number of loci. If FALSE, the histogram is not plotted.
}
  \item{verbose}{
if TRUE (the default) the function returns the number of loci selected. If FALSE, the function is silent.
}
}
\details{
Size selection is usually performed after adaptator ligation in real life, but as adaptators are not simulated here (because they are specific to the sequencing platform and the protocol used) the user should remember to account for the adaptator length when comparing size selection in the lab and in silico. For instance, size selection of 210-260 in silico correspond to size selection of 300-350 in the lab for adaptators total length of 90bp.
}
\value{
A vector of DNA fragment sequences.
}
\references{
Peterson et al. 2012. Double Digest RADseq: an inexpensive method for de novo SNP discovery and genotyping in model and non-model species. PLoS ONE 7: e37135. doi:10.1371/journal.pone.0037135 \cr\cr
Stolle & Moritz 2013. RESTseq - Efficient benchtop population genomics with RESTriction fragment SEQuencing. PLoS ONE 8: e63960. doi:10.1371/journal.pone.0063960 \cr\cr
Toonen et al. 2013. ezRAD: a simplified method for genomic genotyping in non-model organisms. PeerJ 1:e203 http://dx.doi.org/10.7717/peerj.203
}
\author{
Olivier Lepais
}
\seealso{\code{\link{adapt.select}}, \code{\link{exclude.seqsite}}.}
\examples{
### Example: a double digestion (ddRAD)
# simulating some sequence:
simseq <-  sim.DNAseq(size=1000000, GCfreq=0.433)

#Restriction Enzyme 1
#TaqI
cs_5p1 <- "T"
cs_3p1 <- "CGA"
#Restriction Enzyme 2
#MseI #
cs_5p2 <- "T"
cs_3p2 <- "TAA"

simseq.dig <- insilico.digest(simseq, cs_5p1, cs_3p1, cs_5p2, cs_3p2, verbose=TRUE)
simseq.sel <- adapt.select(simseq.dig, type="AB+BA", cs_5p1, cs_3p1, cs_5p2, cs_3p2)

# wide size selection (200-270):
wid.simseq <- size.select(simseq.sel,  min.size = 200, max.size = 270, graph=TRUE, verbose=TRUE)

# narrow size selection (210-260):
nar.simseq <- size.select(simseq.sel,  min.size = 210, max.size = 260, graph=TRUE, verbose=TRUE)

#the resulting fragment characteristics can be further examined:
boxplot(list(width(simseq.sel), width(wid.simseq), width(nar.simseq)), names=c("All fragments",
        "Wide size selection", "Narrow size selection"), ylab="Locus size (bp)")



}

\keyword{ double digestion }
\keyword{ restriction enzyme }
\keyword{ library construction }
\keyword{ adaptator ligation }
\keyword{ fragment selection }
\keyword{ restriction exclusion }
\keyword{ RESTseq }
\keyword{ RAD }
\keyword{ GBS }
\keyword{ ddRAD }
\keyword{ ezRAD }