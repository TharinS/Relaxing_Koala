const express = require('express');
const path = require('path');
const app = express();

app.use(express.static(path.join(__dirname)));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/about', (req, res) => {
  res.sendFile(path.join(__dirname, 'pages/about.html'));
});

app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'pages/login.html'));
});

app.get('/create_account', (req, res) => {
  res.sendFile(path.join(__dirname, 'pages/create_account.html'));
});

app.get('/profile', (req, res) => {
  res.sendFile(path.join(__dirname, 'pages/profile.html'));
});

app.get('/past_orders', (req, res) => {
  res.sendFile(path.join(__dirname, 'pages/past_orders.html'));
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
