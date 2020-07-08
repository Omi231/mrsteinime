import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{}


class FetchSearchEvent extends SearchEvent{
  String keyword;
  FetchSearchEvent({
    this.keyword
  });
  @override
  // TODO: implement props
  List<Object> get props => [keyword];
  
}


class ResetSearchEvent extends SearchEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}