import 'package:bloc/bloc.dart';
import 'package:exam_news/models/articles_model.dart';
import 'package:exam_news/service/http_service.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int currentPage = 1;
  List<Article> list = [];
  HomeBloc() : super(HomeInitialState()) {
    on<LoadArticleNewsListEvent>(_onLoadArticlesListEvent);
  }

  Future<void> _onLoadArticlesListEvent(LoadArticleNewsListEvent event, Emitter<HomeState> emit) async{
    var response =
    await Network.GET(Network.API_NEWS_INFOS, Network.paramsArticle());
      emit(HomeLoadingState());
    List<Article> articles  = Network.parseArticles(response!);
    list.addAll(articles);
    emit(HomeArticleListState(list));
  }
}

