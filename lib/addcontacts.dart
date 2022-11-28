import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  final TextEditingController _fieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contacts"),
      ),
      body: Form( key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _fieldController,
              validator: (value) {
                if (value !=null && value.length > 1) {
                  return null;
                } else {
                  return "Please enter something";
                }
              },
            ),
            ElevatedButton(
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                 await FirebaseFirestore.instance.collection("todos").add({"name":_fieldController.text});
                  Navigator.pop(context);
                }
              },
             child: Text("Add"))
          ],
        ),
      ),
    );
  }
}