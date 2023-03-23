abstract class UserInfoModel {
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

  Map<String, dynamic> toJSON() => {
        "name": name,
        "surname": surname,
        "telephone": telephone,
        "address": address,
      };
}
