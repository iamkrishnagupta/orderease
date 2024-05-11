import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/ui_components/add_food_custombutton.dart';
import 'package:frontend/ui_components/add_food_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  TextEditingController DishNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String? category;
  @override
  void initState() {
    super.initState();
    category =
        GlobalVariables.categories.first; 
  }
  List<File> images = [];

  Future<List<File>> pickImages() async {
    List<File> images = [];
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return images;
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  Future<void> sendData(String name, String description, double price,
      double quantity, String category, List<File> images) async {
    final cloudinaryKey = GlobalVariables.cloudinaryKey;
    final cloudinarySecret = GlobalVariables.cloudinarySecret;

    final cloudinary = CloudinaryPublic(cloudinaryKey, cloudinarySecret);
    List<String> imageUrls = [];
    for (int i = 0; i < images.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(images[i].path, folder: name),
      );
      imageUrls.add(res.secureUrl);
    }
    var url = Uri.parse('${GlobalVariables.baseUrl}/admin/saveItem');
    var body = jsonEncode({
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'imageurls': imageUrls
    });
    var response = await http.post(url, body: body, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
               backgroundColor: GlobalVariables.purple,

        title: const Text('Add Items'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text('Select item images : ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal)),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: selectImages,
                child: Container(
                  width: 500,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: images.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.file(
                                images[index],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        )
                      : const Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(height: 10),
              AddFoodCustomTextField(
                controller: DishNameController,
                hintText: 'Dish Name',
              ),
              const SizedBox(height: 10),
              AddFoodCustomTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 7,
              ),
              const SizedBox(height: 10),
              AddFoodCustomTextField(
                controller: priceController,
                hintText: 'Price',
              ),
              const SizedBox(height: 10),
              AddFoodCustomTextField(
                controller: quantityController,
                hintText: 'Quantity',
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  value: category,
                  onChanged: (String? newValue) {
                    setState(() {
                      category = newValue;
                    });
                  },
                  items: GlobalVariables.categories
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  isExpanded: true,
                ),
              ),
              const SizedBox(height: 10),
              AddFoodCustomButton(
                text: 'Add',
                color: Colors.teal,
                onTap: () {
                  // Add your logic to save the data here
                  String name = DishNameController.text;
                  String description = descriptionController.text;
                  double price = double.parse(priceController.text);
                  double quantity = double.parse(quantityController.text);
                  sendData(
                      name, description, price, quantity, category!, images);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
