import 'package:mosaic_inventory_management/base/base_view_model.dart';
import 'package:mosaic_inventory_management/item_category/navigator/item_category_navigator.dart';
import 'package:mosaic_inventory_management/item_category/repos/category_repo.dart';
import 'package:mosaic_inventory_management/models/user_category_reponse.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

class CategoryViewModel extends BaseViewModel<CategoryNavigator> {
  final CategoryRepository? _categoryRepository =
      serviceLocator<CategoryRepository>();
  UserCategoryResponse? userCategoryResponse;

  void getCategories() async {
    try {
      userCategoryResponse = await _categoryRepository?.getCategoriesForUser();
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  void addCategory(String name) async {
    try {
      await _categoryRepository?.addCategory(name);
      getNavigator().onCategoryAdded();
    } catch (e) {
      print(e);
    }
  }

  void deleteCategory(int id) async {
    try {
      var response = await _categoryRepository?.deleteCategory(id);
      getNavigator().showMessage("${response!.message}");
      getNavigator().onCategoryDeleted();
    } catch (e) {
      print(e);
    }
  }

  void onLogout()async {
    await _categoryRepository?.deleteAccessToken();
  }
}
