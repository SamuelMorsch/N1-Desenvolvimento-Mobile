import 'package:flutter/material.dart';
import '../models/compromisso.dart';

class AddCompromissoScreen extends StatefulWidget {
  final Function(Compromisso) onAdd;
  final Compromisso? compromisso;
  final DateTime data; // Adicionando a data

  AddCompromissoScreen({required this.onAdd, this.compromisso, required this.data}); // Incluindo data

  @override
  _AddCompromissoScreenState createState() => _AddCompromissoScreenState();
}

class _AddCompromissoScreenState extends State<AddCompromissoScreen> {
  TextEditingController _descricaoController = TextEditingController();
  TimeOfDay? _horaSelecionada;

  Future<void> _selectHora(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _horaSelecionada)
      setState(() {
        _horaSelecionada = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Compromisso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _horaSelecionada == null
                      ? 'Hora: não selecionada'
                      : 'Hora: ${_horaSelecionada!.format(context)}',
                ),
                ElevatedButton(
                  onPressed: () => _selectHora(context),
                  child: Text('Selecionar Hora'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final compromisso = Compromisso(
                  descricao: _descricaoController.text,
                  hora: _horaSelecionada?.format(context) ?? 'Hora não definida',
                  data: widget.data, // Usar a data do compromisso
                );
                widget.onAdd(compromisso); // Adiciona o compromisso
                Navigator.pop(context); // Retorna à tela anterior
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
