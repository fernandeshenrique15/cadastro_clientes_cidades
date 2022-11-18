import 'package:client_city/pages/client_add.dart';
import 'package:flutter/material.dart';
import 'package:client_city/help/themas.dart';
import 'package:client_city/pages/city.dart';
import 'package:client_city/pages/home.dart';
import 'package:client_city/pages/client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clientes e cidades',
      theme: Themas().dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/city': (context) => const City(),
        '/client': (context) => const Client(),
        '/clientAdd': (context) => const ClientAdd(),
      },
    );
  }
}
