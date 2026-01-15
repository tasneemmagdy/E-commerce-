import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/constants.dart';
import 'package:shop_app/models/shop_app/carts_model.dart';
import 'package:shop_app/modules/shop_app/carts/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class CartsCubit extends Cubit<CartsStates>{

  CartsCubit() : super(CartsInitialState());

  static CartsCubit get(context) => BlocProvider.of(context);

  CartsModel? cartsModel;

  void getCarts({
    required int userId
})
  {
    emit(CartsLoadingState());
    dioHelper.getData(
        url: '/carts/user/$userId',
      token: token
    ).then((value){
      cartsModel = CartsModel.fromJson(value.data);
      emit(CartsSuccessState());
    }).catchError((error){
      emit(CartsFailedState());
    });
  }

  void addToCarts({
    required int userId,
    required int productId,
    required int productQuantity,
}){
    emit(CartsLoadingState());
    dioHelper.postData(
        url: ADD_CARTS,
        data: {
          'userId' : userId,
          'products': [
            {
              'id': productId,
              'quantity': productQuantity
            }
          ]
        }
    ).then((value){
      cartsModel = CartsModel.fromJson(value.data);
      emit(CartsSuccessState());
    }).catchError((error){
      emit(CartsFailedState());
    });
  }

  void removeFromCarts({
    required int userId,
    required int productId,
  })
  {
    emit(CartsLoadingState());
    dioHelper.DeleteData(
        url: 'carts/$userId/products/$productId',
      token: token
    ).then((value){
      cartsModel = CartsModel.fromJson(value.data);
      emit(CartsSuccessState());
    }).catchError((error){
      emit(CartsFailedState());
    });
  }

  void updateQuantity({
    required int cartId,
    required int productId,
    required int quantity,
}){
    emit(CartsLoadingState());
    dioHelper.putData(
        url: 'carts/$cartId',
        query: {
          'products': [
          {
            "id": productId,
            "quantity": quantity,
          }
        ]
        }
    ).then((value){
      cartsModel = CartsModel.fromJson(value.data);
      emit(CartsSuccessState());
    }).catchError((error){
      emit(CartsFailedState());
    });
  }

  void clearCart() {
    cartsModel = null;
    emit(CartsClearState());
  }

}