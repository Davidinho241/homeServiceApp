class Hotel {
  String id;
  String name;
  String location;
  String fullLocation;
  int price;
  int discountPrice;
  String discountText;
  String rating;
  String thumbnail;
  List<Pictures> pictures;
  List<Reviews> reviews;
  List<Rooms> rooms;
  List<Facilities> facilities;
  String description;
  double latitude;
  double longitude;

  Hotel(
      {this.id,
      this.name,
      this.location,
      this.fullLocation,
      this.price,
      this.discountPrice,
      this.discountText,
      this.rating,
      this.thumbnail,
      this.pictures,
      this.reviews,
      this.rooms,
      this.facilities,
      this.description,
      this.latitude,
      this.longitude});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    fullLocation = json['full_location'];
    price = json['price'];
    discountPrice = json['discount_price'];
    discountText = json['discount_text'];
    rating = json['rating'];
    thumbnail = json['thumbnail'];
    if (json['pictures'] != null) {
      pictures = new List<Pictures>();
      json['pictures'].forEach((v) {
        pictures.add(new Pictures.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    if (json['rooms'] != null) {
      rooms = new List<Rooms>();
      json['rooms'].forEach((v) {
        rooms.add(new Rooms.fromJson(v));
      });
    }
    if (json['facilities'] != null) {
      facilities = new List<Facilities>();
      json['facilities'].forEach((v) {
        facilities.add(new Facilities.fromJson(v));
      });
    }
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['full_location'] = this.fullLocation;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['discount_text'] = this.discountText;
    data['rating'] = this.rating;
    data['thumbnail'] = this.thumbnail;
    if (this.pictures != null) {
      data['pictures'] = this.pictures.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    if (this.rooms != null) {
      data['rooms'] = this.rooms.map((v) => v.toJson()).toList();
    }
    if (this.facilities != null) {
      data['facilities'] = this.facilities.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Pictures {
  String id;
  String url;
  String caption;

  Pictures({this.id, this.url, this.caption});

  Pictures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['caption'] = this.caption;
    return data;
  }
}

class Reviews {
  String id;
  String avatar;
  String name;
  String comment;
  int rating;
  String createdAt;

  Reviews(
      {this.id,
      this.avatar,
      this.name,
      this.comment,
      this.rating,
      this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    name = json['name'];
    comment = json['comment'];
    rating = json['rating'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Rooms {
  String id;
  String name;
  String bed;
  String description;
  int price;
  int discountPrice;
  String discountText;
  String thumbnail;
  List<String> pictures;
  List<String> facilities;

  Rooms(
      {this.id,
      this.name,
      this.bed,
      this.description,
      this.price,
      this.discountPrice,
      this.discountText,
      this.thumbnail,
      this.pictures,
      this.facilities});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bed = json['bed'];
    description = json['description'];
    price = json['price'];
    discountPrice = json['discount_price'];
    discountText = json['discount_text'];
    thumbnail = json['thumbnail'];
    pictures = json['pictures'].cast<String>();
    facilities = json['facilities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bed'] = this.bed;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['discount_text'] = this.discountText;
    data['thumbnail'] = this.thumbnail;
    data['pictures'] = this.pictures;
    data['facilities'] = this.facilities;
    return data;
  }
}

class Facilities {
  String name;
  String icon;

  Facilities({this.name, this.icon});

  Facilities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}
