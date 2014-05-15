\name{sim.DNAseq}
\alias{sim.DNAseq}

\title{
Function to simulate randomly generated DNA sequence. 
}
\description{
The function randomly generated DNA sequence of a given length and with fixed GC content to simulate DNA sequence representing a (proportion of the) genome for non-model species without available reference genome sequence.
}
\usage{
sim.DNAseq(size = 10000, GCfreq = 0.46)
}

\arguments{
  \item{size}{
DNA sequence length to generate in bp. Could be the known or estimated size of the species genome or more conveniently a fraction large enough to be representative of the full length size to limit memory usage and speed up computations.
}
  \item{GCfreq}{
GC content expressed as the proportion of G and C bases in the genome.
}
}
\details{
If no reference genome sequence or some reference contigs are available for a species, knowledge of GC content and genome size are needed to generate random DNA sequence representative of a species.
If reference genome sequence (even draft or unassembled contigs) are available, a randomly generated sequence can be simulate following CG content and length of an import proportion of the reference sequence for comparison purpose (see example below). 
}
\value{
A single continuous DNA sequence (character string).
}
\references{
Lepais O & Weir JT. 2014. SimRAD: an R package for simulation-based prediction of the number of loci expected in RADseq and similar genotyping by sequencing approaches. Molecular Ecology Resources. DOI: 10.1111/1755-0998.12273.
}
\author{
Olivier Lepais
}
\seealso{\code{\link{ref.DNAseq}}, \code{\link{insilico.digest}}.}
\examples{

## example 1: simulation of random sequence for non-model species without reference genome:
# generating 1Mb of DNA sequence with 44.4% GC content: 
smsq <- sim.DNAseq(size=1000000, GCfreq=0.444)

# length:
width(smsq)

# GC content:
require(seqinr)
GC(s2c(smsq))


## example 2: simulating random sequence with parameter following a known reference genome sequence:

# generating a Fasta file for the example:
sq<-c()
for(i in 1:10){
sq <- c(sq, sim.DNAseq(size=rpois(1, 1000), GCfreq=0.444))
}
sq <- DNAStringSet(sq)
writeFasta(sq, file="SimRAD-exampleRefSeq-Fasta.fa", mode="w")

# importing the Fasta file and sub-selecting 25% of the contigs
rfsq <- ref.DNAseq("SimRAD-exampleRefSeq-Fasta.fa", subselect.contigs = TRUE, prop.contigs = 0.25)

# length of the reference sequence:
width(rfsq)

# computing GC content:
require(seqinr)
GC(s2c(rfsq))

# simulating random generated DNA sequence with characteristics equivalent to 
#    the sub-selected reference genome for comparison purpose:
smsq <- sim.DNAseq(size=width(rfsq), GCfreq=GC(s2c(rfsq)))


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