# Utilisation de la dernière version de Node.js
FROM node:latest

# Création et définition du répertoire de travail dans le conteneur
WORKDIR /usr/src/app

# Copie des fichiers de définition des dépendances
COPY package*.json ./

# Installation des dépendances
RUN npm install

# Copie du fichier de configuration TypeScript
COPY tsconfig.json ./

# Copie du reste du code source dans le conteneur
COPY . .

# Création d'un groupe et d'un utilisateur non-root
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Changement de la propriété des fichiers/dossiers nécessaires
RUN chown -R appuser:appgroup /usr/src/app

# Passage à l'utilisateur non-root
USER appuser

# Exposition du port sur lequel l'API va s'exécuter (à modifier si différent)
EXPOSE 3000

# Lancement de l'application
CMD ["node", "build/index.js"]