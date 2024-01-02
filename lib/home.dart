import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String uname;
  HomePage({super.key, required this.uname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('WELCOME'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welcome : " + uname,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}