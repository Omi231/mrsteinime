import 'package:flutter/material.dart';
import 'package:mrsteinime/model/LatestUpdateAnime.dart';
import 'package:mrsteinime/ui/StreamingPage.dart';

class BeforeStreamingPage extends StatefulWidget {
  var context;
  LatestUpdateAnime latestUpdateAnime;
  
  BeforeStreamingPage({
    this.context,
    this.latestUpdateAnime
  });

  @override
  _BeforeStreamingPageState createState() => _BeforeStreamingPageState();
}

class _BeforeStreamingPageState extends State<BeforeStreamingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image:DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
            image: NetworkImage(widget.latestUpdateAnime.alamat_gambar)
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           Text(widget.latestUpdateAnime.judul_anime,style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
            SizedBox(
             height: 10,
            ),
           Text(widget.latestUpdateAnime.episode,style:TextStyle(color: Colors.white,fontSize: 15),),
            SizedBox(
             height: 10,
            ),
             Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                      GestureDetector(
                          onTap: (){
                             Navigator.push(context, MaterialPageRoute(
                                    builder: (context2)=> StreamingPage(
                                      alamat_gambar: widget.latestUpdateAnime.alamat_gambar,
                                      context: widget.context,
                                      judul: widget.latestUpdateAnime.judul_anime,
                                      url: widget.latestUpdateAnime.url
                                    ),
                              ));              
                          },
                          child: Container(
                            width: 120,
                            margin: EdgeInsets.only(right: 5),
                            padding: EdgeInsets.all(5),
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
                                    Text("  Watch",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
      ),

    );
  }
}