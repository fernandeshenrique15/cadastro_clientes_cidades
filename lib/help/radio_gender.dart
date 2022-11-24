import 'package:flutter/material.dart';

enum GenderEnum { masculino, feminino }

// ignore: must_be_immutable
class RadioGender extends StatefulWidget {
  TextEditingController? controller;
  String? optEdit;

  RadioGender({Key? key, this.controller, this.optEdit}) : super(key: key);

  @override
  State<RadioGender> createState() => _RadioGenderState();
}

class _RadioGenderState extends State<RadioGender> {
  GenderEnum? _escolha = GenderEnum.masculino;

  @override
  Widget build(BuildContext context) {
    // if editing select the city
    if (widget.optEdit == "F") {
      setState(() {
        widget.optEdit = "";
        _escolha = GenderEnum.feminino;
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
          leading: Radio<GenderEnum>(
            value: GenderEnum.masculino,
            groupValue: _escolha,
            fillColor: MaterialStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.primary),
            onChanged: (GenderEnum? value) {
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
          leading: Radio<GenderEnum>(
            value: GenderEnum.feminino,
            groupValue: _escolha,
            fillColor: MaterialStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.primary),
            onChanged: (GenderEnum? value) {
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
