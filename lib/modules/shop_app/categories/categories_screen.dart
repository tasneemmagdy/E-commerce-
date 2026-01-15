import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/category_model.dart';
import 'package:shop_app/modules/shop_app/category_details/category_details.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCategoryItem(
            cubit.categoryModel![index],
            context,
          ),
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            color: Colors.grey,
          ),
          itemCount: cubit.categoryModel!.length,
        );
      },
    );
  }

  Widget buildCategoryItem(CategoryModel model, BuildContext context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            model.url ?? '',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: const Icon(Icons.category, size: 50),
              );
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            model.name ?? 'Category',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            navigateTo(
              context,
              CategoryProductsScreen(categoryName: model.name ?? ''),
            );
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    ),
  );
}