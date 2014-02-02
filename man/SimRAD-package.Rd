\name{SimRAD-package}
\alias{SimRAD-package}
\alias{SimRAD}
\docType{package}
\title{Simulations to predict the number of loci expected in RAD and GBS approaches.}
\description{SimRAD provides a number of functions to simulate restriction enzyme digestion, library construction and fragments size selection to predict the number of loci expected from most of the Restriction site Associated DNA (RAD) and Genotyping By Sequencing (GBS) approaches. SimRAD aims to provide an estimation of the number of loci expected from a given genome depending on protocol type and parameters allowing to assess feasibility, multiplexing capacity and the amount of sequencing required.}
\details{
\tabular{ll}{
Package: \tab SimRAD\cr
Type: \tab Package\cr
Version: \tab 0.93\cr
Date: \tab 2014-01-27\cr
License: \tab GPL-2\cr
}
This package provides a number of functions to simulate restriction enzyme digestion (\code{\link{insilico.digest}}), library construction (\code{\link{adapt.select}}) and fragments size selection (\code{\link{size.select}}) to predict the number of loci expected from most of the Restriction site Associated DNA (RAD) and Genotyping By Sequencing (GBS) approaches. \cr Built with non-model species in mind, a function can simulate DNA sequence when no reference genome sequence is available (\code{\link{sim.DNAseq}}) providing genome size and CG content is known. Alternatively, reference genomic sequences can be used as an input (\code{\link{ref.DNAseq}}). SimRAD can accommodate various Reduced Representation Libraries methods that may combine single or double restriction enzyme digestion (RAD and GBS), fragment size selection (ddRAD and ezRAD) and restriction site based fragment exclusion (RESTseq).
}
\author{Olivier Lepais and Jason Weir \cr\cr
Maintainer: Olivier Lepais <olepais@st-pee.inra.fr>
}
\references{
Baird et al. 2008. Rapid SNP discovery and genetic mapping using sequenced RAD markers. PLoS ONE 3: e3376. doi:10.1371/journal.pone.0003376 \cr\cr
Elshire et al. 2011. A robust, simple Genotyping-By-Sequencing (GBS) approach for high diversity species. PLoS ONE 6: e19379. doi:10.1371/journal.pone.0019379 \cr\cr
Peterson et al. 2012. Double Digest RADseq: an inexpensive method for de novo SNP discovery and genotyping in model and non-model species. PLoS ONE 7: e37135. doi:10.1371/journal.pone.0037135 \cr\cr
Poland et al. 2012. Development of high-density genetic maps for barley and wheat using a novel two-enzyme Genotyping-By-Sequencing approach. PLoS ONE 7: e32253. doi:10.1371/journal.pone.0032253 \cr\cr
Stolle & Moritz 2013. RESTseq - Efficient benchtop population genomics with RESTriction fragment SEQuencing. PLoS ONE 8: e63960. doi:10.1371/journal.pone.0063960 \cr\cr
Toonen et al. 2013. ezRAD: a simplified method for genomic genotyping in non-model organisms. PeerJ 1:e203 http://dx.doi.org/10.7717/peerj.203
}

\keyword{ package }
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


\examples{
### Example 1: a single digestion (RAD)
simseq <-  sim.DNAseq(size=100000, GCfreq=0.51)
#Restriction Enzyme 1
#SbfI
cs_5p1 <- "CCTGCA"
cs_3p1 <- "GG"
simseq.dig <- insilico.digest(simseq, cs_5p1, cs_3p1, verbose=TRUE)

### Example 2: a single digestion (GBS)
simseq <-  sim.DNAseq(size=100000, GCfreq=0.51)
#Restriction Enzyme 1
# ApeKI : G|CWGC  which is equivalent of either G|CAGC or  G|CTGC
cs_5p1 <- "G"
cs_3p1 <- "CAGC"
cs_5p2 <- "G"
cs_3p2 <- "CTGC"
simseq.dig <- insilico.digest(simseq, cs_5p1, cs_3p1, cs_5p1, cs_3p1, verbose=TRUE)

### Example3: a double digestion (ddRAD)
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
