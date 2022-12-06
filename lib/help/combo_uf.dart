import 'package:flutter/material.dart';
import 'package:client_city/api/accessApi.dart';
import 'package:client_city/model/uf_model.dart';

// ignore: must_be_immutable
class ComboUf extends StatefulWidget {
  TextEditingController? controller;
  Function search;
  Function listAll;
  bool isFilter;
  String? optEdit;

  ComboUf(
      {Key? key,
      this.controller,
      required this.search,
      required this.listAll,
      required this.isFilter,
      this.optEdit})
      : super(key: key);

  @override
  State<ComboUf> createState() => _ComboUfState();
}

class _ComboUfState extends State<ComboUf> {
  int? ufSel;

  List<UfModel> ufs = [
    UfModel(0, 'Mostrar todos'),
    UfModel(1, 'AC'),
    /*UfModel(2, 'AL'),
    UfModel(3, 'AP'),
    UfModel(4, 'AM'),
    UfModel(5, 'BA'),
    UfModel(6, 'CE'),
    UfModel(7, 'DF'),
    UfModel(8, 'ES'),
    UfModel(9, 'GO'),
    UfModel(10, 'MA'),
    UfModel(11, 'MT'),
    UfModel(12, 'MS'),
    UfModel(13, 'MG'),
    UfModel(14, 'PA'),
    UfModel(15, 'PB'),
    UfModel(16, 'PR'),
    UfModel(17, 'PE'),
    UfModel(18, 'PI'),
    UfModel(19, 'RJ'),
    UfModel(20, 'RN'),*/
    UfModel(21, 'RS'),
    UfModel(22, 'RO'),
    UfModel(23, 'RR'),
    UfModel(24, 'SC'),
    UfModel(25, 'SP'),
    UfModel(26, 'SE'),
    UfModel(27, 'TO'),
  ];

  @override
  Widget build(BuildContext context) {
    // if editing select the uf
    if (widget.optEdit != null && widget.optEdit != "") {
      int indexUf = ufs.indexWhere(((uf) => uf.name == widget.optEdit));
      ufSel = ufs.elementAt(indexUf).id;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField(
          validator: (value) {
            if (value == null || value == 0) {
              return 'Selecione um estado';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2),
            ),
          ),
          isExpanded: true,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          value: ufSel,
          icon: const Icon(Icons.arrow_downward),
          hint: Text(
            'Selecione um estado',
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          elevation: 16,
          onChanged: (int? uf) {
            // converter a promessa de inteiro em inteiro
            int ufAux = uf?.toInt() ?? 0;

            // trazer o index da list
            int indexUf = ufs.indexWhere(((uf) => uf.id == ufAux));

            // pego o nome atraves do index
            String textoUf = ufs.elementAt(indexUf).name;

            // verifica se é um filtro para disparar pesquisa ou cadastro
            if (widget.isFilter) {
              if (uf == 0) {
                widget.listAll();
              } else {
                widget.search(textoUf);
              }
            } else {
              setState(() {
                ufSel = uf;
                widget.controller?.text = textoUf;
              });
            }
          },
          items: ufs.map<DropdownMenuItem<int>>((UfModel uid) {
            if (!widget.isFilter) {
              if (uid.id != 0) {
                return DropdownMenuItem<int>(
                    value: uid.id, child: Text(uid.name));
              } else {
                return DropdownMenuItem<int>(
                    value: uid.id, child: const Text("Selecione"));
              }
            } else {
              return DropdownMenuItem<int>(
                  value: uid.id, child: Text(uid.name));
            }
          }).toList()),
    );
  }
}
