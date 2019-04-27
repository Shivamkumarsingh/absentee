class User{
  String name;
  String school;
  String auth_Token;
  User({

    this.name,
    this.auth_Token,
    this.school
  });
  factory User.fromJson(Map<String, dynamic> parsedJson){
    return User(
        name : parsedJson['name'],
        school : parsedJson ['school'],
        auth_Token: parsedJson['auth_token'],

    );
  }

}
