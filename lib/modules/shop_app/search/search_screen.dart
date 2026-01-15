import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/modules/shop_app/product_details/product_details.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Search'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Search must not be empty';
                        }
                        return null;
                      },
                      lable: 'Search',
                      prefix: Icons.search,
                      onChange: (value) {
                        cubit.searchProducts(value);
                      },
                    ),
                    SizedBox(
                        height: 10
                    ),
                    Expanded(
                      child: ConditionalBuilder(
                        condition: state is! SearchLoadingStates,
                        builder: (context) {
                          return ListView.separated(
                            itemBuilder: (context, index) =>
                                buildSearchItem(
                                    cubit.searchModel!.products![index],
                                  context
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemCount: cubit.searchModel?.products?.length ?? 0,
                          );
                        },
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildSearchItem(product , context) {

    return InkWell(
      onTap: ()
      {
        SystemSound.play(SystemSoundType.click);
        navigateTo(
          context,
          ProductDetailsScreen(
              product: product
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Image.network(
              product.thumbnail,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$${product.price}',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
