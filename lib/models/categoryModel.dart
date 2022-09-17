class categoryModel {
  bool? status;
  CategoriesData? data;

  categoryModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CategoriesData.fromJson(json['data']) : null;
  }
}

class CategoriesData {
  int? currentPage;
  List<DataCategoryModel> data = [];

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataCategoryModel.fromJson(element));
    });
  }
}

class DataCategoryModel {
  dynamic id;
  dynamic name;
  String? image;

  DataCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
