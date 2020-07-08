import 'dart:convert';

List<RecommendedAnime>listRecommendedFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"];
  return new List<RecommendedAnime>.from(data.map((x) => RecommendedAnime.fromJson(x)));
}


List<RecommendedAnime>listRecommendedFromJson2(var data){
  return new List<RecommendedAnime>.from(data.map((x) => RecommendedAnime.fromJson(x)));
}

class RecommendedAnime{
  String url;
  String alamat_gambar;
  String judul_anime;
  String rating;
  String type;
  
  RecommendedAnime({
    this.alamat_gambar,
    this.judul_anime,
    this.url,
    this.rating,
    this.type
  });

  factory RecommendedAnime.fromJson(Map<String,dynamic>json)=>new RecommendedAnime(
    alamat_gambar: json["alamat_gambar"],
    judul_anime: json["judul_anime"],
    url: json["url"],
    rating: json["rating"],
    type: json["type"]
  );

}