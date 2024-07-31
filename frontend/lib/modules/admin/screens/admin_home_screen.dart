import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/modules/admin/screens/add_food_screen.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:frontend/ui_components/custom_card.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<Map<String, dynamic>> _foods = [];
  bool _isLoading = true;

  Future<void> _fetchData() async {
    final url = Uri.parse('${GlobalVariables.baseUrl}/admin/get-products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          _foods = data.cast<Map<String, dynamic>>();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch foods');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<void> _deleteItem(String foodId) async {
    final url =
        Uri.parse('${GlobalVariables.baseUrl}/admin/delete-products/$foodId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        setState(() {
          _foods.removeWhere((food) => food['_id'] == foodId);
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Food item deleted')));
      } else {
        throw Exception('Failed to delete food');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: GlobalVariables.purple,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _foods.isEmpty
              ? const Center(child: Text('No products found'))
              : buildGridView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddFood())),
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Responsive grid layout
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: _foods.length,
      itemBuilder: (context, index) {
        final food = _foods[index];
        return CustomCard(
          imageUrl: (food['imageurls'] != null && food['imageurls'].isNotEmpty)
              ? food['imageurls'][0]
              : 'https://via.placeholder.com/150',
          categoryName: food['category'],
          itemName: food['name'],
          price: food['price'],
          description: food['description'],
          quantity: food['quantity'],
          id: food['_id'],
          currency: '₹',
          onTap: () => handleCartOperation(context, food),
        );
      },
    );
  }

  void handleCartOperation(BuildContext context, Map<String, dynamic> food) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    bool alreadyExists = cartProvider.itemAlreadyExists(food);
    if (alreadyExists) {
      cartProvider.removeProduct(food);
      showSnackbar(context, 'Item removed from cart');
    } else {
      cartProvider.addProduct(food);
      showSnackbar(context, 'Item added to cart successfully');
    }
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
