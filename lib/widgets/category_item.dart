import 'package:flutter/material.dart';
import '../views/detail_screen.dart'; 

class CategoryItem extends StatelessWidget {
  final IconData iconData;
  final String label;

  const CategoryItem({
    super.key,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(title: 'Kategori: $label')),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(iconData, size: 35, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}