import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  //const Signup({ Key? key }) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _signup() async {
    final User? user = (await _auth.signInWithEmailAndPassword(
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
                  _signup();
                },
                child: Text('Register'),
              )
            ],
          )),
    );
  }
}
