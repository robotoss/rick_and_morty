import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'character_info_event.dart';
part 'character_info_state.dart';

class CharacterInfoBloc extends Bloc<CharacterInfoEvent, CharacterInfoState> {
  CharacterInfoBloc() : super(CharacterInfoInitialState());

  @override
  Stream<CharacterInfoState> mapEventToState(
    CharacterInfoEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
