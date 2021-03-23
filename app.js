

const express = require('express'); //on fait appel à la dependance express
const { loggers } = require('winston');
const app = express(); //declaration d'une variable nouvelle instance d'express

const PORT = 1337;

const winston = require('winston');
const logger = winston.createLogger({
    level: 'info',
    format: winston.format.json(),
    defaultMeta: { service: 'devops' },
    transports: [
      // - Write all logs with level `error` and below to `error.log`
      // - Write all logs with level `info` and below to `combined.log`
      new winston.transports.File({ filename: 'error.log', level: 'error' }),
      new winston.transports.File({ filename: 'combined.log' }),

    ],

  });

app.get('/', function(req, res) { 

    loggers.log({
        level:'error',
        message: 'Hello distributed log files'
    });

    //fonction executer a chaque fois qu'une requete arrive en GET sur /
    // on recoit deux objets : req tout ce qui est lié à l'utilisateur
    // et res tout ce qu'on renvoie en réponse à l'utilisateur 
    return res.status(200).json({   //méthode .json renvoie du JSON au client
        hello: 'world'
    });
});


app.listen(PORT, () => {  
    //fonction listen qui prend deux arguments : le port et une fonction callback
    console.log('Server listening on port ${PORT}')
});
