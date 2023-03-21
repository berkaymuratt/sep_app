class UserInfoModel {
  String name;
  String surname;
  int age;
  String telephone;
  String address;

  UserInfoModel({
    required this.name,
    required this.surname,
    required this.age,
    required this.telephone,
    required this.address,
  });

  factory UserInfoModel.fromJSON(Map<String, dynamic> json) => UserInfoModel(
        name: json['name'],
        surname: json['surname'],
        age: json['age'],
        telephone: json['telephone'],
        address: json['address'],
      );

  Map<String, dynamic> toJSON() => {
        "name": name,
        "surname": surname,
        "age": age,
        "telephone": telephone,
        "address": address,
      };
}
