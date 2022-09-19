import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Transaction extends StatefulWidget {
  final String price;
  final String title;
  final Function delete;
  final DateTime date;
  final int id;



  const Transaction(this.id, this.price, this.title, this.delete, this.date,
      {Key? key})
      : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      height: 70,
      //color: const Color.fromARGB(255, 227, 227, 227),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 239, 239),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 30,
              child: Text(widget.price),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "${widget.date.day}/${widget.date.month}/${widget.date.year}",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 92, 92, 92))),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () => widget.delete(widget.id),
              child: const Icon(Icons.delete)),
        )
      ]),
    );
  }
}
