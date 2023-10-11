import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/sql_helper.dart';
import 'package:flutter_application_1/entity/employee.dart';

class InputPage extends StatefulWidget {
  const InputPage(
      {super.key,
      required this.title,
      required this.id,
      required this.name,
      required this.email,
      required this.alamat});

  final String? title, name, email, alamat;
  final int? id;

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      controllerName.text = widget.name!;
      controllerEmail.text = widget.email!;
      controllerAlamat.text = widget.alamat!;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("INPUT EMPLOYEE"),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: controllerName,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: controllerEmail,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: controllerAlamat,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Alamat',
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                if (widget.id == null) {
                  await addEmployee();
                } else {
                  await editEmployee(widget.id!);
                }
                Navigator.pop(context);
              },
            )
          ],
        ));
  }

  Future<void> addEmployee() async {
    await SQLHelper.addEmployee(
        controllerName.text, controllerEmail.text, controllerAlamat.text);
  }

  Future<void> editEmployee(int id) async {
    await SQLHelper.editEmployee(
        id, controllerName.text, controllerEmail.text, controllerAlamat.text);
  }
}
