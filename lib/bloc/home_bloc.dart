
import 'package:exam_news/models/post_news_model.dart';
import 'package:exam_news/service/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Article> articles = [];

  HomeBloc() : super(HomeInitialState()) {
    on<LoadArticleListEvent>( _loadArticles);
  }


  Future<void>  _loadArticles(LoadArticleListEvent event,
      Emitter<HomeState>emitter) async {
    var response =
    await Network.GET(Network.API_GET_NEWS, Network.paramsArticle());
    List<Article> articlesList = Network.parseArticles(response!);
    print(articlesList.length);

    articles = articlesList;
    emit(HomeLoadingState());
  }
}