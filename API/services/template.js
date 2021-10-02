const db = require("./db");
const helper = require("../helper");
const config = require("../config");

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

async function getMultiple() {
  let arrayPlans = [1, 2, 3, 4, 5, 6, 7];
  let arrayTemplate = [1, 2, 3, 4, 5, 6, 7, 8];

  let stringQuery = "";

  arrayPlans.forEach((element) => {
    let numberTemp = getRandomInt(2,5);
    for (let index = 0; index < [numberTemp | 0]; index++) {
      stringQuery =
        stringQuery +
        `INSERT INTO plans_templates(PLANID, TEMPLATEID, LOGADDED) VALUES(${element},(SELECT id FROM templates ORDER BY RANDOM() LIMIT 1),'12-06-2021') \n`;
    }
  });

  arrayTemplate.forEach((element) => {
    let numberComp =  getRandomInt(4,7);
    for (let index = 0; index < [numberComp | 0]; index++) {
      stringQuery =
        stringQuery +
        `INSERT INTO  templates_components( COMPONENTID, TEMPLATEID, LOGADDED )  VALUES ((SELECT id FROM components  ORDER BY RANDOM() LIMIT 1),${element},'12-06-2021') \n`;
    }
  });

  fs = require("fs");
  fs.writeFile("insertTemplateConfig.sql", stringQuery, function (err) {});
}

function validateCreate(quote) {
  let messages = [];

  console.log(quote);

  if (!quote) {
    messages.push("No object is provided");
  }

  if (!quote.quote) {
    messages.push("Quote is empty");
  }

  if (!quote.author) {
    messages.push("Author is empty");
  }

  if (quote.quote && quote.quote.length > 255) {
    messages.push("Quote cannot be longer than 255 characters");
  }

  if (quote.author && quote.author.length > 255) {
    messages.push("Author name cannot be longer than 255 characters");
  }

  if (messages.length) {
    let error = new Error(messages.join());
    error.statusCode = 400;

    throw error;
  }
}

async function create(quote) {
  validateCreate(quote);

  const result = await db.query(
    "INSERT INTO quote(quote, author) VALUES ($1, $2) RETURNING *",
    [quote.quote, quote.author]
  );
  let message = "Error in creating quote";

  if (result.length) {
    message = "Quote created successfully";
  }

  return { message };
}

module.exports = {
  getMultiple,
  create,
};
