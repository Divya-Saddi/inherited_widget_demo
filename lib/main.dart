import 'package:flutter/material.dart';
import 'package:inherited_example/register_screen.dart';

import 'inherited_widget.dart';

void main() {
  runApp(UserState(mChildWidget:MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Inherited widget Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  UserObject mUserObject;

  Widget displayUserInfo() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(mUserObject.fullName, style: new TextStyle(fontSize: 24.0)),
          new Text(mUserObject.phone, style: new TextStyle(fontSize: 24.0)),
          new Text(mUserObject.email, style: new TextStyle(fontSize: 24.0)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mUserState = UserState.of(context);
    mUserObject = mUserState.user;
    return new Scaffold(
      appBar: new AppBar(
        centerTitle:true,
        title: new Text('Inherited Widget Demo'),
      ),
      body:  mUserObject == null?
      Center(child: Text('Please add user information',style: new TextStyle(fontSize: 24.0))) :displayUserInfo,
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.edit),
        onPressed: () => Navigator.push(
          context,
          new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return new EditUser();
            },
          ),
        ),
      ),
    );
  }
}