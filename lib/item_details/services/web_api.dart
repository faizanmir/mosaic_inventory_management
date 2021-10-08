
import 'package:image_picker/image_picker.dart';
import 'package:mosaic_inventory_management/models/item.dart';
import 'package:mosaic_inventory_management/models/item_response.dart';

abstract class ItemDetailsApi{
  Future<Item> getItem(int itemId,{String? authToken});
  Future<ItemResponse> deleteItem(int categoryId,int itemId,{String? authToken});
  Future<ItemResponse> updateItem(int itemCategoryId,int id,Item item,{String? authToken});
  Future<ItemResponse> addFilesToItem(int itemId,XFile file,{String? authToken});
  Future<ItemResponse> deleteFileFromItem(int itemId,int fileId,{String? authToken});
}