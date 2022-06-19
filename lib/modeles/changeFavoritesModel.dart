class ChangeFavoritesModel {
  late bool status;
  late String message;
  ChangeFavoritesModel.fromJson(json) {
    status = json['status'];
    message = json['message'];
  }
}
