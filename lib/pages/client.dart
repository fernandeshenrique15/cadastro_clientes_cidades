import 'package:client_city/api/accessApi.dart';
import 'package:client_city/help/combo_city.dart';
import 'package:client_city/help/components.dart';
import 'package:client_city/model/city_model.dart';
import 'package:client_city/model/client_model.dart';
import 'package:client_city/pages/client_add.dart';
import 'package:flutter/material.dart';

class Client extends StatefulWidget {
  const Client({super.key});

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  List<ClientModel> lista = [];

  GlobalKey<FormState> formController = GlobalKey<FormState>();

  TextEditingController txtCity = TextEditingController();

  redirect(page) {
    Navigator.pushNamed(context, '$page');
  }

  redirectHome() {
    Navigator.pushNamed(context, '/');
  }

  iconGender(opt) {
    if (opt == "M") {
      return const Icon(
        Icons.man,
        color: Colors.blue,
      );
    }
    return const Icon(
      Icons.woman,
      color: Colors.pink,
    );
  }

  createCard(ClientModel c, context) {
    return ListTile(
      title: Row(
        children: [
          iconGender(c.gender),
          Components().createText("${c.id} - ${c.name}", 12,
              Theme.of(context).colorScheme.inversePrimary)
        ],
      ),
      subtitle: Row(
        children: [
          Icon(
            Icons.cake,
            size: 20,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          const SizedBox(
            width: 5,
          ),
          Components().createText("${c.age} anos - ${c.city.name}", 12,
              Theme.of(context).colorScheme.inversePrimary),
        ],
      ),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClientAdd(),
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
                  await AccessApi().deleteClient(c.id);
                  setState(() {
                    listClient();
                  });
                },
                icon: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.inversePrimary))
          ],
        ),
      ),
    );
  }

  listClient() async {
    List<ClientModel> clients = await AccessApi().listClients();
    setState(() {
      lista = clients;
    });
  }

  searchClient(int city) async {
    List<ClientModel> clients = await AccessApi().searchClients(city);
    setState(() {
      lista = clients;
    });
  }

  @override
  void initState() {
    super.initState();

    // trazer a lista atualizada sempre que carregar a página
    listClient();
  }

  redirectClientAdd() {
    Navigator.pushNamed(context, "/clientAdd",
        arguments: ClientModel(0, "", "", 0, CityModel(0, "", "")));
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

  buttonIcon(function, icon, boolForm) {
    return Expanded(
        flex: 1,
        child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary)),
          onPressed: () {
            if (!boolForm) {
              function();
            } else {
              if (formController.currentState!.validate()) {
                function(int.parse(txtCity.text));
              }
            }
          },
          child: SizedBox(
            height: 55,
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components().createAppBar("Listagem de clientes", 20,
          Theme.of(context).colorScheme.inversePrimary, redirectHome),
      body: Column(
        children: [
          Form(
            key: formController,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ComboCity(controller: txtCity),
                ),
                buttonIcon(searchClient, Icons.search, true),
                const SizedBox(width: 2),
                buttonIcon(listClient, Icons.filter_alt_off, false),
                const SizedBox(width: 4),
              ],
            ),
          ),
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
