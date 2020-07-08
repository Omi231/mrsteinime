import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrsteinime/bloc/recommended_bloc/RecommendedBloc.dart';
import 'package:mrsteinime/bloc/recommended_bloc/RecommendedEvent.dart';
import 'package:mrsteinime/bloc/recommended_bloc/RecommendedState.dart';
import 'package:mrsteinime/model/RecommendedAnime.dart';
import 'package:mrsteinime/ui/DetailAnimePage.dart';

class RecommendedAnimePage extends StatefulWidget {
  var context;
  RecommendedAnimePage({
    this.context
  });
  @override
  _RecommendedAnimePageState createState() => _RecommendedAnimePageState();
}

class _RecommendedAnimePageState extends State<RecommendedAnimePage> {
  RecommendedBloc recommendedBloc;
  var size;

  @override
  void initState() {
    recommendedBloc=BlocProvider.of<RecommendedBloc>(context);
    recommendedBloc.add(FetchRecommendedEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
        size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color:Colors.black87,
        child: BlocBuilder<RecommendedBloc,RecommendedState>(
          bloc: recommendedBloc,
          builder: (context,state){
            if(state is RecommendedUnitializedState){
              return _buildLoadingUI();
            }else if(state is RecommendedFailureState){
              return _buildMessageUI();
            }else if(state is RecommendedLoadedState){
              return _buildListRecommendedUI(state.list);
            }

          })
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
  
 Widget _buildListRecommendedUI(List<RecommendedAnime>list){
   return Container(
     height: double.infinity,
     child: Center(
       child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6,
          crossAxisCount: 3
          ), 
         itemCount: list.length,
         itemBuilder: (context,index){
           return _buildRowRecommendedUI(list[index]);
         }
        ),
     ),
   );
 }

 Widget _buildRowRecommendedUI(RecommendedAnime anime){
   return GestureDetector(
       onTap: (){
        Navigator.push(context, MaterialPageRoute(
              builder: (context2)=> DetailAnimePage(url:anime.url,context:context),
        ));
     },
     child: Container(
       height: double.infinity,
       margin: EdgeInsets.only(bottom: 5),
       padding: EdgeInsets.all(5),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Expanded(
             child: Container(
               width: double.infinity,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 mainAxisSize: MainAxisSize.max,
                 children: <Widget>[
                   Container(
                     decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                       borderRadius: BorderRadius.only(
                         bottomLeft: Radius.circular(10),
                         bottomRight: Radius.circular(10)
                       )
                     ),
                     alignment: Alignment.bottomLeft,
                     padding: EdgeInsets.all(3),
                     child:Text(anime.judul_anime,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),) ,
                   ),
                 ],
               ),
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
           ),
           SizedBox(
             height: 3,
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
              Icon(Icons.tv,color: Colors.white,size: 15,),
              SizedBox(width: 3,),
              Text(anime.type,style: TextStyle(color:Colors.white,fontSize: 12,fontWeight: FontWeight.bold),)
             ],
           ),
            SizedBox(
             height: 3,
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
              Icon(Icons.star,color: Colors.yellow,size: 15,),
              SizedBox(width: 3,),
              Text(anime.rating==" "||anime.rating==null?"Unknown":anime.rating,style: TextStyle(color:Colors.white,fontSize: 12),)
             ],
           ),
           
           
         ],
       ),
     ),
   );
 }

}