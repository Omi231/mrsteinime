import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrsteinime/bloc/latest_update_bloc/LatestUpdateBloc.dart';
import 'package:mrsteinime/bloc/latest_update_bloc/LatestUpdateEvent.dart';
import 'package:mrsteinime/bloc/latest_update_bloc/LatestUpdateState.dart';
import 'package:mrsteinime/model/LatestUpdateAnime.dart';
import 'package:mrsteinime/ui/BeforeStreamingPage.dart';
import 'package:mrsteinime/ui/DetailAnimePage.dart';

class LatestUpdateAnimePage extends StatefulWidget {
    var context;
    LatestUpdateAnimePage({
      this.context
    });

  @override
  _LatestUpdateAnimePageState createState() => _LatestUpdateAnimePageState();
}

class _LatestUpdateAnimePageState extends State<LatestUpdateAnimePage> {
  LatestUpdateBloc latestUpdateBloc;
  ScrollController controller=ScrollController();
  var size;


   void onScroll(){
     double maxScroll=controller.position.maxScrollExtent;
     double currentScroller=controller.position.pixels;
     if(maxScroll==currentScroller){
        latestUpdateBloc.add(FetchLatestUpdateEvent());
     }
   }


  @override
  void initState() {
    latestUpdateBloc=BlocProvider.of<LatestUpdateBloc>(context);
    latestUpdateBloc.add(FetchLatestUpdateEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    controller.addListener(onScroll);
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        color: Colors.black87,
        child: BlocBuilder<LatestUpdateBloc,LatestUpdateState>(
          bloc: latestUpdateBloc,
          builder: (context,state){
            if(state is LatestUpdateLoadedState){
              return _buildListLatestUpdateUI(state.list, state.hasReachMax);
            }else if(state is LatestUpdateUnitializedState){
              return _buildLoadingUI();
            }else if(state is LatestUpdateFailureState){
              return _buildMessageUI();
            }
          },
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

 Widget _buildListLatestUpdateUI(List<LatestUpdateAnime>list,bool hasReachMax){
   return GridView.builder(
     controller: controller,
     itemCount: hasReachMax?list.length:list.length+1,
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       childAspectRatio: 0.6,
       crossAxisCount: 3
      ), 
     itemBuilder: (context,index){
       if(index<list.length){
         return _buildRowLatestUpdateUI(list[index]);
       }else{
         return _buildLoadingUI();
       }
     }
    );
 }



 Widget _buildRowLatestUpdateUI(LatestUpdateAnime anime){
   return GestureDetector(
     onTap: (){
        Navigator.push(context, MaterialPageRoute(
              builder: (context2)=> BeforeStreamingPage(latestUpdateAnime:anime,context:context),
        ));

     },
     child: Container(
       padding: EdgeInsets.all(5),
       margin: EdgeInsets.only(bottom: 10),
       child: Column(
         mainAxisAlignment:  MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Expanded(
             child: Container(
                decoration: BoxDecoration(
                   boxShadow: [
                     new BoxShadow(
                        color:Colors.black38,
                        blurRadius: 2.0
                     )
                   ],
                    borderRadius:  new BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(anime.alamat_gambar)
                    )
                ),
             ),
           ),
            SizedBox(
                height: 5,
            ),
            Text(anime.judul_anime,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis),
            SizedBox(height: 2,),
            Text(anime.episode,style: TextStyle(color: Colors.white,fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis),
         ],
       ),
     ),
   );
 }

}