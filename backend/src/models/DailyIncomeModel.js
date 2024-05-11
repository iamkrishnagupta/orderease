const mongoose = require('mongoose');

const dailyIncomeSchema = new mongoose.Schema({
  date: { type: Date, required: true },
  income: { type: Number, required: true }
});

const DailyIncome = mongoose.model('DailyIncome', dailyIncomeSchema);
module.exports = DailyIncome;
