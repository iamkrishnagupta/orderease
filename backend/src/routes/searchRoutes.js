const express = require('express');
const searchController = require('../controllers/searchController');
const router = express.Router();

router.get("/get-item/:name", searchController.findProductsByName);
router.post('/api/rate', searchController.rateProduct);
router.get('/api/get-ratings/:productId', searchController.getProductRatings);

module.exports = router;
