class Driver {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? photo;
  String? nid;
  String? drivingLicense;
  String? carNumber;
  String? carModel;
  String? carColor;
  String? creditCard;
  String? driverToken;

  Driver({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.photo,
    this.nid,
    this.drivingLicense,
    this.carNumber,
    this.carModel,
    this.carColor,
    this.creditCard,
    this.driverToken,
  });

  // function to convert json data to user model
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      address: json['user']['address'],
      photo: json['user']['photo'],
      nid: json['user']['nid'],
      drivingLicense: json['user']['driving_license'],
      carNumber: json['user']['car_number'],
      carModel: json['user']['car_model'],
      carColor: json['user']['car_color'],
      creditCard: json['user']['credit_card'],
      driverToken: json['access_token'],
    );
  }
}
