part of 'liked_cubit.dart';

@immutable
abstract class LikedState {

}

class LikedInitial extends LikedState {

  final Icon icon;
  final String count;

  LikedInitial({this.icon = const Icon(Icons.favorite_border), this.count = '0'});

}



class LikedPressed extends LikedState{

  final Icon icon;
  final String count;

  LikedPressed({this.icon = const Icon(Icons.favorite, color: Colors.red,), this.count = '1'});

}