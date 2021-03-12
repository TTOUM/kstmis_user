class Users {
  int uid;
  String username;
  String pass;
  String firstname;
  String lastname;
  Null position;
  Null createDate;
  Null lastLogin;

  Users(
      {this.uid,
      this.username,
      this.pass,
      this.firstname,
      this.lastname,
      this.position,
      this.createDate,
      this.lastLogin});

  Users.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    pass = json['pass'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    position = json['position'];
    createDate = json['create_date'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['pass'] = this.pass;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['position'] = this.position;
    data['create_date'] = this.createDate;
    data['last_login'] = this.lastLogin;
    return data;
  }
}
