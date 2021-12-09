import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/module_account/hive/favorite_store_category.dart';
import 'package:mandob_moshtarayat/module_account/request/favorite_categories.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/favourite_screen.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';

class FavoriteLoadedState extends States {
  FavoritScreenState screenState;
  List<StoreCategoryModel> categories;
  FavoriteLoadedState(this.screenState, {required this.categories})
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: getFavorite(),
        ),
      ),
    );
  }

  List<Widget> getFavorite() {
    List<Widget> widgets = [];
    categories.forEach((element) {
      widgets.add(GestureDetector(
        onTap: () {
          getIt<FavoriteHiveHelper>().setFavoriteCategoryInfo(element.storeCategoryName, element.image); 
          screenState.updateCategories(FavoriteCategoriesRequest(
            favouriteCategories: [element.id.toString()],
          ));
        },
        child: Container(
          width: 125,
          height: 125,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          key: ValueKey(element.id),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CustomNetworkImage(
                        height: 125, width: 125, imageSource: element.image),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.maxFinite,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Theme.of(screenState.context)
                                .primaryColor
                                .withOpacity(0.95),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(25),
                            )),
                        child: Center(
                            child: Text(
                          element.storeCategoryName,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                      )),
                ],
              ),
            ),
          ),
        ),
      ));
    });
    widgets.add(const SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
