import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'liked_state.dart';

class LikedCubit extends Cubit<LikedState> {
  LikedCubit() : super(LikedInitial());

  void changeState(){
    if(state is LikedInitial){
      emit(LikedPressed());
    }else{
      emit(LikedInitial());
    }
  }

  Icon get icon{

    final currentState = state;

    if(currentState is LikedInitial){
      return currentState.icon;
    }
    else if (currentState is LikedPressed){
      return currentState.icon;
    }
    return const Icon(Icons.disabled_visible);
  }

  String get count{
    final currentState = state;

    if(currentState is LikedInitial){
      return currentState.count;
    }
    else if (currentState is LikedPressed){
      return currentState.count;
    }
    return '-1';
  }
}
