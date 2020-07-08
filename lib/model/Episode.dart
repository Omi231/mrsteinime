import 'dart:convert';

List<Episode>listEpisodeFromJson(var data){
  return new List<Episode>.from(data.map((x) => Episode.fromJson(x)));
}

class Episode{
  String url;
  String episode;

  Episode({
    this.url,
    this.episode
  });

  factory Episode.fromJson(Map<String,dynamic>json)=>new Episode(
    episode: json["episode"],
    url: json["url"]
  );

}