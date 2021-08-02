class User {
  String title;
  String body;
  int userId;
  int id;
  User({this.body,this.id,this.title,this.userId});
  factory User.fromJSON(Map<dynamic,dynamic>map){
    return User(
      title: map['title'],
      body: map['body'],
      userId: map['userId'],
      id: map['id'],
    );
  }
  toMap(){
    return{
      "id":id,
      "tite":title,
      "userid":userId,
      "body":body,
    };
  }
}