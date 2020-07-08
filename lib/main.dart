import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrsteinime/bloc/detail_bloc/DetailBloc.dart';
import 'package:mrsteinime/bloc/genre_bloc/GenreBloc.dart';
import 'package:mrsteinime/bloc/genre_result_bloc/GenreResultBloc.dart';
import 'package:mrsteinime/bloc/latest_update_bloc/LatestUpdateBloc.dart';
import 'package:mrsteinime/bloc/recommended_bloc/RecommendedBloc.dart';
import 'package:mrsteinime/bloc/search_bloc/SearchBloc.dart';
import 'package:mrsteinime/bloc/streaming_bloc/StreamingBloc.dart';
import 'package:mrsteinime/resource/AnimeResource.dart';
import 'package:mrsteinime/ui/GenrePage.dart';
import 'package:mrsteinime/ui/LatestUpdateAnimePage.dart';
import 'package:mrsteinime/ui/RecommendedAnimePage.dart';
import 'package:mrsteinime/ui/SearchAnimePage.dart';
import 'package:mrsteinime/ui/SplashScreenPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      color: Colors.black,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GenreResultBloc>(create:(context)=>GenreResultBloc(animeRepository: AnimeRepositoryImp())),
          BlocProvider<RecommendedBloc>(create:(context)=>RecommendedBloc(animeRepository: AnimeRepositoryImp())),
          BlocProvider<LatestUpdateBloc>(create:(context)=>LatestUpdateBloc(animeRepository: AnimeRepositoryImp())),
          BlocProvider<GenreBloc>(create:(context)=>GenreBloc(animeRepository: AnimeRepositoryImp())),
          BlocProvider<SearchBloc>(create:(context)=>SearchBloc(animeRepository: AnimeRepositoryImp())),
          BlocProvider<DetailBloc>(create:(context)=>DetailBloc(animeRepository: AnimeRepositoryImp())),
          BlocProvider<StreamingBloc>(create:(context)=>StreamingBloc(animeRepository: AnimeRepositoryImp())),
          
        ],
        child:MyHomePage()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  var context;
  MyHomePage({Key key, this.title,this.context}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  TabController controller;


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  @override
  void initState() {
     controller = new TabController(vsync: this, length: 3);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return  Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Image.asset("assets/icon.png",height: 80,),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                   builder: (context2)=> SearchAnimePage(context: context)
                 ));
              },
              child: Icon(Icons.search)
            ),
            SizedBox(
              width: 4,
            )
          ],
        ),
        body:Container(
          child: Column(
            children: <Widget>[
            Container(
              color: Colors.black,
              child: TabBar(
                controller: controller,
                 indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: "Latest Update",),
                    Tab(text:"Recommend"),
                    Tab(text:"Genre")
                  ]
                ),
            ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                    LatestUpdateAnimePage(),
                    RecommendedAnimePage(),
                    GenrePage()
                  ]
                )
              )
              
            ],
          ),
        )
         // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  

}
