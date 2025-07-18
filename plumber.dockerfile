FROM rocker/r-ver:4.3.1

# Install R Package
RUN install.packages(c("plumber"), repos = "https://cran.rstudio.com/")

# Copy API script
COPY api.R /api.R

# Exposed port
EXPOSE 8000

# Starting command
ENTRYPOINT ["Rscript", "-e", "pr <- plumber::plumb('/api.R'); pr$run(host='0.0.0.0', port=8000)"]