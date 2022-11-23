import 'package:client_city/api/accessApi.dart';
import 'package:client_city/help/components.dart';
import 'package:client_city/model/city_model.dart';
import 'package:client_city/model/client_model.dart';
import 'package:client_city/pages/city.dart';
import 'package:client_city/pages/client_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Client extends StatefulWidget {
  const Client({super.key});

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  List<ClientModel> lista = [];

  GlobalKey<FormState> formController = GlobalKey<FormState>();

  redirect(page) {
    Navigator.pushNamed(context, '$page');
  }

  redirectHome() {
    Navigator.pushNamed(context, '/');
  }

  createCard(ClientModel c, context) {
    return ListTile(
      title: Components().createText("${c.id} - ${c.name}", 12,
          Theme.of(context).colorScheme.inversePrimary),
      subtitle: Components().createText("${c.age} ${c.city.name}", 12,
          Theme.of(context).colorScheme.inversePrimary),
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
    List<ClientModel> clientes = await AccessApi().listClients();
    setState(() {
      lista = clientes;
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
      return const Center(child: Text("Sem conexão com a API"));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components().createAppBar("Listagem de clientes", 20,
          Theme.of(context).colorScheme.inversePrimary, redirectHome),
      body: generateCards(),
      floatingActionButton: FloatingActionButton(
          onPressed: redirectClientAdd, child: Icon(Icons.add)),
    );
  }
}
