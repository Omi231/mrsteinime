import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrsteinime/bloc/genre_result_bloc/GenreResultBloc.dart';
import 'package:mrsteinime/bloc/genre_result_bloc/GenreResultEvent.dart';
import 'package:mrsteinime/bloc/genre_result_bloc/GenreResultState.dart';
import 'package:mrsteinime/model/AnimeGenreResult.dart';
import 'package:mrsteinime/ui/DetailAnimePage.dart';

class GenreResultAnimePage extends StatefulWidget {
  final String url;
  final String genre;
  final  context;

  GenreResultAnimePage({
     this.url,
     this.genre,
     this.context,
  });


  @override
  _GenreResultAnimePageState createState() => _GenreResultAnimePageState();
}

class _GenreResultAnimePageState extends State<GenreResultAnimePage> {
  GenreResultBloc genreResultBloc;
  ScrollController controller=ScrollController();

  void onScroll(){
     double maxScroll=controller.position.maxScrollExtent;
     double currentScroller=controller.position.pixels;
     if(maxScroll==currentScroller){
        genreResultBloc.add(FetchGenreResultEvent(url: widget.url));
     }
  }

  @override
  void initState() {
    print("xxxxx");
    print("hasilnya "+context.toString());
    genreResultBloc=BlocProvider.of<GenreResultBloc>(widget.context);
    genreResultBloc.add(FetchGenreResultEvent(url: widget.url));
    super.initState();
  }

  @override
  void dispose() {
  genreResultBloc.add(ResetGenreResultEvent());
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(onScroll);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre),
      ),
      body: Container(
        color: Colors.black87,
       // child: _buildMessageUI(),
        child: BlocBuilder<GenreResultBloc,GenreResultState>(
          bloc: genreResultBloc,
          builder: (context,state){
            print("Hellosd");
            if(state is GenreResultFailureState){
              return _buildMessageUI();
            }else if(state is GenreResultUnitializedState){
              return _buildLoadingUI();
            }else if(state is GenreResultLoadedState){
              return _buildListGenreResultUI(state.hasReachMax, state.list);
            }
          }
        ),
      ),
    );
  }

  Widget _buildListGenreResultUI(bool hasReachMax,List<AnimeGenreResult>anime){
    return ListView.builder(
      controller: controller,
      itemCount: hasReachMax?anime.length:anime.length+1,
      itemBuilder: (context,index){
        if(index<anime.length){
          return _buildRowGenreResultUI(anime[index]);
        }else{
          return _buildLoadingUI();
        }
      }
    );
  }
   
   Widget _buildRowGenreResultUI(AnimeGenreResult anime){
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
                       Icon(Icons.star,color: Colors.yellow,size: 15,),
                       Text(anime.rating==null || anime.rating==" "?"Unknown":anime.rating,style: TextStyle(color: Colors.white,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)
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

 Widget _buildLoadingUI() {
    return Container(
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
 }


}