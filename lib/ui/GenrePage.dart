import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrsteinime/bloc/genre_bloc/GenreBloc.dart';
import 'package:mrsteinime/bloc/genre_bloc/GenreEvent.dart';
import 'package:mrsteinime/bloc/genre_bloc/GenreState.dart';
import 'package:mrsteinime/model/Genre.dart';
import 'package:mrsteinime/ui/GenreResultAnimePage.dart';

class GenrePage extends StatefulWidget {
  var context;
  GenrePage({
    this.context
  });

  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  GenreBloc genreBloc;
  var size;
  @override
  void initState() {
    print("hasil genre "+context.toString());
    genreBloc=BlocProvider.of<GenreBloc>(context);
    genreBloc.add(FetchGenreEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color:Colors.black87,
        child: BlocBuilder<GenreBloc,GenreState>(
          bloc: genreBloc,
          builder: (context,state){
            if(state is GenreUnitializedState){
              return _buildLoadingUI();
            }else if(state is GenreFailureState){
              return _buildMessageUI();
            }else if(state is GenreLoadedState){
              return _buildListGenreUI(state.list);
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
  
 Widget _buildListGenreUI(List<Genre>list){
   return GridView.builder(
     itemCount: list.length,
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
       childAspectRatio: 2.7
      ),  
     itemBuilder: (context,index){
       return _buildRowGenreUI(list[index]);
     }
    );
 }

 Widget _buildRowGenreUI(Genre anime){
   return GestureDetector(
     onTap: (){
         Navigator.push(context, MaterialPageRoute(
              builder: (context2)=> GenreResultAnimePage(url:anime.url,context: context,genre: anime.judul,)
        ));
     },
     child: Container(
       height: 100,
       margin: EdgeInsets.all(10) ,
       padding: EdgeInsets.all(10),
       decoration: BoxDecoration(
         border: Border.all(
           width: 1,
           color:Colors.white
         ),
         borderRadius:  new BorderRadius.circular(10.0),
       ),
       child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Icon(Icons.movie_filter,color: Colors.white,),
           SizedBox(width: 3,),
           Text(anime.judul,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
       ],),

     ),
   );
 }

}