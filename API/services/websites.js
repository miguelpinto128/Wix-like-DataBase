const db = require("./db");
const helper = require("../helper");
const config = require("../config");

function getMultiple() {
  const https = require("https");
  https
    .get("https://random-data-api.com/api/company/random_company?size=30", (resp) => {
      let data = "";

      // A chunk of data has been received.
      resp.on("data", (results) => {
        data += results;
      });

      let arrayAux = ['Paid', 'In progress', 'Created'];
      resp.on("end", () => {
        let array = JSON.parse(data);
        let stringQuery = "";

        for (let index = 0; index < array.length; index++) {
          let item = array[index];
          let status = arrayAux[Math.random() * 3 | 0];
          let randomPlan = Math.random() * 7;
          let planId = [randomPlan | 0]
          stringQuery =
            stringQuery +
            `INSERT INTO websites(Name, Status,LogAdded,PlanId,UserId, TemplateId)
              VALUES ('${item.business_name}', '${status}', (timestamp '2021-02-10 20:00:00' + random() * (timestamp '2021-01-20 20:00:00' - timestamp '2021-12-10 10:00:00')),${planId},(SELECT id FROM users ORDER BY RANDOM() LIMIT 1),(SELECT  t.id FROM Templates t inner join  plans_templates pt on pt.templateid = t.id where pt.PlanId = ${planId} ORDER BY RANDOM() LIMIT 1)) \n`;

          stringQuery =
                   stringQuery + `INSERT INTO Invoices(companyid,websiteId, paymentmethodId, date,reference,qrCode,LogAdded) VALUES (1 ,(select id from websites order by id desc limit 1),(SELECT id FROM PaymentMethods ORDER BY RANDOM() LIMIT 1),(select LogAdded from websites order by id desc limit 1),'${item.uid}','${item.logo}',(select LogAdded from websites order by id desc limit 1)) \n`
  
        }

        fs = require("fs");
        fs.writeFile("insertWebSites.sql", stringQuery, function (err) {
        });
      });
    })
    .on("error", (err) => {
      console.log("Error: " + err.message);
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
