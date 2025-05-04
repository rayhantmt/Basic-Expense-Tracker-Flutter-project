import 'package:flutter/material.dart';
import 'package:expense_tracker/models/enum.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddexpense, super.key});
  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }

  final void Function(Expenselist expense) onAddexpense;
}

class _NewExpense extends State<NewExpense> {
  final _textcontroller = TextEditingController();
  final _textcontroller2 = TextEditingController();
  DateTime? _pickedDate;
  Categary _selectedcategary = Categary.food;

  void _submitdata() {
    final enteredamount = double.tryParse(_textcontroller2.text);
    final amountisinvalid = enteredamount == null || enteredamount <= 0;
    if (_textcontroller.text.trim().isEmpty ||
        amountisinvalid ||
        _pickedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content:
              Text('Please Enter a valid Tittle,Amount,date and Catregary'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Okey'))
          ],
        ),
      );
      return;
    }
    widget.onAddexpense(
      Expenselist(
          categary: _selectedcategary,
          amount: enteredamount,
          dateTime: _pickedDate!,
          title: _textcontroller.text),
    );
    Navigator.pop(context);
  }

  void _opencallender() async {
    final initialDate = DateTime.now();
    final firstdate =
        DateTime(initialDate.year - 1, initialDate.month, initialDate.day);
    final lastDate = DateTime.now();
    final _selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstdate,
        lastDate: lastDate);

    setState(() {
      _pickedDate = _selectedDate;
    });
  }

  @override
  void dispose() {
    _textcontroller.dispose();
    _textcontroller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context)
        .viewInsets
        .bottom; // this line shows the amounts of pixels are under the keyboard so that amount goes in padding and the app becomes more responsive
    return LayoutBuilder(builder: (context, constraints) {
      print(constraints.maxHeight);
      print(constraints.maxWidth);
      print(constraints.minHeight);
      print(constraints.minWidth);
      final width = constraints.maxWidth;
      return SizedBox(
        // took sized box for the height functionality so the modal bottom sheet tkaes the maximum height while the keyboard is displayed
        height: double.infinity,

        child: SingleChildScrollView(
          // made it scorllable so that when the keyboard appers the scrren does not goes under the keyboared
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 40, 16, keyboardspace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textcontroller,
                          maxLength: 100,
                          decoration: InputDecoration(
                              label: Text('Please input the field text ')),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textcontroller2,
                          maxLength: 50,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$',
                            label: Text('Enter Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _textcontroller,
                    maxLength: 100,
                    decoration: InputDecoration(
                        label: Text('Please input the field text ')),
                  ),
                  if (width>=600)
                  Row(children: [
                    DropdownButton(
                        value: _selectedcategary,
                        items: Categary.values
                            .map((categary) => DropdownMenuItem(
                                value: categary,
                                child: Text(categary.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selectedcategary = value;
                          });
                        }),

const SizedBox(width: 12,),
                       Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _pickedDate == null
                                ? 'Pick the date'
                                : formatter.format(_pickedDate!),
                          ),
                          IconButton(
                            onPressed: _opencallender,
                            icon: Icon(Icons.calendar_month),
                          )
                        ],
                      ),
                    ) 
                  ],)
                  else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textcontroller2,
                        maxLength: 50,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: '\$',
                          label: Text('Enter Amount'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _pickedDate == null
                                ? 'Pick the date'
                                : formatter.format(_pickedDate!),
                          ),
                          IconButton(
                            onPressed: _opencallender,
                            icon: Icon(Icons.calendar_month),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                if (width>=600)
                Row(
                  children: [
                     ElevatedButton(
                        onPressed: _submitdata, child: Text('save data')),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('cancel'),
                    ),
                  ],
                )
                else
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedcategary,
                        items: Categary.values
                            .map((categary) => DropdownMenuItem(
                                value: categary,
                                child: Text(categary.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selectedcategary = value;
                          });
                        }),
                    ElevatedButton(
                        onPressed: _submitdata, child: Text('save data')),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
