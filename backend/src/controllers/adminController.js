const Product = require('../models/ProductModel');
const Cart = require('../models/CartModel');

exports.saveProduct = async (req, res) => {
  const { name, description, quantity, price, category, imageurls } = req.body;
  try {
    const newProduct = new Product({ name, description, quantity, price, category, imageurls });
    await newProduct.save();
    res.status(201).json({ message: 'Product saved successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error saving product' });
  }
};

exports.getProducts = async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

exports.getOrders = async (req, res) => {
  try {
    const orders = await Cart.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

exports.deleteProduct = async (req, res) => {
  try {
    const deletedProduct = await Product.findByIdAndDelete(req.params.id);
    if (!deletedProduct) {
      return res.status(404).json({ message: 'Product not found' });
    }
    res.status(200).json({ message: 'Product deleted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};

exports.deleteOrderedItem = async (req, res) => {
  try {
    const deletedItem = await Cart.findByIdAndDelete(req.params.id);
    if (!deletedItem) {
      return res.status(404).json({ message: 'Ordered item not found' });
    }
    res.status(200).json({ message: 'Ordered item deleted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};
