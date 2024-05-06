const express = require('express');
const os = require('os');

const app = express();

app.get('/', (req, res) => {
    res.send('Aplikacja działa poprawnie🌻');
});

app.listen(8080, () => {
    console.log('Serwer nasłuchuje na porcie 8080');
});