const express = require('express');
const menuController = require('../controllers/menuController');
const router = express.Router();

router.get("/menu/get-item", menuController.getItemsByCategory);

module.exports = router;
