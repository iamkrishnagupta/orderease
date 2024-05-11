const Cart = require('../models/CartModel');

exports.addToCart = async (req, res) => {
  const { name, quantity, category, imageurls } = req.body;
  try {
    const newProduct = new Cart({ name, quantity, category, imageurls });
    await newProduct.save();
    res.status(201).json({ message: 'Product added to cart successfully' });
  } catch (error) {
    console.error('Error adding product to cart:', error);
    res.status(500).json({ message: 'Error saving product to cart' });
  }
};
