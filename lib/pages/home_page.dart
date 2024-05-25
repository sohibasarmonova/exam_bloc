import 'package:exam_news/bloc/home_bloc.dart';
import 'package:exam_news/bloc/home_event.dart';
import 'package:exam_news/bloc/home_state.dart';
import 'package:exam_news/models/articles_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  late HomeBloc homeBloc;

  //int currentPage = 1;
//List<Article> list = [];

  //
  // loadArticleNews() async {
  //   var response =
  //   await Network.GET(Network.API_NEWS_INFOS, Network.paramsArticle());
  //   List<Article> articles = Network.parseArticles(response!);
  //   print(articles.length);
  //   setState(() {
  //     list = articles;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadArticleNews();
    homeBloc = context.read<HomeBloc>();
    homeBloc.add(LoadArticleNewsListEvent());
    //print(list.length);
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent <= scrollController.offset){
        homeBloc.add(LoadArticleNewsListEvent());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("N E W S",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Stack(
            children: [
              ListView.builder(
                  controller: scrollController,
                  itemCount: homeBloc.list.length,
                  itemBuilder: (context, index) {
                    return itemOfArticleListNews(homeBloc.list[index], index);
                  }
              )

            ],
          );
        },

      ),
    );
  }

  Widget itemOfArticleListNews(Article list, int index) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                      image: NetworkImage(list.urlToImage!),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(),
              Card(
                color: Colors.black54,
                margin: EdgeInsets.all(20),
                child: Text(
                  list.source!.name!,
                  style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),


            ],
          ),
        ),
        SizedBox(),
        Card(
          margin: EdgeInsets.all(10),
          color: Colors.black54,

          child: Text(
            list.title!,
            style: TextStyle(fontSize: 16, color: Colors.white,),
          ),
        ),

        SizedBox(),
        Card(
          margin: EdgeInsets.all(10),
          color: Colors.black54,
          child: Text(
            list.description!,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        SizedBox(),
        Card(
          margin: EdgeInsets.all(10),
          color: Colors.black54,
          child: Text(
            list.content!,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        SizedBox(),
        Card(
          margin: EdgeInsets.all(10),
          color: Colors.black54,
          child: Text(

            list.url!,
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}