import 'package:equatable/equatable.dart';
import 'package:mrsteinime/model/AnimeGenreResult.dart';






abstract class GenreResultState extends Equatable{}

class GenreResultUnitializedState extends GenreResultState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}

class GenreResultFailureState extends GenreResultState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}


class GenreResultLoadedState extends GenreResultState{
  List<AnimeGenreResult>list;
  int page;
  bool hasReachMax;

  GenreResultLoadedState({
    this.list,
    this.hasReachMax,
    this.page
  });

  GenreResultLoadedState copyWith({List<AnimeGenreResult>list,int page,bool hasReachMax}){
    return GenreResultLoadedState(
      hasReachMax: hasReachMax ?? this.hasReachMax,
      page: page ?? this.page,
      list: list ?? this.list
    );
  }


  @override
  List<Object> get props => [list,page,hasReachMax];
  
}