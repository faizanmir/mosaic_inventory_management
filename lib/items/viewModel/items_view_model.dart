import 'package:flutter/cupertino.dart';
import 'package:mosaic_inventory_management/base/base_view_model.dart';
import 'package:mosaic_inventory_management/items/navigator/item_navigator.dart';
import 'package:mosaic_inventory_management/items/repos/items_repo.dart';
import 'package:mosaic_inventory_management/models/item.dart';
import 'package:mosaic_inventory_management/models/items_wrapper.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

import 'item_manager/item_details_manager.dart';

class ItemsViewModel extends BaseViewModel<ItemNavigator>{
  final ItemsRepo _itemsRepo  =  serviceLocator<ItemsRepo>();
  ItemWrapper? itemWrapper;




  onNotify(){
    notifyListeners();
  }


  void getItems(int categoryId) async{
    try{
      itemWrapper = await _itemsRepo.getItemsForCategory(categoryId);

    }catch(e){
      debugPrint(e.toString());
    }finally{
      notifyListeners();
    }
  }


  void addItem(int itemCategoryId,
  String name,
  double rate,
  double count)async{
    try{
     var response  =  await _itemsRepo.addItem(itemCategoryId, name, rate, count);
     getNavigator().onItemUploaded(response.message!);
    }catch(e){
      debugPrint(e.toString());
      getNavigator().onItemUploadFailed("Item upload failed");
    }
  }

  void updateCountForItem(int itemCategoryId,int id,double count)async{
    try {
      var item =  Item.fromMap({"count":count});
      var response = await _itemsRepo.updateItem(itemCategoryId, id, item);
      getNavigator().onItemUploaded(response.message!);
    }catch(e){
      debugPrint(e.toString());
      getNavigator().onItemUploadFailed("Item upload failed");
    }
  }


  void deleteItem(int itemId,int categoryId)async{
    try {
      var response = await _itemsRepo.deleteItem(categoryId, itemId);
      getNavigator().onItemUploaded(response.message!);
    }catch(e){
      debugPrint(e.toString());
      getNavigator().onItemUploadFailed("Item delete failed");
    }
  }


  void addFilesToItem(){

  }


  void changePriceOfItem(){

  }




}