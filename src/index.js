'use strict';

const oledb = require('oledb');
const logger = console;

const connectionString = process.env.CONNECTION_STRING;
const query = process.env.QUERY;

logger.info('Connecting to -> %s', connectionString);
logger.info('Using query -> %s', query);

const db = oledb.oledbConnection(connectionString);
db.query(query)
  .then(result => {
    logger.info('Got result: %O', result);
  })
  .catch(ex => {
    logger.info('error');
    logger.error(ex);
  });
