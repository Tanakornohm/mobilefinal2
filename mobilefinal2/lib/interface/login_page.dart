import 'package:flutter/material.dart';
import 'package:mobilefinal2/interface/register_page.dart';
import 'package:mobilefinal2/share/current_user.dart';
import 'package:mobilefinal2/storage/todo.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage>{
  final alter = GlobalKey<ScaffoldState>();
  TodoProvider data = TodoProvider();

  final TextEditingController user_tf = TextEditingController();
  final TextEditingController pass_tf = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: alter,
      body: Form(
      child: ListView(
        children: <Widget>[
          Image.asset(
            'resources/1.jpg'
            , height: 200),
          TextFormField(
            decoration: InputDecoration(

              hintText: 'User id',
              icon: Icon(Icons.person)
              
            ),
            keyboardType: TextInputType.text,
            onSaved: (value) => print(value),
            controller: user_tf,
          ),TextFormField(
            decoration: InputDecoration(

              hintText: 'Password',
              icon: Icon(Icons.lock),
            ),
            obscureText: true,
            keyboardType: TextInputType.text,
            onSaved: (value) => print(value),
            controller: pass_tf,
          ),
          RaisedButton(
            child: Text("Login"),
            onPressed: () async {
              
              if (user_tf.text.isEmpty == true || pass_tf.text.isEmpty == true) {
                alter.currentState.showSnackBar(SnackBar(content: Text('Please fill out this form')));
              }else if (user_tf.text == 'admin' && pass_tf.text == 'admin') {
                alter.currentState.showSnackBar(SnackBar(content: Text('Invalid user or password')));
              }else{
                Future <List<Todo>> all = data.getAllUser();
              var list = await all;
                for (int i = 0; i < list.length; i++) {
                if(user_tf.text == list[i].userid && pass_tf.text == list[i].password){
                  CurrentUser.USERID = list[i].userid;
                  CurrentUser.NAME = list[i].name;
                  CurrentUser.AGE = list[i].age;
                  CurrentUser.PASSWORD = list[i].password;
                }
              }
                print(list);
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) => MainScreen()
                // ));
              }
            }
          ),
          FlatButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              
              builder: (context) => RegisterPage()));
          }, child: Align(
                alignment: Alignment.bottomRight,
                child: Text("Register New Account"),
              ),)
        ],
      padding: EdgeInsets.all(50.0),) ,
      
      )
    );
    // return Form(
    //   key: _formKey,
    //   child: ListView(),
    // );
  }}