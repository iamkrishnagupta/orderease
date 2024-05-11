import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderedFoodScreen extends StatefulWidget {
  const OrderedFoodScreen({super.key});

  @override
  State<OrderedFoodScreen> createState() => _OrderedFoodScreenState();
}

class _OrderedFoodScreenState extends State<OrderedFoodScreen> {
  List<Map<String, dynamic>> _foods = [];
  bool _isLoading = true;

  Future<void> _fetchData() async {
    try {
      final url = Uri.parse('${GlobalVariables.baseUrl}/admin/get-order');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          _foods = data.cast<Map<String, dynamic>>();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  Future<void> _deleteItem(String foodId) async {
    try {
      final url = Uri.parse(
          '${GlobalVariables.baseUrl}/admin/delete-ordered-item/$foodId');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        setState(() {
          _foods.removeWhere((food) => food['_id'] == foodId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Food item served')),
        );
      } else {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final table = Provider.of<UserProvider>(context, listen: false).tableNumber;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _foods.isEmpty
              ? const Center(child: Text('No orders yet'))
              : ListView.builder(
                  itemCount: _foods.length,
                  itemBuilder: (context, index) {
                    final food = _foods[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(food['name'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Image.network(food['imageurls'][0],
                                height: 100, fit: BoxFit.cover),
                            Text('Category: ${food['category']}'),
                            Text('Quantity: ${food['quantity']}'),
                            Text('Customer name: $user'),
                            Text('Table number: $table'),
                            ElevatedButton(
                              onPressed: () => _deleteItem(food['_id']),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.teal, // foreground
                              ),
                              child: const Text('Food Served'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
