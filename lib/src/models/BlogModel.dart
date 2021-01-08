class Blog {
  String id;
  String thumbnail;
  String title;
  String date;
  String content;

  Blog({this.id, this.thumbnail, this.title, this.date, this.content});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    date = json['date'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumbnail'] = this.thumbnail;
    data['title'] = this.title;
    data['date'] = this.date;
    data['content'] = this.content;
    return data;
  }
}
