abstract class ShopCategoriesDetailsStates{}

class ShopCategoriesDetailsInitialStates extends ShopCategoriesDetailsStates{}

class ShopCategoriesDetailsLoadingStates extends ShopCategoriesDetailsStates{}

class ShopCategoriesDetailsSuccessStates extends ShopCategoriesDetailsStates{}

class ShopCategoriesDetailsFailStates extends ShopCategoriesDetailsStates{
  final String error;
  ShopCategoriesDetailsFailStates(this.error);

}

