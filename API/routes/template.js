const express = require("express");
const router = express.Router();
const template = require("../services/template");

router.get("/", async function (req, res, next) {
  try {
    template.getMultiple(req.query.page);
  } catch (err) {
    console.error(`Error while getting users `, err.message);
    res.status(err.statusCode || 500).json({ message: err.message });
  }
});

module.exports = router;
