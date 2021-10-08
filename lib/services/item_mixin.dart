import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mosaic_inventory_management/models/item_response.dart';

import '../constants.dart';

mixin ItemActionsMixin {

  Future<ItemResponse> mAddItem(int itemCategoryId, String name, double? rate,
      double? count, String? authToken) async {
    final request = http.MultipartRequest(
        "POST", Uri.parse(baseUrl + "/item/$itemCategoryId/add-item"));
    request.headers.addAll(
        {"Content-Type": "application/json", "Authorization": "$authToken"});
    request.fields.addAll({"name": name, "rate": "$rate", "count": "$count"});
    http.Response response =
        await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      return ItemResponse.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("item add encountered a problem ${response.body}");
    }
  }


  Future<ItemResponse> mAddFilesToExistingItems(int itemId, XFile file,
      {String? authToken}) async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("$baseUrl/item/$itemId/add-files-to-item"));
    request.files.add(await http.MultipartFile.fromPath("file",file.path));
    print("Adding header");
    request.headers.addAll(
        {"Content-Type": "application/json", "Authorization": "$authToken"});
    print("creating response");
    var streamdResponse  = await request.send();
    var response  = await http.Response.fromStream(streamdResponse);
    return ItemResponse.fromMap(jsonDecode(response.body));
  }

  Future<ItemResponse> mDeleteItem(int categoryId, int itemId,
      {String? authToken}) async {
    final response = await http.delete(
        Uri.parse(baseUrl + "/item/$categoryId/delete-item/$itemId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$authToken"
        });
    if (response.statusCode == 200) {
      return ItemResponse.fromMap(jsonDecode(response.body));
      ;
    } else {
      throw Exception("item del encountered a problem ${response.body}");
    }
  }

  Future<ItemResponse> mUpdateItem(int itemCategoryId, int id, item,
      {String? authToken}) async {
    final response = await http.put(
        Uri.parse(baseUrl + "/item/$itemCategoryId/update-item/$id"),
        body: jsonEncode(item.toMap()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$authToken"
        });
    if (response.statusCode == 200) {
      return ItemResponse.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("item update encountered a problem ${response.body}");
    }
  }

  Future<ItemResponse> mDeleteFileFromItem(int itemId,int fileId,{String? authToken}) async{
    final response = await http.delete(
        Uri.parse(baseUrl + "/item/$itemId/delete-file-from-item/$fileId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$authToken"
        });
    if (response.statusCode == 200) {
      return ItemResponse.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("item delete encountered a problem ${response.body}");
    }
  }

}
