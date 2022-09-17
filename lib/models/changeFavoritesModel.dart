class changeFavoritesModel {
  bool? status;
  String? message;

  changeFavoritesModel({this.status, this.message});

  changeFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}