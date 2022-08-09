import 'package:agence/diohelper/dio_helper.dart';
import 'package:agence/modeles/searchmodel.dart';
import 'package:agence/shared/components/constante.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  Search? searchmodel;
  void search(String text) {
    emit(LodinSearchState());
    DioHelper.postData(
      url: SEARCH,
      token: TOKEN,
      data: {'text': text},
    ).then((value) {
      searchmodel = Search.fromJson(value.data);
      emit(GoodSearchState());
    }).catchError((e) {
      emit(BadSearchState());
      print(e.toString());
    });
  }
}
