import 'dart:convert';
import 'package:client_city/model/city_model.dart';
import 'package:client_city/model/client_model.dart';
import 'package:http/http.dart' as http;

class AccessApi {
  final String server = 'https://api-clientes.fernandes.dev.br';
  final String teste = 'http://localhost:8080';

  Future<List<ClientModel>> listClients() async {
    String url = '$server/cliente';
    http.Response resposta = await http.get(Uri.parse(url));
    String jsonUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable list = jsonDecode(jsonUtf8);
    List<ClientModel> clients =
        List<ClientModel>.from(list.map((p) => ClientModel.fromJson(p)));
    return clients;
  }

  Future<List<ClientModel>> searchClients(int city) async {
    String url = '$server/cliente/cidade/$city';
    http.Response resposta = await http.get(Uri.parse(url));
    String jsonUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable list = jsonDecode(jsonUtf8);
    List<ClientModel> clients =
        List<ClientModel>.from(list.map((p) => ClientModel.fromJson(p)));
    return clients;
  }

  Future<void> saveClient(Map<String, dynamic> client) async {
    String url = '$server/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await http.post(Uri.parse(url), headers: headers, body: jsonEncode(client));
  }

  Future<void> alterClient(Map<String, dynamic> client) async {
    String url = '$server/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(client),
    );
  }

  Future<void> deleteClient(int id) async {
    String url = '$server/cliente/$id';
    await http.delete(Uri.parse(url));
  }

  Future<List<CityModel>> listCities() async {
    List<CityModel> cities = [];

    String url = '$server/cidade';
    http.Response resposta = await http.get(Uri.parse(url));
    if (resposta.statusCode == 200) {
      Iterable list = jsonDecode(utf8.decode(resposta.bodyBytes));
      cities = List<CityModel>.from(list.map((c) => CityModel.fromJson(c)));
    } else {
      // print(resposta.statusCode);
    }
    return cities;
  }

  Future<List<CityModel>> searchCities(String uf) async {
    List<CityModel> cities = [];

    String url = '$server/cidade/buscauf/$uf';
    http.Response resposta = await http.get(Uri.parse(url));
    if (resposta.statusCode == 200) {
      Iterable list = jsonDecode(utf8.decode(resposta.bodyBytes));
      cities = List<CityModel>.from(list.map((c) => CityModel.fromJson(c)));
    }
    return cities;
  }

  Future<void> saveCity(Map<String, dynamic> city) async {
    String url = '$server/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await http.post(Uri.parse(url), headers: headers, body: jsonEncode(city));
  }

  Future<void> alterCity(Map<String, dynamic> city) async {
    String url = '$server/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(city),
    );
  }

  Future<void> deleteCity(int id) async {
    String url = '$server/cidade/$id';
    await http.delete(Uri.parse(url));
  }
}
