part of 'characters_bloc.dart';

abstract class CharactersEvent {}

class GetAllCharactersEvent extends CharactersEvent {}

class GetMoreCharactersEvent extends CharactersEvent {}
