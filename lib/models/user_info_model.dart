class UserInfoModel {
  String name;
  String surname;
  String telephone;
  String address;

  UserInfoModel({
    required this.name,
    required this.surname,
    required this.telephone,
    required this.address,
  });

  factory UserInfoModel.fromJSON(Map<String, dynamic> json) => UserInfoModel(
        name: json['name'],
        surname: json['surname'],
        telephone: json['telephone'],
        address: json['address'],
      );

  Map<String, dynamic> toJSON() => {
        "name": name,
        "surname": surname,
        "telephone": telephone,
        "address": address,
      };
}
