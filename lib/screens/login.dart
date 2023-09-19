import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth.dart';

class Login extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: const ValueKey("username"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Username"),
                  controller: _emailController,
                ),
                TextFormField(
                  key: const ValueKey("password"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Password"),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  key: const ValueKey("signIn"),
                  onPressed: () async {
                    final String? retVal =
                        await Auth(auth: widget._auth).signIn(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (retVal == "Success") {
                      _emailController.clear();
                      _passwordController.clear();
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Sign in successful")),
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(retVal!)),
                      );
                    }
                  },
                  child: const Text("Sign In"),
                ),
                TextButton(
                    onPressed: () async {
                      final String? retVal =
                          await Auth(auth: widget._auth).createAccount(
                        _emailController.text,
                        _passwordController.text,
                      );
                      if (retVal == "Success") {
                        _emailController.clear();
                        _passwordController.clear();
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(retVal!),
                          ),
                        );
                      }
                    },
                    child: const Text("Create Account"))
              ],
            );
          }),
        ),
      ),
    );
  }
}
