import 'package:flutter/material.dart';
import 'package:sample/features/home/bloc/home_bloc.dart';
import 'package:sample/features/home/models/product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  const ProductTileWidget({super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black26,
          width: 2,
        ),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(productDataModel.imageUrl),
                    fit: BoxFit.cover)),
          ),
          Text(productDataModel.name),
          Text(productDataModel.description),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rs. ${productDataModel.price.toString()}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductWishlistButtonClickedEvent(clickedProduct: productDataModel));
                      //   homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.favorite_border)),
                IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(clickedProduct: productDataModel));
                    },
                    icon: const Icon(Icons.shopping_bag_outlined)),
              ],)


            ],
          )
        ],
      ),
    );
  }
}
