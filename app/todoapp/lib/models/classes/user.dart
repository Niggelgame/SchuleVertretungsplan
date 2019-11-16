


class User {
  String username;
  String lastname;
  String firstname;
  String email;
  String password;
  String apikey;
  int id;

  User(this.username, this.lastname, this.firstname, this.email, this.password, this.apikey, this.id);

  factory User.fromJson(Map<String, dynamic> parsedJson){
    return User(
      parsedJson['username'],
      parsedJson['lastname'],
      parsedJson['firstname'],
      parsedJson['emailadress'],
      parsedJson['password'],
      parsedJson['api_key'],
      parsedJson['id']
    );
  }
}