class HomeEntities {
  bool status;
  HomeData homeData;

  HomeEntities({required this.status, required this.homeData});

}


class HomeData {
    List<Banners> banners;
    List<ProductsModel> products;

    HomeData({required this.banners, required this.products});

    factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      banners: List<Banners>.from(json['banners'].map((e) => Banners.fromJson(e))),
      products: List<ProductsModel>.from(json['products'].map((e)=>ProductsModel.fromJson(e))),
    );
  }
}

class Banners{
  final int id;
  final String image;
  Banners({
    required this.id,
    required this.image
});

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id: json["id"],
      image: json["image"],
    );
  }
//
}

class ProductsModel{
   final int id ;
   final dynamic price ;
   final dynamic oldPrice ;
   final dynamic discount ;
   final String image ;
   final String name ;
   final String description ;
   final bool inFavorites ;
   final bool inCart ;

   ProductsModel({
     required this.id,
     required this.price,
     required this.oldPrice,
     required this.discount,
     required this.image,
     required this.name,
     required this.description,
     required this.inFavorites,
     required this.inCart,
});

   factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json["id"],
      price:json["price"],
      oldPrice: json["old_price"],
      discount:json["discount"],
      image: json["image"],
      name: json["name"],
      description: json["description"],
      inFavorites: json["in_favorites"],
      inCart: json["in_cart"],
    );
   }
}