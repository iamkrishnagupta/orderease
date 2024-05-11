require('dotenv').config();

const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

// Import routes from the structured paths
const adminRoutes = require('./src/routes/adminRoutes');
const userDataRoutes = require('./src/routes/userDataRoutes');
const menuRoutes = require('./src/routes/menuRoutes');
const searchRoutes = require('./src/routes/searchRoutes');
const cartRoutes = require('./src/routes/cartRoutes');
const incomeRoutes = require('./src/routes/incomeRoutes');

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Use express built-in body parser middleware to parse JSON bodies
app.use(express.json());



// MongoDB Connection
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Database connection successful'))
  .catch((error) => console.error('Error connecting to database:', error));

// Use routes
app.use('/admin', adminRoutes);
app.use('/userDataRoutes', userDataRoutes);
app.use('/menu', menuRoutes);
app.use('/search', searchRoutes);
app.use('/cart', cartRoutes);
app.use('/income', incomeRoutes);

// Generic error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send({ error: 'Internal Server Error' });
});

// Start the server
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
