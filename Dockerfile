FROM mongo:4.0

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils openssl && rm -rf /var/lib/apt/lists/*

VOLUME /data
EXPOSE 27021 27022 27023

COPY setup.sh .

CMD ./setup.sh
