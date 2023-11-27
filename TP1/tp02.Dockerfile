# Étape 1: Build
# Utilisation de la dernière version de Node.js
FROM node:latest as build

# Création et définition du répertoire de travail dans le conteneur
WORKDIR /usr/src/app

# Copie des fichiers de définition des dépendances
COPY package*.json ./

# Copie du fichier de configuration TypeScript
COPY tsconfig.json ./

# Installation des dépendances
RUN npm install

# Copie du fichier de configuration TypeScript et du reste du code source
COPY . .

# Compilation du TypeScript en JavaScript
RUN npm run build

# Étape 2: Runtime
# Utilisation de la dernière version de Node.js pour l'exécution
FROM node:latest

# Création et définition du répertoire de travail dans le conteneur
WORKDIR /usr/src/app

# Copie des dépendances installées depuis l'étape de build
COPY --from=build /usr/src/app/node_modules ./node_modules

# Copie des fichiers JavaScript compilés depuis l'étape de build
COPY --from=build /usr/src/app/build ./build

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
