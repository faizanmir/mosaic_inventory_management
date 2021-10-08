import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mosaic_inventory_management/item_details/services/web_api.dart';
import 'package:mosaic_inventory_management/models/item.dart';
import 'package:mosaic_inventory_management/models/item_response.dart';
import 'package:mosaic_inventory_management/services/item_mixin.dart';

import '../../constants.dart';
class ItemDetailsWebApiImpl with ItemActionsMixin implements ItemDetailsApi{
  @override
  Future<Item> getItem(int itemId,{String? authToken}) async {
    final response = await http.get(
        Uri.parse(baseUrl + "/item/get-item/$itemId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$authToken"
        });
    print(response.body);

    if (response.statusCode == 200) {
      return Item.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("item update encountered a problem ${response.body}");
    }
  }

  @override
  Future<ItemResponse> deleteItem(int categoryId, int itemId, {String? authToken}) {
    return deleteItem(categoryId, itemId,authToken: authToken);
  }

  @override
  Future<ItemResponse> updateItem(int itemCategoryId, int id, Item item, {String? authToken}) {
    return mUpdateItem(itemCategoryId, id, item ,authToken: authToken);
  }

  @override
  Future<ItemResponse> addFilesToItem(int itemId,XFile file,{String? authToken}) {
    return mAddFilesToExistingItems(itemId, file,authToken: authToken);
  }

  @override
  Future<ItemResponse> deleteFileFromItem(int itemId, int fileId, {String? authToken}) async {
    return mDeleteFileFromItem(itemId, fileId,authToken: authToken);
  }


}