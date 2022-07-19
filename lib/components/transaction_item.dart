import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key,
    required this.tr,
    required this.onRemove,}) : super(key: key);

  final Transaction tr;
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$ ${tr.value.toStringAsFixed(2)}',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
            ),
          ),
        ),
        title: Text(
          tr.title,
          style: Theme
              .of(context)
              .textTheme
              .headline6,
        ),
        subtitle: Text(
          DateFormat('dd MMMM yyyy', 'pt_BR').format(tr.date),
        ),
        trailing: MediaQuery
            .of(context)
            .size
            .width > 480
            ? TextButton.icon(
          onPressed: () => onRemove(tr.id),
          icon: Icon(
            Icons.delete,
            color: Theme
                .of(context)
                .errorColor,
          ),
          label: Text(
            'Excluir',
            style: TextStyle(
              color: Theme
                  .of(context)
                  .errorColor,
            ),
          ),
        )
            : IconButton(
          icon: const Icon(Icons.delete),
          color: Theme
              .of(context)
              .colorScheme
              .error,
          onPressed: () => onRemove(tr.id),
        ),
      ),
    );
  }
}
