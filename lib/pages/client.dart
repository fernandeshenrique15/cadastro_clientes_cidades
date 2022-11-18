import 'package:client_city/api/accessApi.dart';
import 'package:client_city/help/components.dart';
import 'package:client_city/model/city_model.dart';
import 'package:client_city/model/client_model.dart';
import 'package:client_city/pages/city.dart';
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
            IconButton(onPressed: null, icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () async {
                  await AccessApi().deleteClient(c.id);
                  setState(() {
                    listClient();
                  });
                },
                icon: Icon(Icons.delete))
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

  openRegister() {
    Navigator.pushNamed(context, "/register",
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
      floatingActionButton:
          FloatingActionButton(onPressed: openRegister, child: Icon(Icons.add)),
    );
  }
}
