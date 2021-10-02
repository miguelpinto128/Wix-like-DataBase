const express = require("express");
const router = express.Router();
const configsites = require("../services/configsites");

router.get("/", async function (req, res, next) {
  try {
    configsites.getMultiple(req.query.page);
  } catch (err) {
    console.error(`Error while getting users `, err.message);
    res.status(err.statusCode || 500).json({ message: err.message });
  }
});

module.exports = router;
