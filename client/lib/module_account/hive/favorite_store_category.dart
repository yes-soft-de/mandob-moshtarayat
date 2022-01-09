import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/model/favorite_categories_model.dart';

@singleton
@injectable
class FavoriteHiveHelper {
  var box = Hive.box('Authorization');
  String favKey = 'FavoriteCategory';
  String favKeyImage = 'FavoriteCategoryImage';
  String favKeyName = 'FavoriteCategoryName';

  void setFavoriteCategory(String categoryID) {
    box.put(favKey, categoryID);
  }

  void setFavoriteCategoryInfo(String name, String image) {
    box.put(favKeyImage, image);
    box.put(favKeyName, name);
  }

  void setRoomID(String roomID) {
    box.put('supportRoomID', roomID);
  }

  String? getRoomID() {
    return box.get('supportRoomID');
  }

  String? getFavoriteCategory() {
    return box.get(favKey);
  }

  FavoriteStore? getFavoriteCategoryInfo() {
    return FavoriteStore(
      storeId: 0,
      storeName: box.get(favKeyName) ?? S.current.unknown,
      image: box.get(favKeyImage) ?? '',
    );
  }

  Future<void> clear() async {
    await box.delete(favKey);
    await box.delete(favKeyName);
    await box.delete(favKeyImage);
  }
}
