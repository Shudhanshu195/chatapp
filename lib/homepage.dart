import 'package:chatapp/addcontacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(CupertinoPageRoute(builder: ((context) => AddContacts())));
        },
      ),
      appBar: AppBar(
        title: const Text("home"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("todos").snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data?.docs ?? [];
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text(data[index]["name"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("todos")
                                  .doc(data[index].id)
                                  .delete();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
    );
  }
}
