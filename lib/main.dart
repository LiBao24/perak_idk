import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_contact.dart';
import 'bloc/contact_bloc.dart';
import 'bloc/contact_event.dart';
import 'bloc/contact_state.dart';
import 'models/contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      home: BlocProvider(
        create: (context) => ContactBloc(),
        child: ContactScreen(),
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactInitial) {
            return Center(child: Text('No contacts yet.'));
          } else if (state is ContactLoaded) {
            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      BlocProvider.of<ContactBloc>(context)
                          .add(RemoveContactEvent(index));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Something went wrong.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactScreen(),
            ),
          );
          if (result != null && result is Contact) {
            BlocProvider.of<ContactBloc>(context).add(AddContactEvent(result));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
