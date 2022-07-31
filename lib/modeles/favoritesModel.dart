class Favorite {
  bool? status;

  Data? data;

  Favorite.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<DataInfo>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataInfo>[];
      json['data'].forEach((v) {
        data!.add(DataInfo.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class DataInfo {
  int? id;
  Product? product;

  DataInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

// class FavoriteModel {
//   late bool status;
//   late Data data;
//   FavoriteModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = Data.fromJson(json['data']);
//   }
// }

// class Data {
//   late int currentPage;
//   // late String first_page_url;

//   List<Datainfo> data = [];
//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     json['data'].forEach((element) {
//       data.add(Datainfo.fromJson(element));
//     });
//   }
// }

// class Datainfo {
//   late int id;
//   List<Product> product = [];
//   Datainfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     json['product'].forEach((element) {
//       product.add(Product.fromJson(element));
//     });
//   }
// }

// class Product {
//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
// }
