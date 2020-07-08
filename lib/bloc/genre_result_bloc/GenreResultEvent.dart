import 'package:equatable/equatable.dart';

abstract class GenreResultEvent extends Equatable{

}

class FetchGenreResultEvent extends GenreResultEvent{
  String url;
  FetchGenreResultEvent({
    this.url
  });
  @override
  // TODO: implement props
  List<Object> get props => [url];
  
}

class ResetGenreResultEvent extends GenreResultEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}