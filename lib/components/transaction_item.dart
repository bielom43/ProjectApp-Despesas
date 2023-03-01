import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('R\$${tr.value}'),
            ),
          ),
        ),
        title: Text(
          tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                onPressed: (() => onRemove(tr.id)),
                icon: const Icon(Icons.delete_forever_outlined),
                label: const Text('Delete'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.error),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete_forever_outlined),
                color: Theme.of(context).colorScheme.error,
                onPressed: (() => onRemove(tr.id)),
              ),
      ),
    );
  }
}
