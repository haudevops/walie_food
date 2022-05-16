class SocialModel {
  SocialModel({this.status, this.data});

  bool? status;
  List<SocialInfoModel>? data;

  factory SocialModel.fromJson(Map<String, dynamic> json) {
    return SocialModel(
      status: json['status'],
      data: (json['data'] != null)
          ? List<SocialInfoModel>.from(
              json['data'].map((x) => SocialInfoModel.fromJson(x)))
          : null,
    );
  }
}

class SocialInfoModel {
  SocialInfoModel({this.nameProduct, this.image, this.descriptions});

  String? nameProduct;
  String? image;
  String? descriptions;

  factory SocialInfoModel.fromJson(Map<String, dynamic> json) {
    return SocialInfoModel(
        nameProduct: json['nameProduct'],
        image: json['image'],
        descriptions: json['descriptions']);
  }
}
