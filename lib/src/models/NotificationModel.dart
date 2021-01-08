class NotificationModel {
  String id;
  String title;
  String message;
  String createdAt;
  String image;
  bool seen;

  NotificationModel(
      {this.id,
      this.title,
      this.message,
      this.createdAt,
      this.image,
      this.seen});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    createdAt = json['createdAt'];
    image = json['image'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['image'] = this.image;
    data['seen'] = this.seen;
    return data;
  }
}

