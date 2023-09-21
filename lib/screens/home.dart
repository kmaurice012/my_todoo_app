import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth.dart';

class Home extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Home({super.key, required FirebaseAuth auth, required FirebaseFirestore firestore});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todoo"),
        centerTitle: true,
        actions: [
          IconButton(
            key: const ValueKey("Sign Out"),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              Auth(auth: widget._auth).signOut();
            },
          )
        ],
      ),
      body:  Column(
        children: <Widget>[
        const  SizedBox(
            height: 20,
          ),
         const Text(
            "Add a new todo",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                  Expanded(
                    child: TextFormField(
                      key: const ValueKey("addField"),
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    key:const ValueKey("addButton"),
                    onPressed: (){
                      if(_todoController.text !=''){
                        setState(() {
                          
                        });
                      }
                    },
                     icon:const Icon(Icons.add)
                  )
                ])),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Your Todoos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          // Expanded(
          //   child:StreamBuilder(
          //     stream: stream,
          //     builder: builder
          //   ) ,
          // )
        ],
      ),
    );
  }
}
