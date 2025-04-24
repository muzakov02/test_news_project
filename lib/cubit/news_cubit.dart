import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_news_project/cubit/news_state.dart';
import 'package:test_news_project/repos/news_repo.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInit());

  Future<void> getNews() async {
    emit(NewsLoading());
    try {
      final result = await NewsRepo().getNews();
      emit(NewsSuccess(result));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
