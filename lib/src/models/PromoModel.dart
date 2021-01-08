class PromoModel {
  String id;
  String title;
  String createdAt;
  String expiredAt;
  String thumbnail;
  String content;

  PromoModel(
      {this.id,
      this.title,
      this.createdAt,
      this.expiredAt,
      this.thumbnail,
      this.content});

  PromoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    expiredAt = json['expired_at'];
    thumbnail = json['thumbnail'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['expired_at'] = this.expiredAt;
    data['thumbnail'] = this.thumbnail;
    data['content'] = this.content;
    return data;
  }
}
