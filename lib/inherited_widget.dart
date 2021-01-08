
import 'package:flutter/cupertino.dart';



class UserState extends StatefulWidget {
  final Widget mChildWidget;
//  final UserObject mUserObject;

  UserState({
    @required this.mChildWidget,
//    this.mUserObject,
  });


  static _UserState of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(InheritedContainer) as InheritedContainer).mUserState;

  @override
  createState() => new _UserState();
}

class _UserState extends State<UserState> {
  UserObject user;

  void updateUserInfo({name, phone, email}) {
    if (user == null) {
      user = new UserObject(fullName:name,email:email ,phone: phone);
      setState(() {
        user = user;
      });
    } else {
      setState(() {
        user.fullName = name ?? user.fullName;
        user.phone = phone ?? user.phone;
        user.email = email ?? user.email;
      });
    }
  }

  void updateUserName({name}) {
    if (user != null) {
      setState(() {
        user.fullName = name ?? user.fullName;
      });
    }
  }

  void updateUserPhone({phone}) {
    if (user != null) {
      setState(() {
        user.phone = phone ?? user.phone;
      });
    }
  }

  void updateUserEmail({email}) {
    if (user != null) {
      setState(() {
        user.email = email ?? user.email;
      });
    }
  }

  void updateUser({name,phone,email}) {
    if (user != null) {
      setState(() {
        user = new UserObject(fullName:name,email:email ,phone: phone);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InheritedContainer(
      mUserState: this,
      child: widget.mChildWidget,
    );
  }
}






class InheritedContainer extends InheritedWidget {
  final _UserState mUserState;

  InheritedContainer({
    Key key,
    @required this.mUserState,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedContainer old) => true;
}

class UserObject {
  String fullName;
  String phone;
  String email;

  UserObject({this.fullName, this.phone, this.email});
}






