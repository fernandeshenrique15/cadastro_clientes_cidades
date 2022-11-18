import 'package:client_city/help/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  redirect(page) {
    Navigator.pushNamed(context, '$page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components().createAppBar("Clientes e cidades", 20,
          Theme.of(context).colorScheme.inversePrimary, null),
      body: Form(
        key: formController,
        child: Row(
          children: [
            Expanded(
              flex: 50,
              child: Center(
                child: Components().createButtonRedirect("Clientes", redirect,
                    "/client", formController, context, 100),
              ),
            ),
            Expanded(
              flex: 50,
              child: Center(
                child: Components().createButtonRedirect(
                    "Cidades", redirect, "/city", formController, context, 100),
              ),
            )
          ],
        ),
      ),
    );
  }
}
