FROM mongo:3.4

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils openssl && rm -rf /var/lib/apt/lists/*

VOLUME /data
EXPOSE 27021 27022 27023

COPY setup.sh .

CMD ./setup.sh