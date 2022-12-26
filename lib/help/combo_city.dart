import 'package:flutter/material.dart';
import 'package:client_city/api/accessApi.dart';
import 'package:client_city/model/city_model.dart';

// ignore: must_be_immutable
class ComboCity extends StatefulWidget {
  TextEditingController? controller;
  int? optEdit;

  ComboCity({Key? key, this.controller, this.optEdit}) : super(key: key);

  @override
  State<ComboCity> createState() => _ComboCityState();
}

class _ComboCityState extends State<ComboCity> {
  int? cidadesel;

  @override
  Widget build(BuildContext context) {
    // if editing select the city
    if (widget.optEdit != 0) {
      cidadesel = widget.optEdit;
    }

    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1))
          .then((value) => AccessApi().listCities()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<CityModel> cities = snapshot.data;
          return Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 4, right: 2),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                ),
                isExpanded: true,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
                value: cidadesel,
                icon: const Icon(Icons.arrow_downward),
                hint: Text(
                  'Selecione uma cidade...',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
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
