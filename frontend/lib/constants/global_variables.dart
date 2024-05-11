import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GlobalVariables {
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'http://localhost:3000';
  static String get cloudinaryKey => dotenv.env['CLOUDINARY_KEY'] ?? 'youKey';
  static String get cloudinarySecret =>
      dotenv.env['CLOUDINARY_SECRET'] ?? 'yourSecret';
  static const List<String> userTypes = ['User', 'Admin'];
  static const List<String> tableNumbers = [
    'Find your table?',
    'TBN_Q=TBID?A1',
    'TBN_Q=TBID?A2',
    'TBN_Q=TBID?A3',
    'TBN_Q=TBID?B1',
    'TBN_Q=TBID?B2',
    'TBN_Q=TBID?C1',
  ];
  static const List<String> carouselImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEHBkY7JxxZqIsmUreXZaZX8-lLlw8C67k4g&s'
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh4Sq3jYYD6oJA9q6uXz-7aFU16hHzwi3RyA&s'
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7pq6VRKjkySlbf77__2v1d-OePiS7eXU9Yw&s',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/special-food-deals-design-template-7f24f3eb9a58b24bbb102ce4849d0c6b_screen.jpg?ts=1663403350',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/special-food-deals-design-template-78fc67e986d2b6f9b6de15badac7afea_screen.jpg?ts=1647031791',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/special-food-deals-design-template-7f24f3eb9a58b24bbb102ce4849d0c6b_screen.jpg?ts=1663403350'
  ];

  static const List<String> categories = [
    'Desi Food',
    'Starters',
    'Beverage',
    'Desert',
    'Cake',
    'Chinese'
  ];
  static const String authLottieAnimation = 'assets/json/la1.json';
  static const String welcomeScreenAnimation = 'assets/json/welcome_screen.json';
  static const String waiterImage = 'assets/images/waiter.png';
  static const Color purple =Color.fromARGB(255, 225, 190, 231);
  static const Color purple2 =Color.fromARGB(255, 206, 147, 216);
  static const Color purple3 =Color.fromARGB(255, 186, 104, 200);
  static const Color purple4 =Color.fromARGB(255, 171, 71, 188);
 
}
