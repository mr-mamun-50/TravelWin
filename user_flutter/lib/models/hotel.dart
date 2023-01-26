class Hotel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? logo;
  int? numberOfRooms;
  String? creditCard;
  String? hotelToken;

  Hotel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.logo,
    this.numberOfRooms,
    this.creditCard,
    this.hotelToken,
  });

  // function to convert json data to user model
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      address: json['user']['address'],
      logo: json['user']['logo'],
      numberOfRooms: json['user']['number_of_rooms'],
      creditCard: json['user']['credit_card'],
      hotelToken: json['access_token'],
    );
  }
}
