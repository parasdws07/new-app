import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/user_controller.dart';
import 'package:get/get.dart';


class FavoritePage extends StatelessWidget {
  final UserController controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Users')),
      body: Obx(() {
        final favList = controller.favoriteUsers;
        if (favList.isEmpty) {
          return const Center(child: Text('No favorites yet'));
        }
        return ListView.builder(
          itemCount: favList.length,
          itemBuilder: (_, i) {
            final user = favList[i];
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
              title: Text('${user.firstName} ${user.lastName}'),
              subtitle: Text(user.email),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () => controller.toggleFavorite(user.id),
              ),
            );
          },
        );
      }),
    );
  }
}
