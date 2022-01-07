import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/signin.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Register extends StatefulWidget {
//  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
  }

  void _signout() async {
    final User? user = await _auth.currentUser!;
    if (user == null) {
      Text('No user');
    }
    return;
    await _auth.signOut();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              child: Icon(
                Icons.logout,
              ),
              onTap: () {
                _signout();
              })),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
              ),
              TextFormField(
                controller: _passwordController,
              ),
              ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: Text('Register'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Text('Signin'))
            ],
          )),
    );
  }
}
