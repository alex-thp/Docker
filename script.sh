docker-machine start ft-server
#Il va peut-être y avoir besoin de supprimer et de recréer la machine
#eval $(docker-machine env ft-server) #A LANCER AVAMT LE SCRIPT
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.102:2376"
export DOCKER_CERT_PATH="/Users/ade-temm/.docker/machine/machines/ft-server"
export DOCKER_MACHINE_NAME="ft-server"
docker container -y prune
docker images -y prune
docker build . -t my_image
docker run -it -p 80:80 -p 443:443 my_image #le premier 80 = le port de ma machine (mac), et le deuxieme de mon container

#80 est le port par defaut
#Ici on fait nos trucs
#docker container rm $(docker ps -a | head | cut -b -12 | sed -n '2p')
#docker image rm $(docker image ls | grep my_image | cut -b 41-53)