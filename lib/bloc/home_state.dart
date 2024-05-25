import 'package:equatable/equatable.dart';
import 'package:exam_news/models/articles_model.dart';



abstract class HomeState extends Equatable{}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}
class HomeLoadingState extends HomeState{
  List<Object?>get props=>[];
}


class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class HomeArticleListState extends HomeState {
  final List<Article> articles;

  HomeArticleListState(this.articles);

  @override
  List<Object?> get props => [articles];
}