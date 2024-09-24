
import 'package:agendapessoal/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importando para usar inicialização da localização

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null); // Inicializando a formatação da localização
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda Pessoal',
      locale: Locale('pt', 'BR'), // Definindo a localização para o aplicativo
      theme: ThemeData(
        primaryColor: Color(0xFFefe2bf), // Cor primária
        scaffoldBackgroundColor: Color(0xFFefe2bf), // Cor de fundo
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFefe2bf), // Cor do AppBar
          titleTextStyle: TextStyle(
            color: Colors.black, // Cor do texto no AppBar
            fontSize: 20,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
