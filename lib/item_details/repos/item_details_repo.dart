import 'package:image_picker/image_picker.dart';
import 'package:mosaic_inventory_management/auth_token_prefs/auth_token_mixin.dart';
import 'package:mosaic_inventory_management/item_details/services/web_api.dart';
import 'package:mosaic_inventory_management/models/item.dart';
import 'package:mosaic_inventory_management/models/item_response.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

class ItemDetailsRepo with AuthTokenMixin implements ItemDetailsApi {
  final ItemDetailsApi _itemDetailsApi = serviceLocator<ItemDetailsApi>();
  @override
  Future<Item> getItem(int itemId, {String? authToken}) async {
    return _itemDetailsApi.getItem(itemId, authToken: await mGetAccessToken());
  }

  @override
  Future<ItemResponse> deleteItem(int categoryId, int itemId,
      {String? authToken}) async {
    return _itemDetailsApi.deleteItem(categoryId, itemId,
        authToken: await mGetAccessToken());
  }

  @override
  Future<ItemResponse> updateItem(int itemCategoryId, int id, Item item,
      {String? authToken}) async {
    return _itemDetailsApi.updateItem(itemCategoryId, id, item,
        authToken: await mGetAccessToken());
  }

  @override
  Future<ItemResponse> addFilesToItem(int itemId, XFile file,
      {String? authToken}) async {
    return _itemDetailsApi.addFilesToItem(itemId, file,
        authToken: await mGetAccessToken());
  }

  @override
  Future<ItemResponse> deleteFileFromItem(int itemId, int fileId,
      {String? authToken}) async {
    return _itemDetailsApi.deleteFileFromItem(itemId, fileId,
        authToken: await mGetAccessToken());
  }
}
