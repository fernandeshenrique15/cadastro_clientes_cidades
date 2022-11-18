import 'package:flutter/material.dart';

enum genderEnum { masculino, feminino }

class RadioGender extends StatefulWidget {
  TextEditingController? controller;
  RadioGender({Key? key, this.controller}) : super(key: key);

  @override
  State<RadioGender> createState() => _RadioGenderState();
}

class _RadioGenderState extends State<RadioGender> {
  genderEnum? _escolha = genderEnum.masculino;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ListTile(
          title: const Text("Masculino"),
          leading: Radio<genderEnum>(
            value: genderEnum.masculino,
            groupValue: _escolha,
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
          title: const Text("Feminino"),
          leading: Radio<genderEnum>(
            value: genderEnum.feminino,
            groupValue: _escolha,
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
