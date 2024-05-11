const express = require('express');
const userDataController = require('../controllers/userDataController');

const router = express.Router();

router.post('/api/sendData', userDataController.sendData);

module.exports = router;
