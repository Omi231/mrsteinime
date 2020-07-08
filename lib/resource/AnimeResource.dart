import 'package:flutter/foundation.dart';
import 'package:mrsteinime/mixins/Server.dart';
import 'package:mrsteinime/model/AnimeGenreResult.dart';
import 'package:mrsteinime/model/DetailAnime.dart';
import 'package:mrsteinime/model/Genre.dart';
import 'package:mrsteinime/model/LatestUpdateAnime.dart';
import 'package:mrsteinime/model/RecommendedAnime.dart';
import 'package:http/http.dart' as http;
import 'package:mrsteinime/model/SearchAnime.dart';


abstract class AnimeRepository{
  Future<List<LatestUpdateAnime>>getLatestUpdate(int page);
  Future<List<Genre>>getGenre();
  Future<List<RecommendedAnime>>getRecommended();
  Future<List<SearchAnime>>search(String keyword);
  Future<List<AnimeGenreResult>>getGenreResult(String url,int page);
  Future<String>getDetail(String url);
  Future<String>getStreaming(String url);
}

class AnimeRepositoryImp extends AnimeRepository{
  @override
  Future<List<Genre>> getGenre()async {
    var response = await http.get(Server.address+"/genre");
      if (response.statusCode == 200) {
      print(response.body);
      return compute(listGenreFromJson,response.body);
    } else {
      throw Exception();
    }
    // TODO: implement getGenre
  }

  @override
  Future<List<LatestUpdateAnime>> getLatestUpdate(int page) async {
     var response = await http.get(Server.address+"/latest_update?page="+page.toString());
           print(response.body);

      if (response.statusCode == 200) {
      print(response.body);
      return compute(listLatestUpdateFromJson,response.body);
    } else {
      throw Exception();
    }
    // TODO: implement getLatestUpdate
  }

  @override
  Future<List<RecommendedAnime>> getRecommended() async{
      var response = await http.get(Server.address+"/recommended");
      if (response.statusCode == 200) {
      print(response.body);
      return compute(listRecommendedFromJson,response.body);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<SearchAnime>> search(String keyword) async{
      var response = await http.get(Server.address+"/search?s="+keyword);
      if (response.statusCode == 200) {
      print(response.body);
      return compute(listSearchFromJson,response.body);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<AnimeGenreResult>> getGenreResult(String url, int page) async {
       var response = await http.get(Server.address+"/genre_list?url="+url+"&page="+page.toString());
      if (response.statusCode == 200) {
      print(response.body);
      return compute(listGenreResultFromJson,response.body);
    } else {
      throw Exception();
    }
  }

  @override
  Future<String> getDetail(String url) async {
       var response = await http.get(Server.address+"/detail?url="+url);
      if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception();
    }
    // TODO: implement getDetail
  }

  @override
  Future<String> getStreaming(String url) async{
     var response = await http.get(Server.address+"/streaming?url="+url);
      if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception();
    }
  }
 

}