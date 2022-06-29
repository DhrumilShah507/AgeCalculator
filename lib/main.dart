import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int final_days = 0;
  int final_months = 0;
  int final_years = 0;
  DateTime? pickedDate;

  Future<void> _selectDate(BuildContext context) async {
    int? current_day = DateTime.now().day;
    int current_month = DateTime.now().month;
    int current_year = DateTime.now().year;
    List<int> months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        if (pickedDate!.day > current_day!) {
          current_day = current_day! + months[pickedDate!.month - 1];
          current_month = current_month - 1;
        }
        if (pickedDate!.month > current_month) {
          current_year = current_year - 1;
          current_month = current_month + 12;
        }
        final_days = current_day! - pickedDate!.day;
        final_months = current_month - pickedDate!.month;
        final_years = current_year - pickedDate!.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text("19IT128 - Age Calculator"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Your Age Till Today Is ",
              style: TextStyle(color: Colors.black, fontSize: 24)),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "$final_years",
                  style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 35,
                      fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: " Years ",
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              TextSpan(
                  text: "$final_months",
                  style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 35,
                      fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: " Months ",
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              TextSpan(
                  text: "$final_days",
                  style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 35,
                      fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: " Days  ",
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ]),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Your BirthDate : ${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}",
            style: TextStyle(fontSize: 25),
          ),
          Text(
            " Today's Date :   ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            style: TextStyle(fontSize: 25),
          ),
          RaisedButton(
            onPressed: () => _selectDate(context),
            color: Colors.purple,
            child: const Text(
              "Choose Date",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          )
        ],
      )),
    );
  }
}
