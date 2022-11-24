import 'dart:html';

import 'package:client_city/api/accessApi.dart';
import 'package:client_city/help/components.dart';
import 'package:client_city/model/city_model.dart';
import 'package:client_city/model/uf_model.dart';
import 'package:client_city/pages/city_add.dart';
import 'package:flutter/material.dart';

class City extends StatefulWidget {
  const City({super.key});

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
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

  comboUfs() {
    int? ufsel;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2),
            ),
          ),
          isExpanded: true,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          value: ufsel,
          icon: const Icon(Icons.arrow_downward),
          hint: Text(
            'Selecione um estado...',
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          elevation: 16,
          onChanged: (int? uf) {
            // converter a promessa de inteiro em inteiro
            int ufAux = uf?.toInt() ?? 0;

            // trazer o index da list
            int indexUf = ufs.indexWhere(((uf) => uf.id == ufAux));

            // pego o nome atravez do index
            String textoUf = ufs.elementAt(indexUf).name;

            if (uf == 0) {
              listCity();
            } else {
              searchCities(textoUf);
            }
          },
          items: ufs.map<DropdownMenuItem<int>>((UfModel ufid) {
            return DropdownMenuItem<int>(
                value: ufid.id, child: Text(ufid.name));
          }).toList()),
    );
  }

  List<CityModel> lista = [];

  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtSearch = TextEditingController();

  redirect(page) {
    Navigator.pushNamed(context, '$page');
  }

  redirectHome() {
    Navigator.pushNamed(context, '/');
  }

  searchUF() {
    return null;
  }

  generateCards() {
    if (lista.isEmpty) {
      return const Center(child: Text("Sem resultado"));
    } else {
      return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index) {
            return Card(
              color: Theme.of(context).colorScheme.onBackground,
              elevation: 6,
              margin: const EdgeInsets.all(5),
              child: createCard(lista[index], context),
            );
          });
    }
  }

  createCard(CityModel c, context) {
    return ListTile(
      title: Row(
        children: [
          Components().createText("${c.id} - ${c.name}", 12,
              Theme.of(context).colorScheme.inversePrimary)
        ],
      ),
      subtitle: Components()
          .createText(c.uf, 12, Theme.of(context).colorScheme.inversePrimary),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityAdd(),
                          settings: RouteSettings(
                            arguments: c,
                          ),
                        ),
                      )
                    },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )),
            IconButton(
                onPressed: () async {
                  await AccessApi().deleteCity(c.id);
                  setState(() {
                    listCity();
                  });
                },
                icon: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.inversePrimary))
          ],
        ),
      ),
    );
  }

  listCity() async {
    List<CityModel> cities = await AccessApi().listCities();
    setState(() {
      lista = cities;
    });
  }

  searchCities(String uf) async {
    List<CityModel> cities = await AccessApi().searchCities(uf);
    setState(() {
      lista = cities;
    });
  }

  @override
  void initState() {
    super.initState();

    // trazer a lista atualizada sempre que carregar a página
    listCity();
  }

  redirectClientAdd() {
    Navigator.pushNamed(context, "/cityAdd", arguments: CityModel(0, "", ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components().createAppBar("Listagem de cidades", 20,
          Theme.of(context).colorScheme.inversePrimary, redirectHome),
      body: Column(
        children: [
          Form(
              key: formController,
              child: SizedBox(
                child: comboUfs(),
              )),
          Expanded(
            flex: 1,
            child: generateCards(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: redirectClientAdd, child: const Icon(Icons.add)),
    );
  }
}
