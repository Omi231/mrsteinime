import 'dart:convert';

List<AnimeGenreResult>listGenreResultFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"];
  return new List<AnimeGenreResult>.from(data.map((x) => AnimeGenreResult.fromJson(x)));
}

class AnimeGenreResult{
  String url;
  String alamat_gambar;
  String judul_anime;
  String sinopsis;
  String rating;
  String type;

  AnimeGenreResult({
    this.url,
    this.sinopsis,
    this.alamat_gambar,
    this.judul_anime,
    this.rating,
    this.type
  });
  
  factory AnimeGenreResult.fromJson(Map<String,dynamic>json)=>AnimeGenreResult(
    alamat_gambar: json["alamat_gambar"],
    judul_anime: json["judul_anime"],
    sinopsis: json["sinopsis"],
    url: json["url"],
    rating: json["rating"],
    type: json["type"]
  );

}