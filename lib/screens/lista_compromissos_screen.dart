import 'package:flutter/material.dart';
import '../models/compromisso.dart';
import 'package:intl/intl.dart';

class ListaCompromissosScreen extends StatelessWidget {
  final Map<DateTime, List<Compromisso>> compromissos;
  final Function(DateTime, Compromisso) deleteCompromisso;

  ListaCompromissosScreen({required this.compromissos, required this.deleteCompromisso});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compromissos'),
      ),
      body: ListView.builder(
        itemCount: compromissos.length,
        itemBuilder: (context, index) {
          final date = compromissos.keys.elementAt(index);
          final listaCompromissos = compromissos[date]!;
          return ExpansionTile(
            title: Text(DateFormat('dd/MM/yyyy').format(date)), // Exibir a data
            children: listaCompromissos.map((compromisso) {
              return ListTile(
                title: Text('${compromisso.descricao} - Hora: ${compromisso.hora}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    deleteCompromisso(date, compromisso);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
