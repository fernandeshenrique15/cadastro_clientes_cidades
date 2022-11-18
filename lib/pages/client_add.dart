import 'package:client_city/help/components.dart';
import 'package:client_city/help/radio_gender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClientAdd extends StatefulWidget {
  const ClientAdd({super.key});

  @override
  State<ClientAdd> createState() => _ClientAddState();
}

class _ClientAddState extends State<ClientAdd> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtGender = TextEditingController(text: 'M');
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtCity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formController,
        child: Column(
          children: [
            Container(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
