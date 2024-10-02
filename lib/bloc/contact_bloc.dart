import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_event.dart';
import 'contact_state.dart';
import '../models/contact.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<AddContactEvent>((event, emit) {
      if (state is ContactLoaded) {
        final contacts = List<Contact>.from((state as ContactLoaded).contacts);
        contacts.add(event.contact);
        emit(ContactLoaded(contacts: contacts));
      } else {
        emit(ContactLoaded(contacts: [event.contact]));
      }
    });

    on<RemoveContactEvent>((event, emit) {
      if (state is ContactLoaded) {
        final contacts = List<Contact>.from((state as ContactLoaded).contacts);
        contacts.removeAt(event.index);
        emit(ContactLoaded(contacts: contacts));
      }
    });
  }
}
