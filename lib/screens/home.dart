import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List users = [
    {
      'fname': 'Rustum',
      'lname': 'Jordan',
      'jdesc': 'Web Programmer',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Functionality"),
      ),
      body: ListView.builder(
        itemBuilder: ((BuildContext context, int index) {
          return Column(
              children: users.map<Widget>((item) {
            return ListTile(
                title: Text("${item['fname']} ${item['lname']}"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, "details");
                });
          }).toList());
        }),
        itemCount: users.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "addUser");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class UsersInheritedWidget extends InheritedWidget {
//   final List users;
//   // constructor
//   const UsersInheritedWidget(
//       {Key? key, required this.users, required Widget child})
//       : super(key: key, child: child);
// }
