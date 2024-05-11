const Data = require('../models/DataModel');

exports.sendData = async (req, res) => {
  const { name, email, userType, table } = req.body;
  try {
    const newData = new Data({ name, email, userType, table });
    await newData.save();
    res.status(201).json({ message: 'Data saved successfully', newData });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error saving data' });
  }
};
