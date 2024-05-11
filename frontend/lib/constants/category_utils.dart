class CategoryUtils {
  final String image;
  final String title;
  final String subtitle;

  CategoryUtils({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

List<CategoryUtils> categoryUtils = [
  CategoryUtils(
      image: "assets/images/starters.jpeg",
      title: 'Starters',
      subtitle: 'Kickstart your meal with delightful appetizers!'),
  CategoryUtils(
      image: 'assets/images/beverages.jpg',
      title: 'Beverages',
      subtitle: 'Quench your thirst with our refreshing drinks!'),
  CategoryUtils(
      image: "assets/images/desi.jpeg",
      title: 'Desi Food',
      subtitle: 'Dive into the rich flavors of traditional cuisine!'),
  CategoryUtils(
      image: "assets/images/cakes.jpeg",
      title: 'Cakes',
      subtitle: 'Celebrate your moments with our delicious cakes!'),
  CategoryUtils(
      image: "assets/images/chinese.jpeg",
      title: 'Chinese',
      subtitle: 'Explore the authentic tastes of Chinese dishes!'),
  CategoryUtils(
      image: "assets/images/dessert.jpeg",
      title: 'Desserts',
      subtitle: 'Indulge in our sweet and tempting desserts!'),
  // CategoryUtils(
  //     image: "assets/images/platter.jpg",
  //     title: 'Platters',
  //     subtitle: 'Enjoy a variety of flavors in one platter!'),
];

final cart = [
  {
    'image': "assets/images/cakes.jpeg",
    'title': 'Cakes',
    'subtitle': 'Celebrate your moments with our delicious cakes!'
  }
];
