import 'package:equatable/equatable.dart';
import 'package:mrsteinime/model/Genre.dart';

abstract class GenreState extends Equatable{}


class GenreLoadedState extends GenreState{
  List<Genre>list;
  GenreLoadedState({
    this.list
  });

  @override
  // TODO: implement props
  List<Object> get props => [list];
}


class GenreFailureState extends GenreState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


class GenreUnitializedState extends GenreState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}