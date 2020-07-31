import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: FutureBuilder<List<User>>(
            future: users,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.all(30),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 20,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: Text(snapshot.data[index].name[0]),
                            ),
                            SizedBox(width: 10),
                            Text(snapshot.data[index].name, style: style),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
