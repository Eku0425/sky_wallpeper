import 'package:flutter/cupertino.dart';

import '../../helper/helper.dart';
import '../../helper/searchapi.dart';
import '../modal/wallpeperModal.dart';

class WallpaperProvider extends ChangeNotifier {
  WallpaperModel wallpaperModel = WallpaperModel.f();
  WallpaperModel wallpaperModelSerach = WallpaperModel.f();
  bool isLoading = false;

  Future<void> loadData() async {
    Map json = await ApiServices.apiServices.fetchData();
    wallpaperModel = WallpaperModel.fromJson(json);
    notifyListeners();
  }

  Future<void> searchData(String query) async {
    isLoading = true;
    Map json = await ApiSearch.apiSearch.fetchSearchData(query);
    wallpaperModelSerach = WallpaperModel.fromJson(json);
    isLoading = false;
    notifyListeners();
  }

  void listNull() {
    print(wallpaperModelSerach.hits);
    wallpaperModelSerach.hits = null;
    print(wallpaperModelSerach.hits);
    notifyListeners();
  }

  WallpaperProvider() {
    loadData();
  }
}
