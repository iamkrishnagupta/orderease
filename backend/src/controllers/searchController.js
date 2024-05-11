const Product = require('../models/ProductModel');
const express = require('express');
const expressJson = express.json();


// Get all products by name
exports.findProductsByName = async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" }
    });
    res.json(products);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal server error" });
  }
};

// Submit product ratings
exports.rateProduct = async (req, res) => {
  const { productId, rating, comment } = req.body;
  try {
    const product = await Product.findById(productId);
    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }
    product.ratings.push({ rating, comment });
    await product.save();
    res.status(200).json({ message: 'Rating saved successfully' });
  } catch (error) {
    console.error('Error saving rating:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

// Get product ratings
exports.getProductRatings = async (req, res) => {
  const { productId } = req.params;

  try {
    const product = await Product.findById(productId);
    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }
    res.status(200).json(product.ratings);
  } catch (error) {
    console.error('Error fetching ratings:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};
