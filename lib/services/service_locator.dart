import 'package:get_it/get_it.dart';
import 'package:mosaic_inventory_management/item_category/repos/category_repo.dart';
import 'package:mosaic_inventory_management/item_category/services/web.dart';
import 'package:mosaic_inventory_management/item_category/services/web_api_impl.dart';
import 'package:mosaic_inventory_management/item_category/viewModel/category_view_model.dart';
import 'package:mosaic_inventory_management/item_details/repos/item_details_repo.dart';
import 'package:mosaic_inventory_management/item_details/services/web_api.dart';
import 'package:mosaic_inventory_management/item_details/services/web_api_impl.dart';
import 'package:mosaic_inventory_management/item_details/viewModel/item_details_view_model.dart';
import 'package:mosaic_inventory_management/items/repos/items_repo.dart';
import 'package:mosaic_inventory_management/items/services/web_api.dart';
import 'package:mosaic_inventory_management/items/services/web_api_impl.dart';
import 'package:mosaic_inventory_management/items/viewModel/items_view_model.dart';
import 'package:mosaic_inventory_management/login/repos/login_repo.dart';
import 'package:mosaic_inventory_management/login/services/web/web.dart';
import 'package:mosaic_inventory_management/login/services/web/web_impl.dart';
import 'package:mosaic_inventory_management/login/viewModel/login_view_model.dart';

final serviceLocator = GetIt.instance;
void setupServices() {
  //login
  serviceLocator
    ..registerLazySingleton<LoginWebApi>(() => LoginWebApiImpl())
    ..registerLazySingleton<LoginRepository>(() => LoginRepository())
    ..registerFactory<LoginViewModel>(() => LoginViewModel());

  //category
  serviceLocator
    ..registerLazySingleton<CategoryWebApi>(() => CategoryWebApiImpl())
    ..registerSingleton(CategoryRepository())
    ..registerFactory(() => CategoryViewModel());

  //item
  serviceLocator
    ..registerLazySingleton<ItemsWebApi>(() => ItemsWebApiImpl())
    ..registerSingleton(ItemsRepo())
    ..registerFactory(() => ItemsViewModel());

  //item details
  serviceLocator
    ..registerLazySingleton<ItemDetailsApi>(() => ItemDetailsWebApiImpl())
    ..registerSingleton(ItemDetailsRepo())
    ..registerFactory(() => ItemDetailsViewModel());
}
