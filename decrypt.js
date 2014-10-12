#!/usr/bin/env node
var BadCipher = require('bad-cipher');
var fs        = require('fs');

var cryptedFile = process.argv[2] || './edata.json';

if (!fs.existsSync(cryptedFile))
  throw new Error('File not found: ' + cryptedFile);

var edata = require(cryptedFile);

var result = BadCipher.decrypt(edata.edata);

result = JSON.parse(result);

fs.writeFileSync('info.json', JSON.stringify(result, null, 2));
