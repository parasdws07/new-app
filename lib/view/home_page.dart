import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/user_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  // Get the controller instance using Get.find to avoid duplicate instances
  final UserController controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: const Text('All Users'),
  actions: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // rounded corners
          ),
        ),
        onPressed: () {
          // Navigate to FavoritePage
          Get.toNamed('/favorites');
        },
        icon: const Icon(Icons.favorite, color: Colors.white),
        label: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ],
),

      body: Obx(() {
        // Show loading indicator while API data is being fetched
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // ListView.builder to show all users
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (_, i) {
            final user = controller.users[i];

            // Each ListTile wrapped in Obx to make favorite icon reactive
            return Obx(() {
              final isFav = controller.favorites.contains(user.id);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ),
                title: Text('${user.firstName} ${user.lastName}'),
                subtitle: Text(user.email),
                trailing: IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    // Toggle favorite status on icon click
                    controller.toggleFavorite(user.id);
                  },
                ),
              );
            });
          },
        );
      }),
    );
  }
}
