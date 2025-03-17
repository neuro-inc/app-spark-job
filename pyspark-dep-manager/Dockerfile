FROM python:3.8-bookworm

# Install dependencies
RUN pip install pyspark pex

WORKDIR /app

COPY generate-pex.sh generate-pex.sh
RUN chmod +x ./generate-pex.sh

ENTRYPOINT [ "./generate-pex.sh" ]
