class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? photo;
  String? nid;
  String? creditCard;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.photo,
    this.nid,
    this.creditCard,
    this.token,
  });

  // function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      address: json['user']['address'],
      photo: json['user']['photo'],
      nid: json['user']['nid'],
      creditCard: json['user']['credit_card'],
      token: json['access_token'],
    );
  }
}
