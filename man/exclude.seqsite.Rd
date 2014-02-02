\name{exclude.seqsite}
\alias{exclude.seqsite}
\title{
Function to exclude fragments containing a specified restriction site.
}
\description{
Given a vector of sequences representing DNA fragments digested by restriction enzyme, the function return the DNA fragments that do not contain a specified restriction site, which is typically used to reduce the number of loci in the RESTseq method. The function can be use repeatedly for excluding fragments containing several restriction sites.
}
\usage{
exclude.seqsite(sequences, site, verbose=TRUE)
}
\arguments{
  \item{sequences}{
a vector of DNA sequences representing DNA fragments after digestion by restriction enzyme(s), typically the output of another function such as \code{\link{adapt.select}}, \code{\link{insilico.digest}} or \code{\link{exclude.seqsite}}.
}
  \item{site}{
restriction site to target DNA fragments to exclude. This typically corresponds to recognition site of a frequent cutter restriction enzyme.
}
 \item{verbose}{
If TRUE (the default), returns the number of fragments excluded and kept. FALSE makes the function silent to be used in a loop.
}
}
\details{
Frequent cutter restriction enzyme can be easily used to further reduce the number of fragments as demonstrated by RESTseq method. This approach looks interesting in some species with complex genomes as it allows removing parts of the genomes containing highly repetitive CG or / and AT rich sequences.\cr\cr
This function can be used directly after a single enzyme digestion using \code{\link{insilico.digest}} function to remove fragments containing restriction site of a second enzyme. An equivalent alternative would be to simulate a double digestion using \code{\link{insilico.digest}} followed by \code{\link{adapt.select}} with type = "AA", which would remove fragments containing restriction site of the enzyme 2 (see example below). \cr\cr
An unlimited number of exclusion steps using different restriction enzyme can be simulated by running the function with the output of a previous execution of the function (see example below). 
}
\value{
A vector of DNA fragment sequences.
}
\references{
Stolle & Moritz 2013. RESTseq - Efficient benchtop population genomics with RESTriction fragment SEQuencing. PLoS ONE 8: e63960. doi:10.1371/journal.pone.0063960
}
\author{
Olivier Lepais
}
\seealso{\code{\link{adapt.select}}, \code{\link{size.select}}.}
\examples{
### Example 1:
# simulating some sequence:
simseq <-  sim.DNAseq(size=1000000, GCfreq=0.433)

#Restriction Enzyme 1
#PstI
cs_5p1 <- "CTGCA"
cs_3p1 <- "G"

#Restriction Enzyme 2
#MseI #
cs_5p2 <- "T"
cs_3p2 <- "TAA"
# hence, recognition site: "TTAA"

# single digestion:
simseq.dig <- insilico.digest(simseq, cs_5p1, cs_3p1, cs_5p1, cs_3p1, verbose=TRUE)
# excluding fragments coutaining restriction site of the enzyme 2
simseq.exc <- exclude.seqsite(simseq.dig, "TTAA")

## which is equivalent to:
simseq.dig2 <- insilico.digest(simseq, cs_5p1, cs_3p1, cs_5p2, cs_3p2, verbose=TRUE)
simseq.selectAA <- adapt.select(simseq.dig2, type="AA", cs_5p1, cs_3p1, cs_5p2, cs_3p2)
length(simseq.selectAA)


### Example 2:
simseq <-  sim.DNAseq(size=1000000, GCfreq=0.51)

#Restriction Enzyme 1
#TaqI
cs_5p1 <- "T"
cs_3p1 <- "CGA"

simseq.dig <- insilico.digest(simseq, cs_5p1, cs_3p1, cs_5p1, cs_3p1, verbose=TRUE)

# removing fragments countaining restiction sites of MseI ("TTAA"), MliCI ("AATT"),
#         HaellI ("GGCC"), MspI ("CCGG") and HinP1I ("GCGC"):
excl1 <- exclude.seqsite(simseq.dig, "TTAA")
excl2 <- exclude.seqsite(excl1, "AATT")
excl3 <- exclude.seqsite(excl2, "GGCC")
excl4 <- exclude.seqsite(excl3, "CCGG")
excl5 <- exclude.seqsite(excl4, "GCGC")
# which can be followed by  size selection step.


}

\keyword{ double digestion }
\keyword{ restriction enzyme }
\keyword{ library construction }
\keyword{ adaptator ligation }
\keyword{ fragment selection }
\keyword{ restriction exclusion }
\keyword{ RESTseq }