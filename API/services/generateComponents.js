const db = require("./db");
const helper = require("../helper");
const config = require("../config");

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

async function getMultiple() {
  let arraySites = [
    1,2,3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
    24, 25, 26, 27, 28, 29, 30,
  ];
  let stringQuery = "";

  await arraySites
    .reduce(async (promise, item) => {
      await promise;
      const element = item;
      console.log(element);
      let numberComp = Math.random() * 10;

      for (let index = 0; index < [numberComp | 0]; index++) {
        let xCoord = Math.random() * 1200;
        let yCoord = Math.random() * 800;
        let ptValue = "";
        let enValue = "";

        const fetch = require("node-fetch");

        await (async () => {
          try {
            const response = await fetch(
              "https://random-word-api.herokuapp.com/word?number=1"
            );
            const json = await response.json();
            let value = json[0];
            console.log(value);
            var url = new URL(
                "https://nlp-translation.p.rapidapi.com/v1/translate"
              ),
              params = { text: value, to: "pt", from: "en" };
            Object.keys(params).forEach((key) =>
              url.searchParams.append(key, params[key])
            );

            let response_ = await fetch(url, {
              headers: {
                "x-rapidapi-key":
                  "oYTtivZ3xJmshd4agfGcPrZuA5Wrp1lOBB0jsna4FZJz0BA8LQ",
                "x-rapidapi-host": "nlp-translation.p.rapidapi.com",
                useQueryString: true,
              },
            });

            const json_ = await response_.json();
            enValue = value;
            ptValue = json_.translated_text.pt;
            stringQuery =
              stringQuery +
              `INSERT INTO website_components(xcoord,ycoord,logadded,websiteid,componentid) VALUES(${xCoord},${yCoord},(timestamp '2021-02-10 20:00:00' + random() * (timestamp '2021-01-20 20:00:00' - timestamp '2021-12-10 10:00:00')),${element}, (SELECT c.id FROM components c INNER JOIN templates_components tc on tc.templateId = (select w.templateid from websites w where w.id = 2 limit 1)  and c.id = tc.componentid ORDER BY RANDOM() LIMIT 1)) \n`;

            stringQuery =
              stringQuery +
              `INSERT INTO websitecomponents_languages(logadded,websitecomponentid,countryId,value) values ('12-06-2021',(select id from website_components order by id desc limit 1),${192},'${enValue}') \n`;

            stringQuery =
              stringQuery +
              `INSERT INTO websitecomponents_languages(logadded,websitecomponentid,countryId,value) values ('12-06-2021',(select id from website_components order by id desc limit 1),${145},'${ptValue}') \n`;
          } catch (error) {
            // console.log(error.response.body);
          }
        })();
      }
    }, Promise.resolve())
    .then(() => {
      console.log("shit");
      fs = require("fs");
      fs.writeFile(
        "insertWebSitesComponents.sql",
        stringQuery,
        function (err) {}
      );
    });
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
