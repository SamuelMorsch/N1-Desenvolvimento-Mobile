class Compromisso {
  final String descricao;
  final String hora;
  final DateTime data; // Adicionando a data

  Compromisso({required this.descricao, required this.hora, required this.data}); // Incluindo data no construtor

  Map<String, dynamic> toJson() {
    return {
      'descricao': descricao,
      'hora': hora,
      'data': data.toIso8601String(), // Salvar a data como string
    };
  }

  factory Compromisso.fromJson(Map<String, dynamic> json) {
    return Compromisso(
      descricao: json['descricao'],
      hora: json['hora'],
      data: DateTime.parse(json['data']), // Criar um DateTime a partir da string
    );
  }
}
