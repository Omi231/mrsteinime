import 'dart:convert';

List<LatestUpdateAnime>listLatestUpdateFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"];
  return new List<LatestUpdateAnime>.from(data.map((x) => LatestUpdateAnime.fromJson(x)));
}

class LatestUpdateAnime{
  String url;
  String judul_anime;
  String alamat_gambar;
  String episode;
  String rating;

  LatestUpdateAnime({
    this.url,
    this.judul_anime,
    this.episode,
    this.alamat_gambar,
    this.rating
  });

  factory LatestUpdateAnime.fromJson(Map<String,dynamic>json)=> new LatestUpdateAnime(
    alamat_gambar: json["alamat_gambar"],
    episode: json["episode"],
    judul_anime: json["judul_anime"],
    url: json["url"],
    rating: json["rating"]
  );
}