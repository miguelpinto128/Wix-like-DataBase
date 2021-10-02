const db = require("./db");
const helper = require("../helper");
const config = require("../config");

function getMultiple() {
  const https = require("https");
  https
    .get("https://randomuser.me/api/?results=20", (resp) => {
      let data = "";

      // A chunk of data has been received.
      resp.on("data", (results) => {
        data += results;
      });
      let arrayD = ['Designer', 'Backend Developer', 'Web Developer', 'Full Stack Developer', 'Student'];
      // The whole response has been received. Print out the result.
      resp.on("end", () => {
        let array = JSON.parse(data).results;
        let stringQuery = "";

        for (let index = 0; index < array.length; index++) {
          let user = array[index];
          let randomIsGoogle = Math.random() * 3;
          let google = null;
          if (randomIsGoogle == 0) {
            google = null;
          } else {
            if (randomIsGoogle == 1) {
              google = true;
            } else {
              google = false;
            }
          }
          let func = arrayD[Math.random() * 5 | 0];
          stringQuery =
            stringQuery +
            `INSERT INTO users(FirstName, LastName, Email, Password,LastLogin,LastLogOut,GoogleToken,FacebookToken,CookieToken,LogUpdate ,LogAdded)
              VALUES ('${user.name.first}','${user.name.last}','${user.email}','${user.login.password}',${null},${null},'${google == false ? user.login.md5 : null}','${google == true ? user.login.md5 : null}','${user.login.uuid}',${null},'${user.registered.date}') \n`;

          stringQuery =
                   stringQuery + `INSERT INTO UsersData(NIF, Address, PhoneNumber, Gender,Birthdate,Type,userId) VALUES ('${user.id.value}','${user.location.street.name}','${user.phone}','${user.gender == "female" ? 'Female' : 'Male'}',${null},'${func}', (select id from users order by id desc limit 1)) \n`
  
        }

        fs = require("fs");
        fs.writeFile("insertUsers.sql", stringQuery, function (err) {
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
