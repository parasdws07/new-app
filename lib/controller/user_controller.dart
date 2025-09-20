import 'package:flutter_application_1/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import '../services/api_service.dart';

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var favorites = <int>[].obs; // store IDs only
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
    fetchUsers();
  }

  void fetchUsers() async {
    isLoading.value = true;
    try {
      users.value = await ApiService.fetchUsers();
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFavorite(int id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    saveFavorites();
  }

  void saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('fav_ids', favorites.map((e) => e.toString()).toList());
  }

  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('fav_ids') ?? [];
    favorites.value = ids.map((e) => int.parse(e)).toList();
  }

  List<UserModel> get favoriteUsers =>
      users.where((u) => favorites.contains(u.id)).toList();
}
