import 'dart:convert';

List<Genre>listGenreFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"];
  return new List<Genre>.from(data.map((x) => Genre.fromJson(x)));
}

class Genre{
  String url;
  String judul;
  
  Genre({
    this.url,
    this.judul
  });

  factory Genre.fromJson(Map<String,dynamic>json)=>new Genre(
    judul: json["judul"],
    url: json["url"]
  );

}