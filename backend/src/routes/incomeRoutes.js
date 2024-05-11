const express = require('express');
const incomeController = require('../controllers/incomeController');
const router = express.Router();

router.post('/api/save_daily_income', incomeController.saveDailyIncome);
router.get('/api/chartdata', incomeController.getChartData);

module.exports = router;
