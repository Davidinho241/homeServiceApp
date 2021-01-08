class WalletHistory {
  String title;
  String subtitle;
  int cash;
  String date;
  String type;

  WalletHistory({this.title, this.subtitle, this.cash, this.date, this.type});

  WalletHistory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    cash = json['cash'];
    date = json['date'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['cash'] = this.cash;
    data['date'] = this.date;
    data['type'] = this.type;
    return data;
  }
}

