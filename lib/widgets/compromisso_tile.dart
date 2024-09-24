import 'package:flutter/material.dart';

class CompromissoTile extends StatelessWidget {
  final String descricao;
  final String hora;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  CompromissoTile({
    required this.descricao,
    required this.hora,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(descricao),
      subtitle: Text('Hora: $hora'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // Implementar confirmação de exclusão
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Confirmar Exclusão'),
                    content: Text('Você tem certeza que deseja excluir este compromisso?'),
                    actions: [
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Excluir'),
                        onPressed: () {
                          onDelete(); // Chamando o callback de exclusão
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
