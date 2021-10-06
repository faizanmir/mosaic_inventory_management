import 'package:flutter/material.dart';
import 'package:mosaic_inventory_management/constants.dart';
import 'package:mosaic_inventory_management/item_category/ui/category_screen.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';
import 'package:provider/provider.dart';

import '../../base/base_view_model.dart';

abstract class BaseState<W extends StatefulWidget, VM extends BaseViewModel>
    extends State<W> {
  VM viewModel = serviceLocator<VM>();

  Widget buildBody();

  dynamic getNavigator();

  AppBar buildAppBar();

  PageIdentifier getPageIdentifier();


  onFloatingActionButtonPressed();

  @override
  void initState() {
    loadPageData();
    if (getNavigator() != null) {
      viewModel.setNavigator(getNavigator());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: provideOnWillPopScopeCallBack,
        child: Scaffold(
          floatingActionButton: (getPageIdentifier() != PageIdentifier.login)
              ? FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: onFloatingActionButtonPressed,
                )
              : null,
          appBar: buildAppBar(),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ChangeNotifierProvider.value(
              value: viewModel,
              child: buildBody(),
            ),
          ),
        ),
      );

  // void pop(BuildContext context, dynamic result) =>
  //    // appRouter.closePage(context, result);
  void loadPageData({dynamic value});

  void push({required Widget widget}) {
    print("pushing");
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
  }

  void pop({dynamic result}) {
    Navigator.of(context).pop();
  }

  Future<bool> provideOnWillPopScopeCallBack();

  Widget showProgressBar() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
