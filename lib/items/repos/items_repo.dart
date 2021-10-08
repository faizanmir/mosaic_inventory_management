import 'package:mosaic_inventory_management/auth_token_prefs/auth_token_mixin.dart';
import 'package:mosaic_inventory_management/items/services/web_api.dart';
import 'package:mosaic_inventory_management/models/item.dart';
import 'package:mosaic_inventory_management/models/item_response.dart';
import 'package:mosaic_inventory_management/models/items_wrapper.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

class ItemsRepo with AuthTokenMixin implements ItemsWebApi {
  final ItemsWebApi _itemsWebApi = serviceLocator<ItemsWebApi>();
  @override
  Future<ItemWrapper> getItemsForCategory(int categoryId,
      {String? authToken}) async {
    return _itemsWebApi.getItemsForCategory(categoryId,
        authToken: await mGetAccessToken());
  }

  @override
  Future<ItemResponse> addItem(
      int itemCategoryId, String name, double rate, double count,
      {String? authToken}) async {
    return _itemsWebApi.addItem(itemCategoryId, name, rate, count,
        authToken: await mGetAccessToken());
  }

  @override
  Future<ItemResponse> deleteItem(int categoryId, int itemId,
      {String? authToken}) async {
    return _itemsWebApi.deleteItem(categoryId, itemId,
        authToken: await mGetAccessToken());
  }

  @override
  Future<ItemResponse> updateItem(int itemCategoryId, int id, Item item,
      {String? authToken}) async {
    return _itemsWebApi.updateItem(itemCategoryId, id, item,
        authToken: await mGetAccessToken());
  }

}
