import 'package:flutter/material.dart';
import 'package:frontend/constants/category_utils.dart';
import 'package:frontend/ui_components/category_card.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
      // Consider defining your colors in the app's theme to maintain consistency and make changes easier
      color: Theme.of(context)
          .colorScheme
          .background, 
      child: Column(
        children: [
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth:
                    900), // Ensuring the content does not exceed 900px in width
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10), 
                child: Wrap(
                  spacing: 10, 
                  runSpacing: 20,
                  children: List.generate(
                    categoryUtils.length,
                    (i) => CategoryCard(category: categoryUtils[i]),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
