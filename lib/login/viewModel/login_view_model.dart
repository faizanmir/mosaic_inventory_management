import 'package:mosaic_inventory_management/base/base_view_model.dart';
import 'package:mosaic_inventory_management/login/navigators/login_navigator.dart';
import 'package:mosaic_inventory_management/login/repos/login_repo.dart';
import 'package:mosaic_inventory_management/models/login_model.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  LoginRepository loginRepository  =  serviceLocator<LoginRepository>();
  LoginModel? loginModel;


  void doLogin(String email,String password) async{
    try{
     loginModel =  await loginRepository.doLogin(email, password) as LoginModel;
     loginRepository.mSetAccessToken(loginModel!.jwtToken);
     getNavigator().showMessage(loginModel!.message);
     getNavigator().onSuccessfulLogin();
    }catch(e){
      getNavigator().showMessage("Failure: Login couldn't be performed");
      getNavigator().onFailure();
    }
  }

}