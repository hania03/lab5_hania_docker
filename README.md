# lab5_hania_docker
Zadanie z laboratorium 5 PAWCO

#Budowania pliku Dockerfile wykonano za pomocą polecenia
docker build -t lab5_hania_docker:latest --build-arg VERSION=2.0.0 --build-arg SERVER_IP=$(hostname -I | cut -d' ' - f1) --build-arg SERVER_NAME=$(hostname) .

#Uruchomienia wykonano za pomocą polecenia
docker run -d -p 8080:80 lab5_hania_docker:latest

#Efekty sprawdzono w przeglądarce
<img width="1181" alt="image" src="https://github.com/hania03/lab5_hania_docker/assets/34454921/fdcc0f31-a432-4f0b-82eb-b0aeffe011b8">


