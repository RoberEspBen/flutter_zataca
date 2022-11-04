part of 'registers_cubit.dart';

@immutable
abstract class RegistersState {}

class RegistersInitial extends RegistersState {}

class RegistersLoaded extends RegistersState {

  Future<List<MyRegister>?> myRegisters;

  RegistersLoaded(this.myRegisters);

}
