
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosaic_inventory_management/base/base_view_model.dart';
import 'package:mosaic_inventory_management/item_details/navigator/item_details_navigator.dart';
import 'package:mosaic_inventory_management/item_details/repos/item_details_repo.dart';
import 'package:mosaic_inventory_management/models/item.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

class ItemDetailsViewModel extends BaseViewModel<ItemDetailsNavigator>  {
  final ItemDetailsRepo _itemDetailsRepo  =  serviceLocator<ItemDetailsRepo>();
  Item? item;

  void getItem(int itemId)async{
    try{
      item = await _itemDetailsRepo.getItem(itemId);
    }catch(e){
      debugPrint(e.toString());
    }finally{
      notifyListeners();
    }
  }


  void changeRate(int itemCategoryId,int id,double rate)async {
    try {
      final response = await _itemDetailsRepo.updateItem(
          itemCategoryId, id, Item.fromMap({"rate": rate}));
      getNavigator().showMessage(response.message!);
    }catch(e){
      debugPrint(e.toString());
    }
  }


  void addFilesToItem(int id,XFile file)async {
    try{

      final response  =  await _itemDetailsRepo.addFilesToItem(id, file);
      getNavigator().showMessage(response.message!);
      getNavigator().onImageAdded();
    }catch(e){
      debugPrint(e.toString());
    }finally{
      notifyListeners();
    }
  }


  void deleteFile(int itemId, int fileId) async {
    try{
      final response  =  await _itemDetailsRepo.deleteFileFromItem(itemId, fileId);
      getNavigator().showMessage(response.message!);
      getNavigator().onImageDeleted();
    }catch(e){
      debugPrint(e.toString());
    }
  }




}