import 'package:equatable/equatable.dart';
import 'package:mrsteinime/model/SearchAnime.dart';

abstract class SearchState extends Equatable{}


class SearchLoadedState extends SearchState{
  List<SearchAnime>list;
  SearchLoadedState({
    this.list
  });

  @override
  // TODO: implement props
  List<Object> get props => [list];
}


class SearchFailureState extends SearchState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class SearchLoadingState extends SearchState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}


class SearchUnitializedState extends SearchState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}