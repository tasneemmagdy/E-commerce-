import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/search_model.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  List<SearchModel> searchList = [];

  void searchProducts(String text){
    emit(SearchLoadingStates());

    dioHelper.getData(
        url: SEARCH,
      query: {
        'q': text,
      },
    ).then((value){
      searchList = [];
      searchModel = SearchModel.fromJson(value.data);
        emit(SearchSuccessStates());

      }).catchError((error){
      emit(SearchFailedStates());
    });
  }

}