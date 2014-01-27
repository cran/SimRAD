\name{ref.DNAseq}
\alias{ref.DNAseq}

\title{
Function to import a reference DNA sequence from a Fasta file.
}
\description{
This function read a Fasta file containing a genome reference DNA sequence in the form of several contigs (or alternatively a single sequence) and can optionally randomly sub-select a fraction of the contigs sequence to allow for faster computation and avoid memory saturation.
}
\usage{
ref.DNAseq(FASTA.file, subselect.contigs = TRUE, prop.contigs = 0.1)
}

\arguments{
  \item{FASTA.file}{
Full patch to a Fasta file (e.g."\code{C:/Users/Me/Documents/RAD/refGenome.fa}").
}
  \item{subselect.contigs}{
If TRUE (the default) and if the Fasta file contains more than one sequence, sub-select a fraction of the contig sequences. If FALSE or if the Fasta file contains only one continuous DNA sequence, all data contain in the Fasta file is imported.
}
  \item{prop.contigs}{
Proportion of contigs to randomly sub-select for subsequent analyses.
}
}
\details{
To limit memory usage and speed up computation time, it is strongly recommended to sub-select a fraction of the available reference DNA contigs. Usually, a proportion of 0.10 of the reference contigs should be representative enough to give a good idea of the genome characteristics of the species. The ratio of the length of contig sequence kept to the estimated total size of the genome can then be used to estimate the number of loci by cross-multiplication (see example below). \cr\cr
Contig sequences will be randomly concatenated to form a chimeric unique continuous sequence (comparable to simulated sequence by \code{\link{sim.DNAseq}} function). This may create some bias as two restriction site located in two different contigs may thus form a fragments that would not exist in the real genome. Yet, contigs do not represent real entities and keeping them apart would also create biases by randomly generating false digested restriction site which would heavily inflate the number of sites and loci particularly for draft reference genome with hundred of thousand of contigs. On the contrary, the choice to concatenate contigs may only slightly increase the number of restriction site and the number of fragments (loci). 
}
\value{
A single continuous DNA sequence (character string).
}

\author{
Olivier Lepais
}
\seealso{\code{\link{sim.DNAseq}}, \code{\link{insilico.digest}}.}
\examples{

# generating a Fasta file for the example:
sq<-c()
for(i in 1:20){
sq <- c(sq, sim.DNAseq(size=rpois(1, 10000), GCfreq=0.444))
}
sq <- DNAStringSet(sq)
writeFasta(sq, file="SimRAD-exampleRefSeq.fa", mode="w")

# importing the Fasta file and sub selecting 25% of the contigs
rfsq <- ref.DNAseq("SimRAD-exampleRefSeq.fa", subselect.contigs = TRUE, prop.contigs = 0.25)

# length of the reference sequence:
width(rfsq)

# ratio for the cross-multiplication of the number of fragments and loci at the genomes scale:
genome.size <- 100000000 # genome size: 100Mb
ratio <- genome.size/width(rfsq)
ratio

# computing GC content:
require(seqinr)
GC(s2c(rfsq))

# simulating random generated DNA sequence with characteristics equivalent to
#     the sub-selected reference genome for comparison purpose:
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