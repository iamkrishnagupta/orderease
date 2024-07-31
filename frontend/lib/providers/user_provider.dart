import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String user = ''; // Initialize the user variable
  String tableNumber = '';

  void addUser(String name) {
    user += name; // Append the new name to the user string
    notifyListeners();
  }

  void addTable(String tableNumber) {
    tableNumber += tableNumber; // Append the new name to the user string
    notifyListeners();
  }

  void removeUser(String name) {
    user = user.replaceAll(
        name, ''); // Remove the specified name from the user string
    notifyListeners();
  }

  void removeTable(String name) {
    tableNumber = tableNumber.replaceAll(
        tableNumber, ''); // Remove the specified name from the user string
    notifyListeners();
  }
}
