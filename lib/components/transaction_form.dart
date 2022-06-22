import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas/components/adaptative_button.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }

        setState(
          () {
            _selectedDate = pickedDate;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR');
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  onSubmitted: (_) => _submitForm(),
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                TextField(
                  controller: _valueController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitForm(),
                  decoration: const InputDecoration(
                    labelText: 'Valor (R\$',
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : DateFormat('dd MMMM yyyy', 'pt_BR')
                                .format(_selectedDate!)),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          primary: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: _showDatePicker,
                        child: const Text('Selecionar data!'),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AdaptativeButton(label: 'Nova Transação', onPressed: _submitForm),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
