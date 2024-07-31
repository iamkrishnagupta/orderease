import 'package:flutter/material.dart';
import 'package:frontend/constants/category_utils.dart';
import 'package:frontend/modules/menu/screens/menu_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);
  final CategoryUtils category;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        (screenWidth - 24) / 2; // 24 = 12 (left padding) + 12 (right padding)

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuScreen(category: category.title)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 53,
              width: 53,
              decoration: BoxDecoration(
                color: const Color(0xffF6F6F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipOval(
                child: Image.asset(
                  category.image,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              category.title,
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
