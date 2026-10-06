## R version 4.6.1
FROM rocker/shiny:4.6.1

LABEL maintainer="Gabriele Tomè <gabriele.tome@eurac.edu>"
LABEL Description="ChromatogramsVis."

# RUN apt-get -y --allow-releaseinfo-change update && apt-get -y install \
#   netcdf-bin libnetcdf-dev libdigest-sha-perl libigraph-dev \
#   xorg-dev libglu1-mesa-dev freeglut3-dev libgomp1 libxml2-dev gcc g++ \
#   libssl-dev gdebi-core libharfbuzz-dev libfribidi-dev libtiff5-dev

RUN echo 'sanitize_errors off;disable_protocols xdr-streaming xhr-streaming iframe-eventsource iframe-htmlfile;' >> /etc/shiny-server/shiny-server.conf

ADD DESCRIPTION /tmp/ChromatogramsVis/DESCRIPTION
WORKDIR /tmp/ChromatogramsVis/
RUN R -e 'install.packages(c("pak", "tinytex", "xfun"))'
RUN R -e 'pak::pak(c("devtools", "BiocManager"))'
## Remove when the packages will be in BiocConductor.
RUN R -e 'pak::pak(c("Rformassspectrometry/MsExperimentStash", "Rformassspectrometry/MsStash"))'
# RUN R -e 'pak::local_install_deps()'
# ## Install manually otherwise it is missing.
RUN R -e 'pak::pak(c("mzR", "MsExperiment", "Spectra", "MsBackendMetaboLights"))'
# ## After update of Chromatograms package, remove the following line.
RUN R -e 'pak::pak("Rformassspectrometry/Chromatograms@gabri")'

ADD . /tmp/ChromatogramsVis
RUN R CMD INSTALL /tmp/ChromatogramsVis

EXPOSE 3838
WORKDIR /srv/shiny-server
RUN rm -rf *
ADD ./inst/app/ /srv/shiny-server
