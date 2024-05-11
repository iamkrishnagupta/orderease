const express = require('express');
const adminController = require('../controllers/adminController');
const router = express.Router();

router.post('/saveItem', adminController.saveProduct);
router.get('/get-products', adminController.getProducts);
router.get('/get-order', adminController.getOrders);
router.delete('/delete-products/:id', adminController.deleteProduct);
router.delete('/delete-ordered-item/:id', adminController.deleteOrderedItem);

module.exports = router;
