const DailyIncome = require('../models/DailyIncomeModel');

exports.saveDailyIncome = async (req, res) => {
  const { date, income } = req.body;
  try {
    let existingRecord = await DailyIncome.findOne({ date });

    if (existingRecord) {
      existingRecord.income += income;
      await existingRecord.save();
    } else {
      await DailyIncome.create({ date, income });
    }

    res.status(200).json({ message: 'Daily income saved successfully' });
  } catch (error) {
    console.error('Error saving daily income:', error);
    res.status(500).json({ error: 'Failed to save daily income' });
  }
};

exports.getChartData = async (req, res) => {
  try {
    const data = await DailyIncome.find();
    res.json(data);
  } catch (error) {
    console.error('Error fetching chart data:', error);
    res.status(500).json({ error: 'Failed to fetch chart data' });
  }
};
