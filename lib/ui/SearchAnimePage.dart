import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrsteinime/bloc/search_bloc/SearchBloc.dart';
import 'package:mrsteinime/bloc/search_bloc/SearchEvent.dart';
import 'package:mrsteinime/bloc/search_bloc/SearchState.dart';
import 'package:mrsteinime/model/SearchAnime.dart';
import 'package:mrsteinime/ui/DetailAnimePage.dart';

class SearchAnimePage extends StatefulWidget {
  final  context;

  SearchAnimePage({
     this.context,
  });


  @override
  _SearchAnimePageState createState() => _SearchAnimePageState();
}

class _SearchAnimePageState extends State<SearchAnimePage> {
  SearchBloc searchBloc;
  String keyword="";



  @override
  void initState() {
    print("xxxxx");
    print("hasilnya "+context.toString());
    searchBloc=BlocProvider.of<SearchBloc>(widget.context);
    super.initState();
  }

  @override
  void dispose() {
     searchBloc.add(ResetSearchEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(58, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
          ),
          child: TextField(
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.done,
            onChanged: (String terms){
               if(terms.isEmpty){
                   setState(() {
                     keyword=null;
                   });
                  searchBloc.add(ResetSearchEvent());
                  //onlineExamBloc.add(RefreshOnlineExamEvent());
                }
            },
            onSubmitted:(String term){
               keyword=term;
              if(keyword.length>=3){
                searchBloc.add(FetchSearchEvent(keyword: keyword));
              }
            },
            decoration: InputDecoration(  
              isDense: true,
              border: InputBorder.none,
              hintText: "Search..",
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.search,color: Colors.white,)
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: BlocBuilder<SearchBloc,SearchState>(
          bloc: searchBloc,
          builder: (context,state){
            print("Hellosd");
            if(state is SearchFailureState){
              return _buildMessageUI();
            }else if(state is SearchUnitializedState){
              return _buildFirstUI();
            }else if(state is SearchLoadedState){
              if(state.list.isEmpty){
                return _buildEmptyUI();
              }
              return _buildListSearchAnimeUI(state.list);
            }else if(state is SearchLoadingState){
               return _buildLoadingUI();
            }
          }
        ),
      ),
    );
  }

  Widget _buildListSearchAnimeUI(List<SearchAnime>anime){
    return ListView.builder(
      itemCount: anime.length,
      itemBuilder: (context,index){
       return _buildRowSearchAnimeUI(anime[index]);
      }
    );
  }
   
   Widget _buildRowSearchAnimeUI(SearchAnime anime){
     return GestureDetector(
       onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context2)=> DetailAnimePage(url:anime.url,context:widget.context),
        ));
       },
       child: Container(
         padding: EdgeInsets.all(10),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Container(
               margin: EdgeInsets.only(right: 5),
               width: 100,
               height: 150,
               decoration: BoxDecoration(
                  borderRadius:  new BorderRadius.circular(10.0),
                  boxShadow: [
                     new BoxShadow(
                        color:Colors.black38,
                        blurRadius: 2.0
                     )
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(anime.alamat_gambar)
                  )
               ),
             ),
             Container(
               margin: EdgeInsets.only(top:6),
               width: 200,
               height: 150,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(anime.judul_anime,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                   SizedBox(height: 5,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       Icon(Icons.play_circle_filled,color: Colors.white,size: 15,),
                       Text(anime.jumlah_episode,style: TextStyle(color: Colors.white,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)
                     ],
                   ),
                   SizedBox(height: 5,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       Icon(Icons.tv,color: Colors.white,size: 15,),
                       Text(anime.type,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),),
                     ],
                   ),
                   SizedBox(height: 5,),
                   Text(anime.sinopsis,style: TextStyle(color: Colors.white,fontSize: 12),maxLines:4,overflow: TextOverflow.ellipsis,)
                 ],
               ),
             )
           ],
         ),
       ),
     );
   }

   Widget _buildMessageUI(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.signal_cellular_4_bar,color: Colors.white,size: 70,),
            Text(
              "Can't Connect to Server",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildFirstUI(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search,color: Colors.white,size: 70,),
            Text(
              "Find Anime here",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
            ),

          ],
        ),
      ),
    );
  }

   Widget _buildEmptyUI(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.play_circle_filled,color: Colors.white,size: 70,),
            Text(
              "Sorry there is no result",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
            ),

          ],
        ),
      ),
    );
  }

 Widget _buildLoadingUI() {
    return Container(
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
 }


}