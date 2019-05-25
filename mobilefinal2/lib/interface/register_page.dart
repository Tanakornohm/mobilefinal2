import 'package:flutter/material.dart';
import 'package:mobilefinal2/storage/todo.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }

}

class RegisterPageState extends State<RegisterPage>{
  final alter = GlobalKey<FormState>();
  TodoProvider data = TodoProvider(); 

  final user_tf = TextEditingController();
  final name_tf = TextEditingController();
  final age_tf = TextEditingController();
  final pass_tf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register"),
      ),
      body: Form(
        key: alter,

      child: ListView(
        children: <Widget>[
          TextFormField(
            
            decoration: InputDecoration(
              
              hintText: 'User Id',
              icon: Icon(Icons.person),
            ),
            keyboardType: TextInputType.text,
            controller: user_tf,
            validator: (value) {
                if (value.isEmpty || value.length < 6 || value.length > 12) {
                  return "User ต้องมีความยาวอยู่ในช่วง 6-12ตัวอักษร";
                }
              }
            
          ),TextFormField(
            decoration: InputDecoration(
              
              hintText: 'Name',
              icon: Icon(Icons.account_circle),
            ),
            keyboardType: TextInputType.text,
            controller: name_tf,
            validator: (value) {
              var count = 0;
              var keep = 0;
              if (value.length != null){
                  keep = value.length;
              }
              for (int i=0;i < keep;i++){
                if(value[i] == ' '){
                  count +=1;
                }
              }
              if (count != 1) {
                  return "Name ต้องมีทั้งชื่อและนามสกุลโดยคั่นด้วยspace 1 space เท่านั้น";
                }
              }
          ),
          TextFormField(
            decoration: InputDecoration(
              
              hintText: 'Age',
              icon: Icon(Icons.calendar_today),
            ),
            keyboardType: TextInputType.number,
            controller: age_tf,
            validator: (value) {
                if (value.isEmpty || int.parse(value) < 10 || int.parse(value) > 80) {
                  return "Age ต้องเป็นตัวเลขเท่านั้นและอยู่ในช่วง 10-80";
                }
              }
          ),
          TextFormField(
            decoration: InputDecoration(
              
              hintText: 'Password',
              icon: Icon(Icons.lock),
            ),
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: pass_tf,
            validator: (value) {
                if (value.isEmpty || value.length < 6) {
                  return "Password ต้องมีความยาวมากกว่า 6";
                }
              }
          ),
          RaisedButton(
            child: Text("Continue"),
            onPressed: () async {
              await data.open('todo');
              Future<List<Todo>> all = data.getAllUser();
              Todo userData = Todo();
              userData.userid = user_tf.text;
              userData.name = name_tf.text;
              userData.age = age_tf.text;
              userData.password = pass_tf.text;
              
              if (alter.currentState.validate()){
              user_tf.text = "";
              name_tf.text = "";
              age_tf.text = "";
              pass_tf.text = "";
              await data.insertUser(userData);
              Navigator.pop(context);
              }

              Future showAllUser() async {
                Future<List<Todo>> allUser = data.getAllUser();
                  var list = await allUser;
                  print(list);
                  for(var i=0; i < list.length;i++){
                    print(list[i]);
                    }
                  }

                showAllUser();
            }
          ),
        ],
      padding: EdgeInsets.all(50.0),) ,

      
      )
    );

    // return Form(
    //   key: _formKey,
    //   child: ListView(),
    // );

  }}