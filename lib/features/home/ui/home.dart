import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/features/home/bloc/home_bloc.dart';
import 'package:sample/features/home/ui/product_tile_widget.dart';

import '../../cart/ui/cart.dart';
import '../../wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Cart(),
              ));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Wishlist(),
              ));
        } else if(state is HomeProductItemsCartListedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item carted")));
        }else if(state is HomeProductItemsWishlistListedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item wishlisted")));
        }
      },
      listenWhen: (previous, current) => current is HomeActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.teal,
                    title: const Text(' Grocery App'),
                    actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_bag_outlined)),
                ]),body: ListView.builder(
              itemCount:  successState.products.length,
              itemBuilder: (context, index) {
                  return ProductTileWidget(productDataModel: successState.products[index],homeBloc: homeBloc,);
                },),);

          case HomeErrorState:
            return Scaffold(body: Text("Error"),);
          default:
            return SizedBox();
        }

      },
    );
  }
}
