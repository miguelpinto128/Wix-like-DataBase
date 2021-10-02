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
    {
      SiteId: 27,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 25,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 23,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 22,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 17,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 9,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 5,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 30,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 28,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 26,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 19,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 15,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 13,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 11,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 10,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 8,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 29,
      bd: true,
      ads: true,
      smtp: false,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 21,
      bd: true,
      ads: true,
      smtp: false,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 32,
      bd: false,
      ads: false,
      smtp: false,
      server: false,
      domains: true,
      tickets: true,
      crons: false,
    },
    {
      SiteId: 24,
      bd: false,
      ads: false,
      smtp: false,
      server: false,
      domains: true,
      tickets: true,
      crons: false,
    },
    {
      SiteId: 18,
      bd: false,
      ads: false,
      smtp: false,
      server: false,
      domains: true,
      tickets: true,
      crons: false,
    },
    {
      SiteId: 16,
      bd: false,
      ads: false,
      smtp: false,
      server: false,
      domains: true,
      tickets: true,
      crons: false,
    },
    {
      SiteId: 14,
      bd: false,
      ads: false,
      smtp: false,
      server: false,
      domains: true,
      tickets: true,
      crons: false,
    },
    {
      SiteId: 6,
      bd: false,
      ads: false,
      smtp: false,
      server: false,
      domains: true,
      tickets: true,
      crons: false,
    },
    {
      SiteId: 7,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 2,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 31,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 20,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 12,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
    {
      SiteId: 3,
      bd: true,
      ads: true,
      smtp: true,
      server: true,
      domains: true,
      tickets: true,
      crons: true,
    },
  ];

  let stringQuery = "";

  await arraySites
    .reduce(async (promise, item) => {
      await promise;
      let element = item;
      if (element.bd) {
        await (async () => {
          try {
            const response = await fetch(
              "https://random-data-api.com/api/internet_stuff/random_internet_stuff?number=1"
            );
            const json = await response.json();
            let value = json[0];
            stringQuery =
              stringQuery +
              `INSERT INTO DataBases(websiteId,Name,LogAdded) VALUES (${element.SiteId},'${value.private_ip_v4_address}','12-06-2021') \n`;
          } catch (error) {}
        })();
      }
      if (element.ads) {
        let random = getRandomInt(0, 7);
        for (let index = 0; index < random; index++) {
          stringQuery =
            stringQuery +
            `INSERT INTO websites_ads(ADSID, WEBSITEID, LOGADDED) VALUES ((SELECT id FROM ads ORDER BY RANDOM() LIMIT 1),${element.SiteId},'12-06-2021') \n`;
        }
      }
      if (element.smtp) {
        await (async () => {
          try {
            const response = await fetch(
              "https://random-data-api.com/api/internet_stuff/random_internet_stuff?number=1"
            );
            const json = await response.json();
            let value = json[0];
            stringQuery =
              stringQuery +
              `INSERT INTO smtp(websiteId,Name,LogAdded) VALUES (${element.SiteId},'${value.private_ip_v4_address}','12-06-2021') \n`;
          } catch (error) {}
        })();
      }
      if (element.server) {
        await (async () => {
          try {
            const response = await fetch(
              "https://random-data-api.com/api/internet_stuff/random_internet_stuff?number=1"
            );
            const json = await response.json();
            let value = json[0];
            stringQuery =
              stringQuery +
              `INSERT INTO servers(websiteId,Name,LogAdded) VALUES (${element.SiteId},'${value.url}','12-06-2021') \n`;
          } catch (error) {}
        })();
      }
      if (element.domains) {
        await (async () => {
          try {
            const response = await fetch(
              "https://random-data-api.com/api/internet_stuff/random_internet_stuff?number=1"
            );
            const json = await response.json();
            let value = json[0];
            stringQuery =
              stringQuery +
              `INSERT INTO domains(websiteId,Name,LogAdded) VALUES (${element.SiteId},'${value.url}','12-06-2021') \n`;
          } catch (error) {}
        })();
      }
      if (element.tickets) {
        let random = getRandomInt(0, 7);
        await (async () => {
          try {
            const response = await fetch(
              "https://random-data-api.com/api/hipster/random_hipster_stuff?number=" +
                random
            );
            const json = await response.json();
            json.forEach((item) => {
              stringQuery =
                stringQuery +
                `INSERT INTO Tickets(websiteId,Title,Message,LogAdded) VALUES (${element.SiteId},${item.sentence},${item.paragraph},'12-06-2021'); \n`;
            });
          } catch (error) {}
        })();
      }
      if (element.crons) {
        let random = getRandomInt(0, 6);
        for (let index = 0; index < random; index++) {
          stringQuery =
            stringQuery +
            `INSERT INTO websites_cronjobs(websiteid, cronjobid, logadded)  VALUES (${element.SiteId},(SELECT id FROM cronjobs ORDER BY RANDOM() LIMIT 1),'06-12-2021') \n`;
        }
      }
    }, Promise.resolve())
    .then(() => {
      console.log("shit");
      fs = require("fs");
      fs.writeFile(
        "insersiteconfig.sql",
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
