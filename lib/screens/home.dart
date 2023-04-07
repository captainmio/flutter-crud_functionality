import 'package:crud_functionality/sql_helper.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState;
    _getUsers();
  }

  Future<void> _getUsers() async {
    final data = await SQLHelper.getUsers();
    setState(() {
      users = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Functionality"),
      ),
      body: ListView.builder(
        itemBuilder: ((BuildContext context, int index) {
          return ListTile(
            title: Text(
                "${users[index]['first_name']} ${users[index]['last_name']}"),
            subtitle: Text("${users[index]['job_description']}"),
            trailing: Wrap(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.pushNamed(context, "addEditUser",
                          arguments: {'id': users[index]['id']})
                      .then((value) => _getUsers()),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => print('Delete'),
                )
              ],
            ),
          );
        }),
        itemCount: users.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "addEditUser")
              .then((value) => _getUsers());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
