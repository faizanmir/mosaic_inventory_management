import 'package:mosaic_inventory_management/models/item.dart';
import 'package:mosaic_inventory_management/models/item_response.dart';
import 'package:mosaic_inventory_management/models/items_wrapper.dart';

abstract class ItemsWebApi {
  Future<ItemWrapper> getItemsForCategory(int categoryId,{String? authToken});
  Future<ItemResponse> addItem(int itemCategoryId, String name, double rate, double count,{String? authToken});
  Future<ItemResponse> deleteItem(int categoryId,int itemId,{String? authToken});
  Future<ItemResponse> updateItem(int itemCategoryId,int id,Item item,{String? authToken});
}