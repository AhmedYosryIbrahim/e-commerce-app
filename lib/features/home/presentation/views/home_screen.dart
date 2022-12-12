import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:store_task/features/home/presentation/widgets/categories_list_widget.dart';
import 'package:store_task/features/home/presentation/widgets/new_arrivals_widget.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../product_details/presentation/cubit/product_details_cubit.dart';
import '../../../product_details/presentation/views/product_details_screen.dart';
import '../widgets/home_app_bar_widget.dart';
import 'package:store_task/injector.dart' as di;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Widget _buildScreen(context) => CustomScrollView(
        slivers: [
          const HomeAppBartWidget(),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    CategoriesListWidget(
                        categories: context.read<HomeCubit>().categories),
                    NewArrivalsWidget(
                      title: AppStrings.mostRecent,
                      seeAllFunction: () {},
                      products: context.read<HomeCubit>().mostRecentList,
                    ),
                    NewArrivalsWidget(
                      title: AppStrings.mostPopular,
                      seeAllFunction: () {},
                      products: context.read<HomeCubit>().mostPopularProducts,
                    )
                  ]),
                );
              }
            },
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (navigatorKey.currentState!.canPop()) {
          navigatorKey.currentState!.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        drawer: const Drawer(),
        body: Navigator(
          key: navigatorKey,
          initialRoute: Routes.initialRoute,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case Routes.initialRoute:
                return MaterialPageRoute(
                  builder: (context) => _buildScreen(context),
                );
              case Routes.productDetailsRoute:
                return MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => di.sl<ProductDetailsCubit>()
                      ..getProductDetailsById(settings.arguments as int),
                    child: const ProductDetailsScreen(),
                  ),
                );
              default:
                return MaterialPageRoute(
                  builder: (context) => _buildScreen(context),
                );
            }
          },
        ),
      ),
    );
  }
}
