import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/task_page.dart';

class CategoriesLoadedView extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final void Function(BuildContext) addCategory;

  const CategoriesLoadedView({
    required this.categories,
    required this.addCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemCount: categories.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildAddButton(context);
        }
        return _buildCategoryTile(context, categories[index - 1]);
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () => addCategory(context),
        icon: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryTile(
      BuildContext context, Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskPage(category: category),
            ));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category['emoji'] ?? '',
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 8),
            Text(
              category['name'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "${(category['tasks'] as List?)?.length ?? 0} tasks",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
