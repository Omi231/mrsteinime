import 'dart:convert';

List<SearchAnime>listSearchFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"];
  return new List<SearchAnime>.from(data.map((x) => SearchAnime.fromJson(x)));
}

class SearchAnime{
  String url;
  String alamat_gambar;
  String judul_anime;
  String sinopsis;
  String jumlah_episode;
  String type;

  SearchAnime({
    this.url,
    this.sinopsis,
    this.alamat_gambar,
    this.judul_anime,
    this.jumlah_episode,
    this.type
  });
  
  factory SearchAnime.fromJson(Map<String,dynamic>json)=>SearchAnime(
    alamat_gambar: json["alamat_gambar"],
    judul_anime: json["judul_anime"],
    sinopsis: json["sinopsis"],
    url: json["url"],
    jumlah_episode: json["jumlah_episode"],
    type: json["type"]
  );

}