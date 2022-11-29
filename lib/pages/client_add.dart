import 'package:client_city/api/accessApi.dart';
import 'package:client_city/help/combo_city.dart';
import 'package:client_city/help/components.dart';
import 'package:client_city/help/radio_gender.dart';
import 'package:client_city/model/city_model.dart';
import 'package:client_city/model/client_model.dart';
import 'package:flutter/material.dart';

class ClientAdd extends StatefulWidget {
  const ClientAdd({super.key});

  @override
  State<ClientAdd> createState() => _ClientAddState();
}

class _ClientAddState extends State<ClientAdd> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtGender = TextEditingController();
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ClientModel;
    txtName.text = args.name;
    txtGender.text = args.gender;
    txtAge.text = args.age.toString();
    txtCity.text = args.city.id.toString();

    save() {
      ClientModel p = ClientModel(args.id, txtName.text, txtGender.text,
          int.parse(txtAge.text), CityModel(int.parse(txtCity.text), "", ""));
      AccessApi().saveClient(p.toJson());
      Navigator.of(context).pushReplacementNamed('/client');
    }

    return Scaffold(
      body: Form(
        key: formController,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Icon(
                Icons.people,
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
                    child: Components().createTextField(
                        "Idade",
                        false,
                        TextInputType.number,
                        txtAge,
                        "Digite a idade",
                        context)),
              ],
            ),
            Center(
              child: RadioGender(
                controller: txtGender,
                optEdit: args.gender,
              ),
            ),
            Center(
              child: ComboCity(
                controller: txtCity,
                optEdit: args.city.id,
              ),
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
