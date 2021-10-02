const env = process.env;

const config = {
  db: { /* do not put password or any sensitive info here, done only for demo */
    host: env.DB_HOST || 'tai.db.elephantsql.com',
    port: env.DB_PORT || '5432',
    user: env.DB_USER || 'oxznjofy',
    password: env.DB_PASSWORD || 'ho5-0eoYHhdKdnazG9DJMPBBytS6XV3-',
    database: env.DB_NAME || 'oxznjofy',
  },
  listPerPage: env.LIST_PER_PAGE || 10,
};

module.exports = config;
