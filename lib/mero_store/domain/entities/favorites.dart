class FavoritesEntities{
  final bool status;
  GetFavoritesBigData getFavoritesBigData;

  FavoritesEntities({required this.status, required this.getFavoritesBigData});

}

  class GetFavoritesBigData{
     final dynamic currentPage;
     List<FavoritesData> listFavoritesData;
     GetFavoritesBigData({required this.currentPage, required this.listFavoritesData});

     factory GetFavoritesBigData.fromJson(Map<String, dynamic> json) {
    return GetFavoritesBigData(
      currentPage: json["currentPage"],
      listFavoritesData: List<FavoritesData>.from(json['data'].map((e)=>FavoritesData.fromJson(e))).toList()
    );
  }
//
}

  class FavoritesData{
    final int id;
    FavoritesDataProduct favoritesDataProduct;
    FavoritesData({required this.id,required this.favoritesDataProduct});

    factory FavoritesData.fromJson(Map<String, dynamic> json) {
    return FavoritesData(
      id: json["id"],
      favoritesDataProduct: FavoritesDataProduct.fromJson(json["product"]),
    );
    }
//
}

  class FavoritesDataProduct {
    final int productId;
    final dynamic price;
    final dynamic oldPrice;
    final dynamic discount;
    final String image ;
    final String name ;
    final String description ;

    FavoritesDataProduct({
      required this.productId,
      required this.price,
      required this.oldPrice,
      required this.discount,
      required this.image,
      required this.name,
      required this.description,
  });

    factory FavoritesDataProduct.fromJson(Map<String, dynamic> json) {
      return FavoritesDataProduct(
        productId: json["id"],
        price:json["price"],
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
      );
    }

  }