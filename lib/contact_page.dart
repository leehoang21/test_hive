import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/contact.dart';
import '/new_contact_form.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Hive'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildListView()),
          const NewContactForm()
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('contacts').listenable(),
      builder: (context, contactsBox, child) {
        return ListView.builder(
          itemCount: contactsBox.length,
          itemBuilder: (BuildContext context, int index) {
            final contact = contactsBox.getAt(index) as Contact;

            return ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.numberCall.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      contactsBox.putAt(index,
                          Contact('${contact.name}*', contact.numberCall));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      contactsBox.deleteAt(index);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
