import 'dart:convert';

import 'Episode.dart';

DetailAnime detailAnimeFromJson(String response){
   final jsonData = json.decode(response);
   final data=jsonData["data"];
  return DetailAnime.fromJson(data);
}

List<String>listFromJson(var data){
   return new List<String>.from(data.map((x) => x));
}

class DetailAnime{
  String alamat_gambar;
  String judul_anime;
  String sinopsis;
  List<String> genre;
  List<Episode>episode;
  String rating;
  String type;
  String season;

  DetailAnime({
    this.alamat_gambar,
    this.episode,
    this.sinopsis,
    this.judul_anime,
    this.genre,
    this.rating,
    this.type,
    this.season
  });

  factory DetailAnime.fromJson(Map<String,dynamic>json)=>new DetailAnime(
    alamat_gambar: json["alamat_gambar"],
    episode: listEpisodeFromJson(json["episode"]),
    genre: json["genre"]!=null?listFromJson(json["genre"]):null,
    sinopsis: json["sinopsis"],
    judul_anime: json["judul_anime"],
    rating:json["rating"],
    type: json["type"],
    season: json["season"]
  );
}