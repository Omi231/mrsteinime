import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrsteinime/bloc/detail_bloc/DetailBloc.dart';
import 'package:mrsteinime/bloc/detail_bloc/DetailEvent.dart';
import 'package:mrsteinime/bloc/detail_bloc/DetailState.dart';
import 'package:mrsteinime/model/DetailAnime.dart';
import 'package:mrsteinime/model/RecommendedAnime.dart';
import 'package:mrsteinime/ui/EpisodePage.dart';

class DetailAnimePage extends StatefulWidget {
  String url;
  var context;
  DetailAnimePage({
    this.url,
    this.context
  });

  @override
  _DetailAnimePageState createState() => _DetailAnimePageState();
}

class _DetailAnimePageState extends State<DetailAnimePage> {
  DetailBloc detailBloc;

  @override
  void initState() {
    detailBloc=BlocProvider.of<DetailBloc>(widget.context);
    detailBloc.add(FetchDetailEvent(url: widget.url));
    super.initState();
  }

  @override
  void dispose() {
    detailBloc.add(ResetDetailEvent());
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: BlocBuilder<DetailBloc,DetailState>(
          bloc: detailBloc,
          builder: (context,state){
            if(state is DetailFailureState){
              return _buildMessageUI();

            }else if(state is DetailUnitializedState){
              return _buildLoadingUI();

            }else if(state is DetailLoadedState){
              print(state.list.toString());
              print("ekssssssskutor");
              return _buildDetailUI(state.detail,state.list);
            }
          }
        ),
      ),

    );
  }

  Widget _buildDetailUI(DetailAnime anime,List<RecommendedAnime> list){
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              fit: BoxFit.cover,
              image: NetworkImage(anime.alamat_gambar),
            )
          ),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
                Text(anime.judul_anime
                ,style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(
                  height: 5,
                ),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Icon(Icons.star,color: Colors.yellow,size: 20,),
                     SizedBox(width: 3,),
                     Text(anime.rating==""?"Unknown":anime.rating,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15),),
                   ],
                 ),
                SizedBox(
                  height:2,
                ),     
                SizedBox(
                  height:5,
                ),
                
               Container(
                 height: 30,
                 child: ListView(
                   scrollDirection: Axis.horizontal,
                   children: anime.genre.map((e) {
                      if(anime.genre.length>0){
                           return Container(
                             alignment: Alignment.center,
                             margin: EdgeInsets.only(right: 5),
                             padding: EdgeInsets.all(4),
                             decoration: BoxDecoration(
                               border: Border.all(
                                 width: 1,
                                 color: Colors.white,
                               ),
                               borderRadius:  new BorderRadius.circular(10.0),
                             ),
                             child: Text(e,style: TextStyle(color: Colors.white),),
                           );
                         }else{
                           return Container();
                         }
                     }).toList()
                 ),
               ),
             ],
          ),
        ),
        SizedBox(
         height: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Icon(Icons.tv,color: Colors.white,size: 17,),
                     SizedBox(width: 5,),
                     Text(anime.type,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 13),),
                   ],
                 ),
                 SizedBox(
                  height: 5,
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Icon(Icons.movie_creation,color: Colors.white,size: 17,),
                     SizedBox(width: 5,),
                     Text(anime.season,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 13),),
                   ],
                 ),
                SizedBox(
                  height: 10,
                ),
              Text("Sinopsis :",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:14),),
               SizedBox(
                  height: 3,
                ),
              Text(anime.sinopsis,style: TextStyle(color: Colors.white),),
               SizedBox(
                  height: 20,
                ),
              GestureDetector(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                          builder: (context2)=> EpisodePage(url:"",context: widget.context,detailAnime: anime,)
                    ));
                },
                child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                     border: Border.all(
                          width: 1,
                          color: Colors.white,
                       ),
                        borderRadius:  new BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.play_arrow,color: Colors.white,size: 17,),
                          Text("  Watch Now",style: TextStyle(color: Colors.white),),
                        ],
                      ),
                ),
              ),
              SizedBox(
                  height: 20,
              ),
              Text("Another Recommended Anime",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:14),),
               _buildRecommendedListUI(list)
            ],
          ),
        )
      ],
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

 Widget _buildRecommendedListUI(List<RecommendedAnime>list){
   return Container(
     width: double.infinity,
     height: 150,
     child: ListView.builder(
       shrinkWrap: true,
      scrollDirection: Axis.horizontal,
       itemCount: list.length,
       itemBuilder: (context,index){
          return _buildRecommendedRowUI(list[index]);
       }
     ),
   );
 }

 Widget _buildRecommendedRowUI(RecommendedAnime anime){
   return GestureDetector(
       onTap: (){
        Navigator.push(context, MaterialPageRoute(
              builder: (context2)=> DetailAnimePage(url:anime.url,context:widget.context),
        ));
     },
     child: Container(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Container(
             height: 90,
             width: 80,
             decoration: BoxDecoration(
                borderRadius:  new BorderRadius.circular(10.0),
                boxShadow: [
                   new BoxShadow(
                        color:Colors.black38,
                        blurRadius: 5.0
                   )
                ],
                image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(anime.alamat_gambar)
                 )
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Container(height:25,width: 100,child: Text(anime.judul_anime,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis,)),
            SizedBox(
             height: 3,
           ),
         ],
       ),
     ),
   );
 }
 

}

