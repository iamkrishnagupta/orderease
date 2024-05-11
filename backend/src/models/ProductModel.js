const mongoose = require('mongoose');
const RatingSchema = require('./RatingSchema'); // Make sure this is pointing to the correct file

const productSchema = new mongoose.Schema({
    name: { type: String, required: true },
    description: { type: String, required: true, trim: true },
    quantity: { type: Number, required: true },
    price: { type: Number, required: true },
    category: { type: String, required: true },
    imageurls: [{ type: String, required: true }],
    ratings: [RatingSchema] // Embed the RatingSchema directly.
});

const Product = mongoose.model("Product", productSchema);
module.exports = Product;
