// Importation du module HTTP natif de Node.js
import http from 'http';
import os from 'os'; // Importez le module os

// Définition du port d'écoute du serveur. Utilise une variable d'environnement si définie, sinon le port 3000
const port = process.env.PING_LISTEN_PORT || 3000;

// Création d'un serveur HTTP. La fonction passée en argument est appelée à chaque requête reçue
const server = http.createServer((req, res) => {
  const hostname = os.hostname(); // Obtenez le nom d'hôte
  
  // Affiche un message dans la console à chaque requête reçue sur le serveur ecrire le nom d'hôte
  console.log(`Requête reçue sur /ping depuis le hostname : ${hostname}`);

  // Vérifie si la méthode de la requête est GET et l'URL est '/ping'
  if (req.method === 'GET' && req.url === '/ping') {
    // Prépare une réponse HTTP avec un statut 200 (OK) et un en-tête indiquant un contenu JSON
    res.writeHead(200, { 'Content-Type': 'application/json' });
    // Envoie la réponse contenant les headers de la requête au format JSON
    res.end(JSON.stringify(req.headers));
  } else {
    // Si l'URL demandée n'est pas '/ping' ou que la méthode n'est pas GET, renvoie une erreur 404
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    // Termine la réponse avec un message d'erreur
    res.end();
  }
});

// Le serveur commence à écouter sur le port spécifié. Affiche un message une fois le serveur lancé
server.listen(port, () => {
  console.log(`Serveur en écoute sur le port ${port}`);
});


//URL : http://localhost:3000/ping