class UfModel {
  int id;
  String name;

  UfModel(this.id, this.name);

  factory UfModel.fromJson(Map<String, dynamic> json) {
    return UfModel(json["id"] as int, json["nome"] as String);
  }

  Map<String, dynamic> toJson() => {
        if (id != 0) 'id': id,
        'nome': name,
      };
}
