const express = require('express');
const path = require('path');
const app = express();

app.use(express.static(path.join(__dirname)));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/dashboard', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/dashboard.html'));
});

app.get('/menu', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/menu.html'));
});

app.get('/analytics', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/analytics.html'));
});

app.get('/order_details', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/order_details.html'));
});

app.get('/receipts', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/receipts.html'));
});

const port = process.env.PORT || 3100;
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
