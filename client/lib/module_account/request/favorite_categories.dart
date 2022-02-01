class FavoriteCategoriesRequest {
  List<String>? favouriteCategories;

  FavoriteCategoriesRequest({this.favouriteCategories});

  factory FavoriteCategoriesRequest.fromJson(Map<String, dynamic> json) {
    return FavoriteCategoriesRequest(
      favouriteCategories: json['favouriteCategories'] as List<String>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'favouriteCategories': favouriteCategories,
      };
}
