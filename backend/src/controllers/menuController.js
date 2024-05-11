const Product = require('../models/ProductModel');

exports.getItemsByCategory = async (req, res) => {
  const { category } = req.query;
  try {
    const products = await Product.find({ category });
    res.json(products);
  } catch (error) {
    console.error('Error fetching products:', error);
    res.status(500).json({ error: "Internal server error" });
  }
};
