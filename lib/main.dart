import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromRGBO(235, 31, 42, 1),
        hintColor: Colors.orange[600],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // For LinearProgressIndicator.
  bool _visible = false;

  // TextEditing Controller for Username and Password Input
  final userController = TextEditingController();
  final pwdController = TextEditingController();

  Future userLogin() async {
    // Login API URL
    String url = "https://csci410ao.000webhostapp.com/user_login.php";

    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    // Getting username and password from Controller
    var data = {
      'username': userController.text,
      'password': pwdController.text,
    };

    try {
      // Starting Web API Call.
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      setState(() {
        _visible = false;
      });

      if (response.statusCode == 200) {
        // Server response into variable
        print(response.body);
        var msg = jsonDecode(response.body);

        // Check Login Status
        if (msg['loginStatus'] == true) {
          // Navigate to Home Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(uname: msg['userInfo']['NAME'])),
          );
        } else {
          // Show Error Message Dialog
          showMessage(msg["message"]);
        }
      } else {
        // Handle HTTP error
        showMessage("Error during connecting to Server.");
      }
    } catch (e) {
      // Handle other errors
      setState(() {
        _visible = false;
        showMessage("Error: $e");
      });
    }
  }

  Future<dynamic>? showMessage(String _msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(_msg),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text('Login Page'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: _visible,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: LinearProgressIndicator(),
                  ),
                ),
                Container(
                  height: 100.0,
                ),
                Icon(
                  Icons.group,
                  color: Theme.of(context).primaryColor,
                  size: 80.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Login Here',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // ... (rest of the code remains the same)

                        Theme(
                          data: new ThemeData(
                            primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
                            primaryColorDark: Color.fromRGBO(84, 87, 90, 0.5),
                            hintColor:
                            Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
                          ),
                          child: TextFormField(
                            controller: userController,
                            decoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              enabledBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              errorBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText: 'Enter User Name',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color.fromRGBO(84, 87, 90, 0.5),
                              ),
                              border: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              hintText: 'User Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter User Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Theme(
                          data: new ThemeData(
                            primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
                            primaryColorDark: Color.fromRGBO(84, 87, 90, 0.5),
                            hintColor:
                            Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
                          ),
                          child: TextFormField(
                            controller: pwdController,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              enabledBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              errorBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              border: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText: 'Enter Password',
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color.fromRGBO(84, 87, 90, 0.5),
                              ),
                              hintText: 'Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () => {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {userLogin()}
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Submit',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}