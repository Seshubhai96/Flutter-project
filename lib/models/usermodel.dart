class Usermodel {
  String username;
  String useremail;
  String uid;
  String userphone;
  String useraddress;
  Usermodel(
      {this.uid,
      this.useraddress,
      this.useremail,
      this.username,
      this.userphone});
  factory Usermodel.fromJSON(Map<String, dynamic> map) {
    return Usermodel(
      uid: map['uid'],
      useraddress: map['useraddress'],
      useremail: map['useremail'],
      username: map['username'],
      userphone: map['userphone'],
    );
  }
  toMap() {
    return {
      'uid': uid,
      'username': username,
      'useremail': useremail,
      'userphone': userphone,
      'useraddress': useraddress,
    };
  }
}
