import 'dart:math';
import 'package:demo_application/models/persona_db.dart';
import 'package:demo_application/providers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  final List<String> nomi = [
    "Matteo",
    "Marco",
    "Nicola",
    "Cristian",
    "Elena",
    "Barbara",
  ];

  final List<String> cognomi = [
    "Rossi",
    "Verdi",
    "Gialli",
    "Viola",
  ];

  final List<Widget> items = [];

  Future loadList() async {
    GetIt.I<DatabaseHelper>().listPersone().then((persone) {
      setState(() {
        items.clear();
        for (var persona in persone) {
          items.add(
            ListTile(
              title: Text(persona.id.toString() +
                  ' - ' +
                  persona.nome! +
                  ' ' +
                  persona.cognome!),
              onTap: () {
                GetIt.I<DatabaseHelper>()
                    .deletePersona(persona)
                    .then((value) => loadList());
              },
            ),
          );
        }
      });
    });
  }

  _ListPage() {
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elenco"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("On add pressed!");
          var random = Random();
          GetIt.I<DatabaseHelper>()
              .insertPersona(PersonaDB(
                nome: nomi[random.nextInt(nomi.length)],
                cognome: cognomi[random.nextInt(cognomi.length)],
              ))
              .then((value) => loadList());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
