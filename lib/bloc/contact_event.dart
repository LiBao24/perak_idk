import 'package:equatable/equatable.dart';
import '../models/contact.dart';

abstract class ContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddContactEvent extends ContactEvent {
  final Contact contact;

  AddContactEvent(this.contact);

  @override
  List<Object?> get props => [contact];
}

class RemoveContactEvent extends ContactEvent {
  final int index;

  RemoveContactEvent(this.index);

  @override
  List<Object?> get props => [index];
}
