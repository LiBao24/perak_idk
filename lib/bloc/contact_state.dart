import 'package:equatable/equatable.dart';
import '../models/contact.dart';

abstract class ContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoaded extends ContactState {
  final List<Contact> contacts;

  ContactLoaded({required this.contacts});

  @override
  List<Object?> get props => [contacts];
}
