import 'package:flutter/material.dart';

enum genderEnum { masculino, feminino }

class RadioGender extends StatefulWidget {
  TextEditingController? controller;
  String? optEdit;

  RadioGender({Key? key, this.controller, this.optEdit}) : super(key: key);

  @override
  State<RadioGender> createState() => _RadioGenderState();
}

class _RadioGenderState extends State<RadioGender> {
  genderEnum? _escolha = genderEnum.masculino;

  @override
  Widget build(BuildContext context) {
    print(widget.optEdit);
    // if editing select the city
    if (widget.optEdit == "F") {
      setState(() {
        widget.optEdit = "";
        _escolha = genderEnum.feminino;
        widget.controller?.text = 'F';
      });
    }

    return Row(
      children: [
        Expanded(
            child: ListTile(
          title: Text(
            "Masculino",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          leading: Radio<genderEnum>(
            value: genderEnum.masculino,
            groupValue: _escolha,
            fillColor: MaterialStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.primary),
            onChanged: (genderEnum? value) {
              setState(() {
                _escolha = value;
                widget.controller?.text = 'M';
              });
            },
          ),
        )),
        Expanded(
            child: ListTile(
          title: Text(
            "Feminino",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          leading: Radio<genderEnum>(
            value: genderEnum.feminino,
            groupValue: _escolha,
            fillColor: MaterialStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.primary),
            onChanged: (genderEnum? value) {
              setState(() {
                _escolha = value;
                widget.controller?.text = 'F';
              });
            },
          ),
        ))
      ],
    );
  }
}
