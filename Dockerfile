FROM conda/miniconda2

MAINTAINER Thanh Le Viet lethanhx2k@gmail.com

RUN conda config --add channels defaults &&\
    conda config --add channels conda-forge &&\
    conda config --add channels r &&\
    conda config --add channels bioconda

#Install common bio tools
RUN conda install bwa \
                  samtools \
                  kmc \
                  seqtk \
                  flash \
                  lighter \
                  trimmomatic \
		  spades \
                  pilon \
		  perl-file-slurp \
		  perl-data-dumper \
		  perl-findbin \
		  perl-file-path \
		  perl-file-spec \
		  perl-file-copy-recursive \
		  perl-list-util \
		  perl-base \
    && conda clean --all
RUN apt-get update &&\
    apt-get -y install git pigz procps

# Add user biodocker with password biodocker
# https://github.com/BioContainers/containers/blob/master/biodocker/Dockerfile
RUN groupadd fuse \
    && useradd --create-home --shell /bin/bash --user-group --uid 1000 --groups sudo,fuse biodocker && \
    echo `echo "biodocker\nbiodocker\n" | passwd biodocker`


RUN cd /opt && git clone https://github.com/tseemann/shovill.git

ENV PATH /opt/shovill/bin:$PATH

# Change user
USER biodocker

CMD ["/bin/bash"]
