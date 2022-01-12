import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/contact.dart';

class NewContactForm extends StatefulWidget {
  const NewContactForm({Key? key}) : super(key: key);

  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _numberCall = '';

  void addContact(Contact contact) {
    final contactBox = Hive.box('contacts');
    contactBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value!,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Call Number'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _numberCall = value!,
                ),
              )
            ],
          ),
          ElevatedButton(
            child: const Text('Add new contact'),
            onPressed: () {
              _formKey.currentState!.save();
              final newContact = Contact(_name, int.parse(_numberCall));
              addContact(newContact);
            },
          )
        ],
      ),
    );
  }
}
