import 'package:client_city/api/accessApi.dart';
import 'package:client_city/help/combo_uf.dart';
import 'package:client_city/help/components.dart';
import 'package:client_city/model/city_model.dart';
import 'package:flutter/material.dart';

class CityAdd extends StatefulWidget {
  const CityAdd({super.key});

  @override
  State<CityAdd> createState() => _CityAddState();
}

class _CityAddState extends State<CityAdd> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtState = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CityModel;
    txtName.text = args.name;
    txtState.text = args.uf;

    save() {
      CityModel c = CityModel(args.id, txtName.text, txtState.text);
      AccessApi().saveCity(c.toJson());
      Navigator.of(context).pushReplacementNamed('/city');
    }

    empty() {
      null;
    }

    empty2(String teste) {
      null;
    }

    return Scaffold(
      body: Form(
        key: formController,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Icon(
                Icons.location_city,
                size: 90,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 50,
                  child: Components().createTextField("Nome", false,
                      TextInputType.text, txtName, "Digite o nome", context),
                ),
                Expanded(
                    flex: 50,
                    child: ComboUf(
                      controller: txtState,
                      search: empty2,
                      listAll: empty,
                      isFilter: false,
                      optEdit: args.uf,
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Components()
                      .createButton("Salvar", save, formController, context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
