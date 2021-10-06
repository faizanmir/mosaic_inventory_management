import 'package:mosaic_inventory_management/base/base_view_model.dart';
import 'package:mosaic_inventory_management/items/navigator/item_navigator.dart';
import 'package:mosaic_inventory_management/items/repos/items_repo.dart';
import 'package:mosaic_inventory_management/models/items_wrapper.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

class ItemsViewModel extends BaseViewModel<ItemNavigator>{
  final ItemsRepo _itemsRepo  =  serviceLocator<ItemsRepo>();
  ItemWrapper? itemWrapper;

  void getItems(int categoryId) async{
    try{
      itemWrapper = await _itemsRepo.getItemsForCategory(categoryId);

    }catch(e){
      print(e);
    }finally{
      notifyListeners();
    }
  }


  void addItem(int itemCategoryId,
  String name,
  double rate,
  double count)async{
    try{
      await _itemsRepo.addItem(itemCategoryId, name, rate, count);
    }catch(e){
      print(e);
    }
  }
}