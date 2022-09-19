import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/transaction.dart';
import 'package:my_app/transaction_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> weekdays = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"];

  List<double> heights = [0, 0, 0, 0, 0, 0, 0];
  List<double> percentages = [10, 10, 10, 10, 10, 10, 10];

  List<Transaction> transactions = [];

  double max = 0;

  void algo() {
    max = 0;
    for (double item in heights) {
      if (item > max) {
        max = item;
      }
    }
    //print("\n$max\n");
    for (int i = 0; i < 7; i++) {
      if (heights[i] > 0) {
        percentages[i] = (heights[i] * 100) / max;

        if (percentages[i] < 10) {
          percentages[i] = 10;
        }
      }
      print(percentages[i]);
      // if (percentages[i] < 0) {
      //   percentages[i] = 0;
      // }
    }
  }

  // ignore: non_constant_identifier_names
  // TransactionModel a = TransactionModel(
  //   date: DateTime.now(),
  //   id: 1,

  // )

  void delete(int id) {
    setState(() {
      Transaction a = transactions.firstWhere((element) => element.id == id);

      heights[a.date.weekday - 1] -= double.parse(a.price);

      if (heights[a.date.weekday - 1] == 0) {
        percentages[a.date.weekday - 1] = 10;
      }

      transactions.remove(a);
      algo();
    });
  }

  void addTransaction() {
    setState(() {
      heights[selectedDate.weekday - 1] += double.parse(price.text);

      algo();

      transactions.add(Transaction(
          transactions.length, price.text, expense.text, delete, selectedDate));
    });
  }

  TextEditingController expense = TextEditingController(text: "");
  TextEditingController price = TextEditingController(text: "");

  DateTime current = DateTime.now();
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // transactions.addAll([
    //   Transaction(0, 12.22, "Food", delete, DateTime.now()),
    //   Transaction(1, 13.22, "Petrol", delete, DateTime.now()),
    //   Transaction(2, 14.22, "Electricity", delete, DateTime.now())
    // ]);
    //print(transactions);
    return MaterialApp(home: Builder(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal Expenses',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Card(
                      child: SizedBox(
                    width: double.maxFinite,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int i = 0; i < 7; i++) ...<Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: percentages[i],
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.elliptical(20, 20)),
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Color.fromARGB(255, 58, 100, 172),
                                          Color.fromARGB(255, 96, 169, 209)
                                        ]),
                                  ),
                                  child: Center(
                                    child: Text(heights[i].toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Text(weekdays[i])
                              ],
                            )
                          ]
                        ],
                      ),
                    ),
                  )),
                  Card(
                    child: Column(children: [
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Transactions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 400,
                        width: double.maxFinite,
                        child: ListView(children: [
                          for (Transaction item in transactions) ...<Widget>[
                            item
                          ]
                        ]),
                      )
                    ]),
                  )
                ],
              ),
              FloatingActionButton(
                onPressed: () {
                  //action code for button 3
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(""),
                                      const Text("Add Transaction",
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: MaterialButton(
                                          color: Colors.red,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("X",
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TextFormField(
                                            controller: expense,
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.person),
                                              hintText: 'Enter your Expense',
                                              labelText: 'Expense',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFormField(
                                              controller: price,
                                              decoration: const InputDecoration(
                                                icon: Icon(Icons
                                                    .monetization_on_outlined),
                                                hintText: 'Enter the price',
                                                labelText: 'Price',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  decimal: true),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(
                                                        RegExp(r'(^\d*\.?\d*)'))
                                              ]),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                const Icon(Icons
                                                    .calendar_month_outlined),
                                                Text(
                                                    " ${weekdays[selectedDate.weekday - 1]} ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            minimumSize:
                                                                const Size(
                                                                    40, 30),
                                                            maximumSize:
                                                                const Size(
                                                                    100, 30)),
                                                    onPressed: () async {
                                                      final DateTime? picked =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  selectedDate,
                                                              firstDate: DateTime(
                                                                  current.year,
                                                                  current.month,
                                                                  DateTime
                                                                      .monday),
                                                              lastDate:
                                                                  current);
                                                      if (picked != null &&
                                                          picked !=
                                                              selectedDate) {
                                                        setState(() {
                                                          selectedDate = picked;
                                                        });
                                                      }
                                                    },
                                                    child: const Center(
                                                      child:
                                                          Text("Select Date"),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 150.0, top: 40.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    // If the form is valid, display a Snackbar.
                                                    // print(
                                                    //     " $selectedDate ${price.text} ${expense.text} ");
                                                    addTransaction();
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text('Submit'),
                                              )),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ));
                },
                backgroundColor: const Color.fromARGB(255, 37, 124, 224),
                child: const Icon(Icons.add),
              )
            ],
          ),
        ),
      );
    }));
  }
}
