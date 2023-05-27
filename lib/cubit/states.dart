
import '../Models/LoginModel.dart';

abstract class LoginStates {}

class ShopLoginInitialState extends LoginStates{}

class ShopLoginonchangeState extends LoginStates{}
class ShopLoginshowpasswordState extends LoginStates{}

class ShopLoginLoadingState extends LoginStates{}

class ShopLoginSuccessState extends LoginStates
{
  final LoginModel loginModel ;
  ShopLoginSuccessState(this.loginModel);

}

class ShopLoginErrorState extends LoginStates{
  final String error ;
  ShopLoginErrorState(this.error);

}

//Register States

class ShopRegisterLoadingState extends LoginStates{}

class ShopRegisterSuccessState extends LoginStates
{
  final LoginModel registerModel ;
  ShopRegisterSuccessState(this.registerModel);

}

class ShopRegisterErrorState extends LoginStates{
  final String error ;
  ShopRegisterErrorState(this.error);

}





















//SQFLITE DataBASE

class createdatabaseState extends LoginStates{}
class insertdatabaseState extends LoginStates{}
class getdatabaseState extends LoginStates{}