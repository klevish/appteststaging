FROM node:15-alpine
#l'image hérite de l'image node en version 15
#l'image node installe node et npm à l'intérieur du conteneur (image)
#On démarre avec une image existante qui est l'image node en vers 15 

#Create app directory
#Equivalent de : cd /usr/src/app
WORKDIR /usr/src/app
#WORKDIR permet de changer le directory dans lequel l'image est 
#si le directory existe pas, Docker le crée lui-même 
#le dossier est vide

#Install dependancies
COPY package*.son ./       
#on copie tous les packages-.json 
#le dossier n'est plus vide 
RUN npm install 

#Copier les autres fichiers de l'app
COPY . . 

EXPOSE 1337  
#exposer le port
CMD ["node", "app.js"]
#indiquer la ligne de commande
