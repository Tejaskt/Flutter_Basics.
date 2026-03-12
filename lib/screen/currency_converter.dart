import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightBlueAccent),
      ),

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double result = 0;
  final TextEditingController txtEdtController = TextEditingController();

  void calculate() {
    setState(() {});
    result = double.parse(txtEdtController.text) * 92.32;
  }
  final border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlueAccent,
      width: 2,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Currency Converter"),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                "${result.toStringAsFixed(2)}₹",
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: .bold,
                  color: Colors.lightBlueAccent,
                ),
              ),
              TextField(
                controller: txtEdtController,
                decoration: InputDecoration(
                  hintText: "Please Enter The Amount in USD",
                  enabledBorder: border,
                  focusedBorder: border,
                  prefixIcon: Icon(Icons.monetization_on),
                  prefixIconColor: Colors.black,
                  filled: true,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: calculate,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    maximumSize: Size(double.infinity, 50),
                    elevation: 10,
                  ),
                  child: Text("Convert"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    txtEdtController.dispose();
    super.dispose();
  }
}
