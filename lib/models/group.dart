class GroupCategory {
  int l2id;
  int businessid;
  String l2groupname;

  GroupCategory({this.l2id, this.businessid, this.l2groupname});

  GroupCategory.fromJson(Map<String, dynamic> json) {
    l2id = json['l2id'];
    businessid = json['businessid'];
    l2groupname = json['l2groupname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['l2id'] = this.l2id;
    data['businessid'] = this.businessid;
    data['l2groupname'] = this.l2groupname;
    return data;
  }
}
