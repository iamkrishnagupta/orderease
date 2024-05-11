import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/modules/admin/screens/admin_screen.dart';
import 'package:frontend/modules/home/screens/home_screen.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/ui_components/custom_button.dart';
import 'package:frontend/ui_components/custom_snackbar.dart';
import 'package:frontend/ui_components/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  String _selectedTableNumber = GlobalVariables.tableNumbers[0];
  String userType = GlobalVariables.userTypes[0];

  Future<void> sendData(
      String name, String mobile, String userType, String table) async {
    var url = Uri.parse('${GlobalVariables.baseUrl}/api/sendData');
    var body = jsonEncode(
        {'name': name, 'mobile': mobile, 'userType': userType, 'table': table});
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body);
    if (response.statusCode == 200) {
      debugPrint('Data sent successfully!');
    } else {
      debugPrint('Failed to send data!');
    }
  }

  void showPasswordDialog() {
    final TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Password'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (passwordController.text.trim() ==
                  dotenv.env['ADMIN_PASSWORD']) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminScreen()));
              } else {
                CustomSnackbar.show(context, 'Incorrect password!');
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Lottie.asset(GlobalVariables.authLottieAnimation,
                height: 200, width: 200),
            const SizedBox(height: 10),
            const Text(
              'Your gateway to deliciousness!',
              style: TextStyle(
                color: GlobalVariables.purple4,
                fontFamily: 'Raleway',
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _nameController,
                            hint: 'Name',
                            icon: Icons.person),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _mobileController,
                          hint: 'Mobile Number',
                          icon: Icons.phone,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: userType,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: const Icon(Icons.person),
                          ),
                          items: GlobalVariables.userTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => userType = value!),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _selectedTableNumber,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: const Icon(Icons.restaurant_menu),
                          ),
                          items:
                              GlobalVariables.tableNumbers.map((String number) {
                            return DropdownMenuItem<String>(
                              value: number,
                              child: Text(number),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _selectedTableNumber = value!),
                        ),
                        const SizedBox(height: 35),
                        CustomButton(
                          text: 'Continue...',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              sendData(
                                  _nameController.text,
                                  _mobileController.text,
                                  userType,
                                  _selectedTableNumber);
                              if (userType == 'Admin') {
                                showPasswordDialog();
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()));
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .addUser(_nameController.text);
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .addTable(_selectedTableNumber);
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 120),
            const Text(
              '© 2024 OrderEase. All rights reserved.',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Raleway',
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
