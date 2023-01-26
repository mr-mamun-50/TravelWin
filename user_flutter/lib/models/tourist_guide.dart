import 'dart:ffi';

class TouristGuide {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? photo;
  String? nid;
  String? serviceArea;
  String? serviceAreaLat;
  String? serviceAreaLng;
  String? rentPerHour;
  String? creditCard;
  String? guideToken;

  TouristGuide({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.photo,
    this.nid,
    this.serviceArea,
    this.serviceAreaLat,
    this.serviceAreaLng,
    this.rentPerHour,
    this.creditCard,
    this.guideToken,
  });

  // function to convert json data to user model
  factory TouristGuide.fromJson(Map<String, dynamic> json) {
    return TouristGuide(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      address: json['user']['address'],
      photo: json['user']['photo'],
      nid: json['user']['nid'],
      serviceArea: json['user']['service_area'],
      serviceAreaLat: json['user']['service_area_lat'],
      serviceAreaLng: json['user']['service_area_lng'],
      rentPerHour: json['user']['rent_per_hour'],
      creditCard: json['user']['credit_card'],
      guideToken: json['access_token'],
    );
  }
}
