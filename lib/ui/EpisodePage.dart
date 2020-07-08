import 'package:flutter/material.dart';
import 'package:mrsteinime/model/DetailAnime.dart';
import 'package:mrsteinime/model/Episode.dart';
import 'package:mrsteinime/ui/StreamingPage.dart';

class EpisodePage extends StatefulWidget {
  String url;
  DetailAnime detailAnime;
  var context;
  EpisodePage({
    this.url,
    this.context,
    this.detailAnime
  });

  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {

  @override
  void initState() {  
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: _buildDetailUI()
      ),
    );
  }

  Widget _buildDetailUI(){
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
              image: NetworkImage(widget.detailAnime.alamat_gambar),
            )
          ),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
                Text(widget.detailAnime.judul_anime
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
                     Text(widget.detailAnime.rating==""?"Unknown":widget.detailAnime.rating,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15),),
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
                    children: widget.detailAnime.genre.map((e) {
                       if(widget.detailAnime.genre.length>0){
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
               Text("List Episode :",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:16),),
               SizedBox(
                  height: 3,
              ),
            ],
          ),
        ),
        SizedBox(
         height: 5,
        ),
        _buildListEpisodeUI(widget.detailAnime.episode)
      ],
    );
  }

  Widget _buildListEpisodeUI(List<Episode>episode){
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
         return _buildRowEpisodeUI(episode[index]);
      }, 
      separatorBuilder: (_,i){
        return Padding(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: Divider(color: Colors.white),
        );
      }, 
      itemCount: episode.length
    );
  }

  Widget _buildRowEpisodeUI(Episode episode){
     return Container(
       padding: EdgeInsets.all(10),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Container(
             margin: EdgeInsets.only(right: 8),
             width: 80,
             height: 80,
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
                  image: NetworkImage(widget.detailAnime.alamat_gambar)
                )
             ),
           ),
           Container(
             margin: EdgeInsets.only(top:6),
             width: 220,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text(widget.detailAnime.judul_anime,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                 SizedBox(height: 5,),
                 Text(episode.episode,style: TextStyle(color: Colors.white,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis,),
                 SizedBox(height: 7,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                      GestureDetector(
                          onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context2)=> StreamingPage(
                                      alamat_gambar: widget.detailAnime.alamat_gambar,
                                      context: widget.context,
                                      judul: widget.detailAnime.judul_anime,
                                      url: episode.url,
                                    )
                              )); 
                          },
                          child: Container(
                            width: 80,
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
                                    Text("  Watch",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                   ],
                 ),
               ],
             ),
           )
         ],
       ),
     );
  }


  


}

