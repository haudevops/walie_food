class NewsModel {
  NewsModel({this.status, this.data});

  bool? status;
  List<NewsInfoModel>? data;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'],
      data: (json['data'] != null)
          ? List<NewsInfoModel>.from(
              json['data'].map((x) => NewsInfoModel.fromJson(x)))
          : null,
    );
  }
}

class NewsInfoModel {
  NewsInfoModel({this.nameProduct, this.image, this.region, this.descriptions});

  String? nameProduct;
  String? image;
  String? region;
  String? descriptions;

  factory NewsInfoModel.fromJson(Map<String, dynamic> json) {
    return NewsInfoModel(
        nameProduct: json['nameProduct'],
        image: json['image'],
        region: json['region'],
        descriptions: json['descriptions']);
  }
}
