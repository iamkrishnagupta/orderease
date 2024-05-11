const mongoose = require("mongoose");

// Define the schema for a rating.
const ratingSchema = new mongoose.Schema({
    // userId: {
    //     type: mongoose.Schema.Types.ObjectId,
    //     ref: 'User', // This should point to the collection name of the user model.
    //     required: true
    // },
    rating: {
        type: Number,
        required: true,
        min: 1, // Optional: minimum value
        max: 5  // Optional: maximum value
    },
    comment: {
        type: String,
        trim: true // Trim whitespace from both ends of the comment.
    }
});

module.exports = ratingSchema;
