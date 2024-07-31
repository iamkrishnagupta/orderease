import 'dart:convert';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/modules/cart/screens/cart_screen.dart';
import 'package:frontend/modules/home/screens/category_screen.dart';
import 'package:frontend/modules/home/screens/search_screen.dart';
import 'package:frontend/modules/welcome/welcome_screen.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/ui_components/custom_card.dart';
import 'package:frontend/ui_components/product_ratings.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final scrollController = ScrollController();

  final List<GlobalKey> navbarKeys = List.generate(5, (index) => GlobalKey());

  void navigateToSearchScreen(String query) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchScreen(searchItem: query)));
  }

  Future<List<Map<String, dynamic>>> fetchFoods() async {
    final url = Uri.parse('${GlobalVariables.baseUrl}/admin/get-products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.cast<Map<String, dynamic>>();
    } else {
      print('Error fetching data: ${response.statusCode}');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context, listen: false).user;
    final cart = Provider.of<CartProvider>(context, listen: false).cart;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('OrderEase'),
        backgroundColor: GlobalVariables.purple,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchFoods(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                final foods = snapshot.data!;
                return Column(
                  children: [
                    // Text('HI ${user}'),
                    // SizedBox(key: navbarKeys.first),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 35,
                              margin: const EdgeInsets.only(left: 5),
                              child: Material(
                                borderRadius: BorderRadius.circular(5),
                                elevation: 1,
                                child: TextFormField(
                                  onFieldSubmitted: navigateToSearchScreen,
                                  decoration: InputDecoration(
                                    prefixIcon: InkWell(
                                      onTap: () {},
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                          left: 6,
                                        ),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                          size: 23,
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        const EdgeInsets.only(top: 10),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.black38,
                                        width: 1,
                                      ),
                                    ),
                                    hintText: 'Search your favorite dish ..',
                                    hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Cart()));
                            },
                            child: Badge(
                              label: Text('${cart.length}'),
                              child: const Image(
                                height: 30,
                                width: 30,
                                image: AssetImage('assets/images/cartbag.png'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductRating()));
                              },
                              icon: const Icon(Icons.star_rate_rounded)),
                          const SizedBox(width: 10),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomeScreen()));
                              },
                              icon: const Icon(Icons.logout)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    CarouselSlider(
                      items: GlobalVariables.carouselImages.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) => Image.network(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.maxFinite,
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ),
                    ),
                    Container(
                      child: const Category(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Orderease Signature Food',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'See more',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2A977D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Display all food items here
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 4 : 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        final food = foods[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomCard(
                            id: food['_id'],
                            imageUrl: (food['imageurls'] != null &&
                                    food['imageurls'].isNotEmpty)
                                ? food['imageurls'][0]
                                : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0u1fuEEb5gSmGykuLt7FoFXyR_1O-_u1rSehjwOfAxQ&s',
                            categoryName: food['category'],
                            itemName: food['name'],
                            price: food['price'],
                            description: food['description'],
                            quantity: food['quantity'],
                            currency: '₹',
                            onTap: () {
                              CartProvider cartProvider =
                                  Provider.of(context, listen: false);
                              bool alreadyExists =
                                  cartProvider.itemAlreadyExists(food);
                              if (alreadyExists) {
                                cartProvider.removeProduct(food);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Item already exists in cart'),
                                  ),
                                );
                              } else {
                                cartProvider.addProduct(food);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Item added to cart successfully'),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
