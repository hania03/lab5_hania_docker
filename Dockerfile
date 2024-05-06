#I - budowanie aplikacji w oparciu o Node i scratch
FROM scratch AS mojealpine
ADD alpine-minirootfs-3.19.1-aarch64.tar /

#budowanie aplikacji Node
FROM mojealpine AS builder

#Zmienna srodowiskowa dla wersji VERSION
ARG VERSION=1.0.0

RUN apk add --update curl && \
	rm -rf /var/cache/apk/*

#Instalowanie Node.js
RUN apk update && apk add nodejs npm

#Ustawienie katalogu roboczego w kontenerze
WORKDIR /hania/app

#Kopiowanie plikow aplikacji do kontenera
COPY ./package.json ./

#Zaleznosc
RUN npm install

COPY ./index.js ./

EXPOSE 8080

#Polecenie dla uruchomienia aplikacji
CMD ["node", "index.js"]

#II - obraz nginx
FROM nginx:latest

#Kopiowanie plikow aplikacji do serwera HTTP
COPY --from=builder /hania/app /hania/share/nginx/html

#adres IP serwera
ARG SERVER_IP
RUN echo "Adres serwera to $(hostname -I | awk '{print $1}')" > /hania/share/nginx/html/index.html

#nazywamy serwer
ARG SERVER_NAME
RUN echo "Nazwa serwera to $SERVER_NAME" >> /hania/share/nginx/html/index.html

#wersja aplikacji
ARG VERSION
RUN echo "Wersja aplikacji to $VERSION" >> /hania/share/nginx/html/index.html

#HEALTHCHECK
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:8080/ || exit 1
