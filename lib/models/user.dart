class User {
  String name;
  String email;

  User({this.name, this.email});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];
}
