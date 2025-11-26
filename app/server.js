const http = require('http');

const PORT = 3000;

http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('<h1>Blue-Green App - Active Environment</h1>');
}).listen(PORT, () => console.log(`SeEEEerver running on port ${PORT}`));
