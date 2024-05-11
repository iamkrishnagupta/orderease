const mongoose = require('mongoose');

const dataSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true },
  userType: { type: String, required: true },
  table: { type: String, required: true }
});

const Data = mongoose.model('Data', dataSchema);
module.exports = Data;
