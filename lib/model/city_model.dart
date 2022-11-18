class CityModel {
  int id;
  String name;
  String uf;

  CityModel(this.id, this.name, this.uf);

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
        json["id"] as int, json["nome"] as String, json["uf"] as String);
  }

  Map<String, dynamic> toJson() => {
        if (id != 0) 'id': id,
        'nome': name,
        'uf': uf,
      };
}
