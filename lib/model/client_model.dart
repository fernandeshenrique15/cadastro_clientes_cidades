import 'package:client_city/model/city_model.dart';

class ClientModel {
  int id;
  String name;
  String gender;
  int age;
  CityModel city;

  ClientModel(this.id, this.name, this.gender, this.age, this.city);

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      json["id"] as int,
      json["nome"] as String,
      json["sexo"] as String,
      json["idade"] as int,
      CityModel.fromJson(json["cidade"]),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != 0) 'id': id,
        'nome': name,
        'sexo': gender,
        'idade': age,
        'cidade': city.toJson(),
      };
}
