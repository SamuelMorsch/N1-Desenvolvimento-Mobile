import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'add_compromisso_screen.dart';
import 'lista_compromissos_screen.dart';
import '../utils/storage_helper.dart';
import '../models/compromisso.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  Map<DateTime, List<Compromisso>> compromissos = {};
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadCompromissos();
  }

  void loadCompromissos() async {
    compromissos = await StorageHelper.loadCompromissos();
    setState(() {});
  }

  void addCompromisso(Compromisso compromisso) {
    if (compromissos[selectedDate] != null) {
      compromissos[selectedDate]!.add(compromisso);
    } else {
      compromissos[selectedDate] = [compromisso];
    }
    StorageHelper.saveCompromissos(compromissos);
    setState(() {});
  }

  void deleteCompromisso(DateTime date, Compromisso compromisso) {
    setState(() {
      compromissos[date]!.remove(compromisso);
      if (compromissos[date]!.isEmpty) {
        compromissos.remove(date);
      }
      StorageHelper.saveCompromissos(compromissos);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Compromisso> compromissosDoDia = compromissos[selectedDate] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda Pessoal'),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'pt_BR',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: selectedDate,
            selectedDayPredicate: (day) => isSameDay(selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                selectedDate = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFFf5a489),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Color(0xFFA8C896), // Cor do círculo para a data atual
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(color: Colors.white), // Texto da data atual
              defaultTextStyle: TextStyle(color: Colors.black),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false, // Remove o botão "2 Weeks"
            ),
          ),
          Expanded(
            child: compromissosDoDia.isNotEmpty
                ? ListView.builder(
                    itemCount: compromissosDoDia.length,
                    itemBuilder: (context, index) {
                      final compromisso = compromissosDoDia[index];
                      return ListTile(
                        title: Text(compromisso.descricao),
                        subtitle: Text(
                          'Hora: ${compromisso.hora} - Data: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deleteCompromisso(selectedDate, compromisso);
                          },
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('Nenhum compromisso para esta data.'),
                  ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaCompromissosScreen(
                    compromissos: compromissos,
                    deleteCompromisso: deleteCompromisso,
                  ),
                ),
              );
            },
            child: Icon(Icons.list),
            heroTag: null,
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCompromissoScreen(
                    onAdd: addCompromisso,
                    data: selectedDate,
                  ),
                ),
              ).then((_) {
                loadCompromissos();
              });
            },
            child: Icon(Icons.add),
            heroTag: null,
          ),
        ],
      ),
    );
  }
}
