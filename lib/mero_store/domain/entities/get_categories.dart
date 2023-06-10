class GetCategoriesEntities {
  final bool status;
  GetCategoriesData getCategoriesData;

  GetCategoriesEntities({required this.status,required this.getCategoriesData});
}

class GetCategoriesData{
  final dynamic currentPage;
  List <CategoriesData> categoriesData;

  GetCategoriesData({required this.currentPage,required this.categoriesData});

  factory GetCategoriesData.fromJson(Map<String, dynamic> json) {
    return GetCategoriesData(
      currentPage:json["currentPage"],
      categoriesData: List<CategoriesData>.from(json['data'].map((e)=>CategoriesData.fromJson(e))).toList()
    );
  }
//
}

class CategoriesData{
  final int id;
  final String name;
  final String image;

  CategoriesData({required this.id,required this.name,required this.image});

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
      id:json["id"],
      name: json["name"],
      image: json["image"],
    );
  }
//
}