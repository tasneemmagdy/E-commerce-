import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/constants.dart';
import 'package:shop_app/models/shop_app/product_model.dart';
import 'package:shop_app/modules/shop_app/category_details/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCategoriesDetailsCubit extends Cubit<ShopCategoriesDetailsStates> {

  ShopCategoriesDetailsCubit() : super(ShopCategoriesDetailsInitialStates());


  static ShopCategoriesDetailsCubit get(context) => BlocProvider.of(context);

  List<ProductsDataModel> categoriesDetails = [];

  void getCategoriesDetails(String categoryName){

    emit(ShopCategoriesDetailsLoadingStates());

    dioHelper.getData(
        url: '$CATEGORY_PRODUCTS/$categoryName',
      token: token,
    ).then((value){
      var response = ProductModel.fromJson(value.data);
      categoriesDetails = response.products ?? [];
      emit(ShopCategoriesDetailsSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopCategoriesDetailsFailStates(error));
    });
  }

  void updateLocalFavorite(int productId) {
    var product = categoriesDetails.firstWhere((item) => item.id == productId);
    product.inFavorites = !product.inFavorites;
    emit(ShopCategoriesDetailsSuccessStates());
  }



}
