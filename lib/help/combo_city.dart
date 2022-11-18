import 'package:flutter/material.dart';
import 'package:client_city/api/accessApi.dart';
import 'package:client_city/model/city_model.dart';

class ComboCity extends StatefulWidget {
  TextEditingController? controller;

  ComboCity({Key? key, this.controller}) : super(key: key);

  @override
  State<ComboCity> createState() => _ComboCityState();
}

class _ComboCityState extends State<ComboCity> {
  int? cidadesel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1))
          .then((value) => AccessApi().listCities()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<CityModel> cities = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButton(
                isExpanded: true,
                value: cidadesel,
                icon: const Icon(Icons.arrow_downward),
                hint: const Text('Selecione uma cidade...'),
                elevation: 16,
                onChanged: (int? value) {
                  setState(() {
                    cidadesel = value;
                    widget.controller?.text = "$value";
                  });
                },
                items: cities.map<DropdownMenuItem<int>>((CityModel cid) {
                  return DropdownMenuItem<int>(
                      value: cid.id, child: Text('${cid.name}/${cid.uf}'));
                }).toList()),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [CircularProgressIndicator(), Text('Carregando')],
          );
        }
      },
    );
  }
}
