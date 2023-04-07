import 'package:flutter/material.dart';

import '../sql_helper.dart';

class AddEditUser extends StatefulWidget {
  const AddEditUser({super.key});

  @override
  State<AddEditUser> createState() => _AddEditUserState();
}

class _AddEditUserState extends State<AddEditUser> {
  int id = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _jobDescription = TextEditingController();

  // METHOD = method to go back to the previous page
  void _goBack() {
    Navigator.of(context).pop();
  }

  // METHOD = method to validate each textfield if its null or not
  _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // METHOD = method to validate and submit the form
  Future<void> _formSubmit() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      String firstName = _firstName.text;
      String lastName = _lastName.text;
      String jobDescription = _jobDescription.text;

      if (id != 0) {
        print('Do edit');
        await SQLHelper.updateUser(id, firstName, lastName, jobDescription)
            .then((value) => _goBack());
      } else {
        print('Do add');
        await SQLHelper.createUser(firstName, lastName, jobDescription)
            .then((value) => _goBack());
      }
    }
  }

  Future<void> _getUser() async {
    List<Map<String, dynamic>> user = await SQLHelper.getUser(id);

    _firstName.text = user[0]['first_name'];
    _lastName.text = user[0]['last_name'];
    _jobDescription.text = user[0]['job_description'];
  }

  @override
  Widget build(BuildContext context) {
    // final ModalRouteVar = ModalRoute.of(context);
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    String appBarTitle = "Add a new User";

    if (arguments != null && arguments['id'] != null) {
      appBarTitle = "Edit a user";
      setState(() {
        id = arguments['id'];
      });
      _getUser();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            _goBack();
          },
        ),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 5.0,
                ),
                child: TextFormField(
                  controller: _firstName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'First name',
                  ),
                  validator: (String? value) {
                    return _fieldValidator(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 5.0,
                ),
                child: TextFormField(
                  controller: _lastName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Last name',
                  ),
                  validator: (String? value) {
                    return _fieldValidator(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 5.0,
                ),
                child: TextFormField(
                  controller: _jobDescription,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Job Description',
                  ),
                  validator: (String? value) {
                    return _fieldValidator(value);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 5.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _formSubmit();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
