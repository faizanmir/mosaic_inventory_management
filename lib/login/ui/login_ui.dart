import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_inventory_management/base/base_state.dart';
import 'package:mosaic_inventory_management/constants.dart';
import 'package:mosaic_inventory_management/item_category/ui/category_screen.dart';
import 'package:mosaic_inventory_management/login/navigators/login_navigator.dart';
import 'package:mosaic_inventory_management/login/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  var key = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget buildBody() {
    return Form(
      key: key,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          InputField(
              onTextChange: (value) {
                email = value;
              },
              labelText: "E-Mail",
              isPassword: false),
          InputField(
              onTextChange: (value) {
                password = value;
              },
              labelText: "Password",
              isPassword: true),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              if (key.currentState!.validate()) {
                viewModel.doLogin(email, password);
              }
            },
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ),
          Consumer<LoginViewModel>(
            builder: (_, __, ___) => (viewModel.loginCachedUsers != null &&
                    viewModel.loginCachedUsers!.isNotEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Previously logged in users",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                          itemCount: viewModel.loginCachedUsers!.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, idx) => Dismissible(
                                background: Container(
                                  color: Colors.red,
                                ),
                                onDismissed: (info) {
                                  viewModel.deleteCachedUser(
                                      viewModel.loginCachedUsers![idx].email!);
                                },
                                key: UniqueKey(),
                                child: ListTile(
                                  onTap: () {
                                    viewModel.doLogin(
                                        viewModel.loginCachedUsers![idx].email!,
                                        viewModel
                                            .loginCachedUsers![idx].password!);
                                  },
                                  title: Text(
                                      viewModel.loginCachedUsers?[idx].email ??
                                          ""),
                                ),
                              )),
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  @override
  getNavigator() => this;

  @override
  PageIdentifier getPageIdentifier() {
    return PageIdentifier.login;
  }

  @override
  void loadPageData({value}) {
    // viewModel.doLogin("faizanmir009@gmail.com", "12345");
    viewModel.getLoginCachedUsers();
  }

  @override
  Future<bool> provideOnWillPopScopeCallBack() {
    return Future.value(false);
  }

  @override
  void onFailure() {}

  @override
  void onSuccessfulLogin() {
    push(widget: const CategoryListing());
  }

  @override
  void showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Mosaic Interiors Inventory Management"),
    );
  }

  @override
  onFloatingActionButtonPressed() {}
}

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    required this.onTextChange,
    required this.labelText,
    required this.isPassword,
  }) : super(key: key);

  final Function onTextChange;
  final String labelText;
  final bool? isPassword;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isPassword = false;

  @override
  void initState() {
    isPassword = widget.isPassword!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        //key: key,
        obscuringCharacter: "*",
        obscureText: isPassword,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Field is required";
          } else {
            return null;
          }
        },
        onChanged: (value) => widget.onTextChange(value),
        decoration: InputDecoration(
            suffixIcon: (widget.isPassword!)
                ? IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  )
                : null,
            label: Text(widget.labelText),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }
}
