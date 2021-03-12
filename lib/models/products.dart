class Products {
  int proid;
  String proname;
  String l2groupname;
  String l3groupname;
  String descriptions;

  Products(
      {this.proid,
        this.proname,
        this.l2groupname,
        this.l3groupname,
        this.descriptions});

  Products.fromJson(Map<String, dynamic> json) {
    proid = json['proid'];
    proname = json['proname'];
    l2groupname = json['l2groupname'];
    l3groupname = json['l3groupname'];
    descriptions = json['descriptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['proid'] = this.proid;
    data['proname'] = this.proname;
    data['l2groupname'] = this.l2groupname;
    data['l3groupname'] = this.l3groupname;
    data['descriptions'] = this.descriptions;
    return data;
  }
}