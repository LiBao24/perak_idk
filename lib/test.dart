import 'package:flutter/material.dart';
import 'add_contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      home: ContactScreen(),
    );
  }
}

class Contact {
  String name;
  String phone;

  Contact({required this.name, required this.phone});
}

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // Daftar kontak tanpa state management GetX
  List<Contact> contacts = [];

  // Fungsi untuk menambahkan kontak
  void addContact(String name, String phone) {
    setState(() {
      contacts.add(Contact(name: name, phone: phone));
    });
  }

  // Fungsi untuk menghapus kontak
  void removeContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeContact(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigasi ke halaman tambah kontak dan terima data kembali
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactScreen(),
            ),
          );

          // Jika kontak baru ditambahkan, tambahkan ke daftar
          if (result != null && result is Contact) {
            addContact(result.name, result.phone);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}