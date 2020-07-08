import 'package:equatable/equatable.dart';

abstract class StreamingEvent extends Equatable{}


class FetchStreamingEvent extends StreamingEvent{
  String url;

  FetchStreamingEvent({
    this.url
  });

  @override
  // TODO: implement props
  List<Object> get props => [url];
  
}

class ResetStreamingEvent extends StreamingEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}