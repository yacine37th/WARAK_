// import 'package:get/get.dart';

// import '../backend/crud.dart';
// import '../backend/link_api.dart';
// import '../main.dart';
// import '../model/user_model.dart';

// class AuthService extends GetxService {
//   bool isLoggedIn() {
//     print(MainFunctions.sharredPrefs?.getString("authToken"));
//     return MainFunctions.sharredPrefs?.getString("authToken") != null;
//   }

//   Future<AuthService> toKeepSignIn() async {
//     if (isLoggedIn()) {
//       print("verify loggedin /*/*/*/*/");

//       var response = await Crud.postRequest(loginLink, {
//         "email": MainFunctions.sharredPrefs?.getString("email"),
//         "password": MainFunctions.sharredPrefs?.getString("password")
//       });

//       if (response != null &&
//           response["success"] == true &&
//           response["message"] == "Login succesfull") {
//         userModel = UserModel.fromJson(response);
//       }

//       print(response);
//     }

//     return this;
//   }
// }
