import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable{}


class FetchDetailEvent extends DetailEvent{
  String url;

  FetchDetailEvent({
    this.url
  });

  @override
  // TODO: implement props
  List<Object> get props => [url];
  
}

class ResetDetailEvent extends DetailEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}