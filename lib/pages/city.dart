import 'package:client_city/api/accessApi.dart';
import 'package:client_city/help/components.dart';
import 'package:client_city/model/city_model.dart';
import 'package:client_city/pages/city_add.dart';
import 'package:flutter/material.dart';

class City extends StatefulWidget {
  const City({super.key});

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  List<CityModel> lista = [];

  GlobalKey<FormState> formController = GlobalKey<FormState>();

  redirect(page) {
    Navigator.pushNamed(context, '$page');
  }

  redirectHome() {
    Navigator.pushNamed(context, '/');
  }

  generateCards() {
    if (lista.isEmpty) {
      return const Center(child: Text("Esperando a API"));
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
      subtitle: Components().createText(
          "$c.uf", 12, Theme.of(context).colorScheme.inversePrimary),
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
      body: generateCards(),
      floatingActionButton: FloatingActionButton(
          onPressed: redirectClientAdd, child: const Icon(Icons.add)),
    );
  }
}
