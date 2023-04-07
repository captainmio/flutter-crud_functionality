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

  //METHOD = method to get all Users in the database
  Future<void> _getUsers() async {
    final data = await SQLHelper.getUsers();
    setState(() {
      users = data;
    });
  }

  //METHOD = method to close confirm delete dialog
  _closeModal() {
    Navigator.pop(context);
  }

  Future<void> _confirmDeleteUser(BuildContext contex, int id) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete User"),
          content: const Text("Are you sure you want to delete this user?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Delete"),
              onPressed: () async {
                await SQLHelper.deleteUser(id)
                    .then((value) => _getUsers())
                    .then((value) => _closeModal());
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                _closeModal();
              },
            ),
          ],
        );
      },
    );
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
                  onPressed: () =>
                      {_confirmDeleteUser(context, users[index]['id'])},
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
