const http = require('http');

const PORT = 3000;
const env = process.env.ENV || 'unknown';

http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end(`<h1>Blue-Green App - Active Environment: ${env}</h1>`);
}).listen(PORT, () => console.log(`Server running on port ${PORT} - ENV: ${env}`));

