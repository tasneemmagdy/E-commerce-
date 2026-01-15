class ProductModel {
  List<ProductsDataModel>? products;
  int? total;
  int? skip;
  int? limit;

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = (json['products'] as List)
          .map((e) => ProductsDataModel.fromJson(e))
          .toList();
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}

class ProductsDataModel {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  DimensionsModel? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<ReviewsModel>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  MetaModel? meta;
  List<String>? images;
  String? thumbnail;
  bool inFavorites = false;

  ProductsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = (json['price'] as num?)?.toDouble();
    discountPercentage = (json['discountPercentage'] as num?)?.toDouble();
    rating = (json['rating'] as num?)?.toDouble();
    stock = json['stock'];
    tags = json['tags'] != null ? List<String>.from(json['tags']) : null;
    brand = json['brand'];
    sku = json['sku'];
    dimensions = json['dimensions'] != null
        ? DimensionsModel.fromJson(json['dimensions'])
        : null;
    warrantyInformation = json['warrantyInformation'];
    shippingInformation = json['shippingInformation'];
    availabilityStatus = json['availabilityStatus'];
    reviews = json['reviews'] != null
        ? (json['reviews'] as List)
        .map((e) => ReviewsModel.fromJson(e))
        .toList()
        : null;
    returnPolicy = json['returnPolicy'];
    minimumOrderQuantity = json['minimumOrderQuantity'];
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    thumbnail = json['thumbnail'];
    inFavorites =false;
  }
}


class DimensionsModel {
  double? width;
  double? height;
  double? depth;

  DimensionsModel.fromJson(Map<String, dynamic> json) {
    width = (json['width'] as num?)?.toDouble();
    height = (json['height'] as num?)?.toDouble();
    depth = (json['depth'] as num?)?.toDouble();
  }
}

class ReviewsModel {
  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  ReviewsModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    reviewerName = json['reviewerName'];
    reviewerEmail = json['reviewerEmail'];
  }
}

class MetaModel {
  String? createdAt;
  String? updatedAt;
  String? barcode;
  String? qrCode;

  MetaModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    barcode = json['barcode'];
    qrCode = json['qrCode'];
  }
}
