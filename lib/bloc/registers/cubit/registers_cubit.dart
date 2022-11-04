import 'package:bloc/bloc.dart';
import 'package:flutter_zataca/main.dart';
import 'package:flutter_zataca/models/myRegister.dart';
import 'package:flutter_zataca/services/petitions.dart';
import 'package:meta/meta.dart';


part 'registers_state.dart';

class RegistersCubit extends Cubit<RegistersState> {
  RegistersCubit() : super(RegistersInitial());

  final Petitions _petitions = getIt();

  void loadRegisters() async{
      final currentState = state;
    if(currentState is RegistersInitial){
      changeLoadedState(_petitions.getHttp());
    }
  }

  void changeLoadedState(Future<List<MyRegister>?> registersList){
    final currentState = state;
    if (currentState is RegistersInitial){
      emit(RegistersLoaded(registersList));
    }
  }
}
