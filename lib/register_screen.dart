import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inherited_example/utils.dart';
import 'inherited_widget.dart';

import 'package:flutter/material.dart';

class UpdateUserScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> firstNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> lastNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> emailKey =
  new GlobalKey<FormFieldState<String>>();

  final UserObject user;

  const UpdateUserScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = UserState.of(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit User Info'),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          autovalidate: false,
          child: new ListView(
            children: [
              new TextFormField(
                key: firstNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'First Name',
                ),
              ),
              new TextFormField(
                key: lastNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              new TextFormField(
                key: emailKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Email Address',
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate()) {
            var firstName = firstNameKey.currentState.value;
            var lastName = lastNameKey.currentState.value;
            var email = emailKey.currentState.value;

            if (firstName == '') {
              firstName = null;
            }
            if (lastName == '') {
              lastName = null;
            }
            if (email == '') {
              email = null;
            }

            container.updateUserInfo(
              name: firstName,
              phone: lastName,
              email: email,
            );

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class EditUser extends StatefulWidget {
  @override
  createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final UserObject mUser;

  _EditUserState({Key key,this.mUser});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  static OutlineInputBorder FormOutline = OutlineInputBorder(
    borderRadius: new BorderRadius.circular(3.0),
    borderSide: new BorderSide(
        color: Colors.red, width: 1.5
    ),
  );

  void setIntialData() {
    final mUserState = UserState.of(context);
    if(mUserState.user != null){
      nameController.text =  mUserState.user.fullName??"";
      phoneNumberController.text =  mUserState.user.phone??"";
      emailController.text =  mUserState.user.email??"";
    }

  }

  @override
  Widget build(BuildContext context) {
    setIntialData();
    return  Scaffold(
      appBar: AppBar(
        title: Text("Edit User Screen"),
      ),
      body:SingleChildScrollView(
      child:Form(
        key:formKey,
        child:Column(
            mainAxisSize: MainAxisSize.min,
//            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height:24),
              Text("Hey there!", style: TextStyle(fontSize: 24,
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Larsseit',
                  fontWeight: FontWeight.w700)),
              SizedBox(height:24),
              Container(
                margin: EdgeInsets.all(8),
                child: TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  validator: (value) =>
                      LogInValidator.valueIsEmpty(value, "Name"),
                  decoration: InputDecoration(
                    border: FormOutline,
                    labelText: CustomStrings.loginUserNameLabel,
                    hintText: CustomStrings.loginUserNameHint,
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  validator: LogInValidator.isValidEmail,
                  decoration: InputDecoration(
                    border: FormOutline,
                    labelText: CustomStrings.loginEmailLabel,
                    hintText: CustomStrings.loginEmailHint,
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(8),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.done,
                  validator: LogInValidator.isValidPhone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: FormOutline,
                    labelText: CustomStrings.registerPhoneNumberLabel,
                    hintText: CustomStrings.registerPhoneNumberHint,
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                  ),
                ),
              ),
              RaisedButton(
                child: new Text("Update",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(3.0),
                ),
                onPressed: _validateAndSend,
              ),
            ]),
      )
    ));
  }

  showSnackbar(String message) =>
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ));


  void _validateAndSend() {
    FocusScope.of(context).unfocus();
    if(formKey.currentState.validate()){
      final mUserState = UserState.of(context);
      mUserState.updateUserInfo(
        name: nameController.text,
        phone: phoneNumberController.text,
        email: emailController.text,
      );
      Navigator.pop(context);
    }

  }


}

class LogInValidator {

  static String valueIsEmpty(dynamic value,String type) {
    if (value == null || value.isEmpty || value == '') return 'Please fill $type field';
    return null;
  }

  static String isValidPassword(dynamic value) {
    var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,}$';
    var regExp = RegExp(pattern);
    var isEmpty = valueIsEmpty(value,"password");
    if (isEmpty != null) return isEmpty;
//    else if (!regExp.hasMatch(value)) return 'Your password must atleast contain 8 symbols with number, big and small letter and special character (!@#\$%^&*).';
    return null;
  }

  static String isPasswordMatches(String password,dynamic value) {
    var isEmpty = valueIsEmpty(value, "confirm Password");
    if (isEmpty != null) return isEmpty;
    else if (value.toString().compareTo(password) != 0) return "Password doesn't match";
    return null;
  }

  static String isValidPhone(dynamic value) {
    var isEmpty = valueIsEmpty(value,"phone");
    if (isEmpty != null) return isEmpty;
    else if (value.toString().length != 10) return "Please Enter a valid Phone Number";
    return null;
  }

  static String isValidEmail(dynamic value) {
    var pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(pattern);
    var isEmpty = valueIsEmpty(value, "email");
    if (isEmpty != null) return isEmpty;
    else if (!regExp.hasMatch(value)) return 'Not a valid email address. value should contain @gmail.com format';
    return null;
  }
}