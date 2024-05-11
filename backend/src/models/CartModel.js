const mongoose = require("mongoose");

const cartSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true }, // Trim whitespace
  quantity: { type: Number, required: true, min: 1 }, // Ensure at least 1 item
  category: { type: String, required: true, trim: true }, // Trim whitespace
  imageurls: [{ type: String, required: true }], // Array of image URLs
});

const Cart = mongoose.model("Cart", cartSchema);

module.exports = Cart;
