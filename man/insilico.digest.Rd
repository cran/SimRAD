\name{insilico.digest}
\alias{insilico.digest}

\title{
Function to digest DNA sequence using one or two restriction enzyme(s).
}
\description{
Perform an in silico digestion of a DNA sequence using one or two restriction enzyme(s).
}
\usage{
insilico.digest(DNAseq, cut_site_5prime1, cut_site_3prime1, 
                        cut_site_5prime2="NULL", cut_site_3prime2="NULL",  
                        cut_site_5prime3="NULL", cut_site_3prime3="NULL", 
                        cut_site_5prime4="NULL", cut_site_3prime4="NULL", 
                        verbose = TRUE)
}

\arguments{
  \item{DNAseq}{
A DNA sequence (character string) as output for instance, but not exclusively, by \code{\link{sim.DNAseq}} or \code{\link{ref.DNAseq}} functions. 
}
  \item{cut_site_5prime1}{
5 prime side (left side) of the recognized restriction site of the restriction enzyme 1. 
}
  \item{cut_site_3prime1}{
3 prime side (right side) of the recognized restriction site of the restriction enzyme 1. 
}
  \item{cut_site_5prime2}{
5 prime side (left side) of the recognized restriction site of the restriction enzyme 2 (optional).
}
  \item{cut_site_3prime2}{
3 prime side (right side) of the recognized restriction site of the restriction enzyme 2 (optional).
}
  \item{cut_site_5prime3}{
5 prime side (left side) of the recognized restriction site of the restriction enzyme 3 (optional).
}
  \item{cut_site_3prime3}{
3 prime side (right side) of the recognized restriction site of the restriction enzyme 3 (optional).
}
  \item{cut_site_5prime4}{
5 prime side (left side) of the recognized restriction site of the restriction enzyme 4 (optional).
}
  \item{cut_site_3prime4}{
3 prime side (right side) of the recognized restriction site of the restriction enzyme 4 (optional).
}
  \item{verbose}{
If TRUE (the default), returns the number of restriction sites (if only one restriction enzyme is used) or the number of restriction sites for the two enzymes and the number of fragments flanked by either restriction site of the enzyme 1 or 2 and flanked by restriction fragments of two different enzymes. FALSE makes the function silent to be used in a loop.
}
}
\details{
Restriction site with alternative bases such as ApeKI used for GBS by Elshire et al. (2011) can be simulated by specifying the two alternative recognition motifs of the enzyme as parameter for enzyme 1 and enzyme 2 (see example below).
}
\value{
A vector of DNA fragments resulting from the digestion.
}

\author{
Olivier Lepais and Jason Weir
}
\seealso{\code{\link{sim.DNAseq}}, \code{\link{ref.DNAseq}}.}
\references{
Baird et al. 2008. Rapid SNP discovery and genetic mapping using sequenced RAD markers. PLoS ONE 3: e3376. doi:10.1371/journal.pone.0003376 \cr\cr
Elshire et al. 2011. A robust, simple Genotyping-By-Sequencing (GBS) approach for high diversity species. PLoS ONE 6: e19379. doi:10.1371/journal.pone.0019379 \cr\cr
Peterson et al. 2012. Double Digest RADseq: an inexpensive method for de novo SNP discovery and genotyping in model and non-model species. PLoS ONE 7: e37135. doi:10.1371/journal.pone.0037135 \cr\cr
Poland et al. 2012. Development of high-density genetic maps for barley and wheat using a novel two-enzyme Genotyping-By-Sequencing approach. PLoS ONE 7: e32253. doi:10.1371/journal.pone.0032253 \cr\cr
Stolle & Moritz 2013. RESTseq - Efficient benchtop population genomics with RESTriction fragment SEQuencing. PLoS ONE 8: e63960. doi:10.1371/journal.pone.0063960 \cr\cr
Toonen et al. 2013. ezRAD: a simplified method for genomic genotyping in non-model organisms. PeerJ 1:e203 http://dx.doi.org/10.7717/peerj.203
}

\examples{

### Example 1: a single digestion (RAD)
simseq <-  sim.DNAseq(size=1000000, GCfreq=0.51)
#Restriction Enzyme 1
#SbfI
cs_5p1 <- "CCTGCA"
cs_3p1 <- "GG"
simseq.dig <- insilico.digest(simseq, cs_5p1, cs_3p1, verbose=TRUE)


### Example 2: a single digestion (GBS)
simseq <-  sim.DNAseq(size=1000000, GCfreq=0.51)
#Restriction Enzyme 1
# ApeKI : G|CWGC  which is equivalent of either G|CAGC or  G|CTGC
cs_5p1 <- "G"
cs_3p1 <- "CAGC"
cs_5p2 <- "G"
cs_3p2 <- "CTGC"
simseq.dig <- insilico.digest(simseq, cs_5p1, cs_3p1, cs_5p1, cs_3p1, verbose=TRUE)


### Example 3: a double digestion (ddRAD)
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
simseq.dig <- insilico.digest(simseq, cs_5p1, cs_3p1, cs_5p2, cs_3p2, verbose=TRUE)




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