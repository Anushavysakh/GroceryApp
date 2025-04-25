import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/features/home/bloc/home_bloc.dart';

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
        }
      },
      listenWhen: (previous, current) => current is HomeActionState,
      builder: (context, state) {
        switch(state.runtimeType){
          case HomeLoadingState :
            return Scaffold(body: ,);
            break;
          case HomeLoadedSuccessState:
            break;

          case HomeErrorState:
          default:

        }
      },
    );
  }
}
