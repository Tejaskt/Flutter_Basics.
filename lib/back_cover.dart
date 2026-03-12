import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyCustomApp());
// }

class MyCustomApp extends StatelessWidget {
  const MyCustomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "my custom app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.greenAccent)),
      home: const CustomScreen(),
    );
  }
}

class CustomScreen extends StatefulWidget {
  const CustomScreen({super.key});

  @override
  State<CustomScreen> createState() => _CustomScreen();
}


class _CustomScreen extends State<CustomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),

              child: Column(
                spacing: 7,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: .circle,
                    ),
                    child: Icon(Icons.circle,color: Colors.grey,size: 20),
                  ),

                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: .circle,
                    ), child: Icon(Icons.circle,color: Colors.grey,size: 20),
                  ),
                ],
              ),
            ),

            SizedBox(height: 250),

            Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  color: Colors.white,
                  width: 16
                ),
                shape: .circle
              ),
              alignment: .center,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Icon(Icons.apple, size: 130, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            Center(
              child: Container(
                height: 100,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ),

            SizedBox(height: 30),

            Center(
              child: Text(
                "Powered By Samsung",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
