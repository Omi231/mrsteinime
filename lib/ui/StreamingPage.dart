import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mrsteinime/bloc/streaming_bloc/StreamingBloc.dart';
import 'package:mrsteinime/bloc/streaming_bloc/StreamingEvent.dart';
import 'package:mrsteinime/bloc/streaming_bloc/StreamingState.dart';
import 'package:mrsteinime/model/Episode.dart';
import 'package:flutter/services.dart';


class StreamingPage extends StatefulWidget {
  String url;
  var context;
  String alamat_gambar;
  String judul;
  StreamingPage({
    this.url,
    this.context,
    this.alamat_gambar,
    this.judul
  });

  @override
  _StreamingPageState createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
    InAppWebViewController webView;
    StreamingBloc streamingBloc;

   var video_src="https://uservideo.xyz/file/nanime.kkg.11.480p.mp4?embed=true";
  @override
  void initState() {
    streamingBloc=BlocProvider.of<StreamingBloc>(widget.context);
    streamingBloc.add(FetchStreamingEvent(url: widget.url));
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.judul)
      ),
      body: Container(
        color: Colors.black87,
        child: BlocBuilder<StreamingBloc,StreamingState>(
          bloc: streamingBloc,
          builder: (context,state){
            if(state is StreamingFailureState){
              return _buildMessageUI();
            }else if(state is StreamingUnitializedState){
              return _buildLoadingUI();

            }else if(state is StreamingLoadedState){
              return _buildStreamingUI(state.video_url, state.episode, state.judul_anime);
            }
          }
        )
     )
    );
  }
  Widget _buildStreamingUI(String url,List<Episode>list,String judul_anime){
    print(setEmbedHtml(url));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildWebViewUI(setEmbedHtml(url)),
        SizedBox(height:5),
         Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.all(5),
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(judul_anime,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 3,),
                      Text("Pilih Episode",style: TextStyle(fontSize: 12,color: Colors.white),)
                    ],
                ),
         ),
        Expanded(
          child: ListView(
            children: <Widget>[               
              _buildListEpisodeUI(list)
            ],
          ),
        )
      ],
    );
  }
   
  Widget _buildWebViewUI(String url){
      return Container(
        width: double.infinity,
        height: 230,
        child: InAppWebView(
          initialData: InAppWebViewInitialData(data: url),
          onEnterFullscreen: (InAppWebViewController controller){
             SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
          },
          onWebViewCreated: (InAppWebViewController controller){
             webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {

          },
          onLoadStop: (InAppWebViewController controller, String url) {

          },

        ),
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
         crossAxisAlignment: CrossAxisAlignment.start,
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
                  image: NetworkImage(widget.alamat_gambar)
                )
             ),
           ),
           Container(
             margin: EdgeInsets.only(top:6),
             width: 220,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text(widget.judul,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
                 SizedBox(height: 5,),
                Text(episode.episode,style: TextStyle(color: Colors.white,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,),
                 SizedBox(height: 5,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                      GestureDetector(
                          onTap: (){
                               Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context2)=> StreamingPage(
                                      alamat_gambar: widget.alamat_gambar,
                                      context: widget.context,
                                      judul: widget.judul,
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
                   ],
                 ),
               ],
             ),
           )
         ],
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

   String setEmbedHtml(String url){
     return """<!DOCTYPE html>
          <html>
            <head>
            <style>
            body {
              overflow: hidden; 
            }
        .embed-youtube {
            position: relative;
            padding-bottom: 56.25%; 
            padding-top: 0px;
            height: 0;
            overflow: hidden;
        }

        .embed-youtube iframe,
        .embed-youtube object,
        .embed-youtube embed {
            border: 0;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        </style>

        <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
          <meta http-equiv="X-UA-Compatible" content="ie=edge">
           </head>
          <body bgcolor="#121212">                                    
        <div class="embed-youtube">
         <iframe
          id="vjs_video_3_Youtube_api"
          style="width:100%;height:100%;top:0;left:0;position:absolute;"
          class="vjs-tech holds-the-iframe"
          frameborder="0"
          allowfullscreen="1"
          allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
          webkitallowfullscreen mozallowfullscreen allowfullscreen
          title="Live Tv"
          frameborder="0"
          src="$url"
          ></iframe></div>
          </body>                                    
        </html>
  """;
   }
  
  


}