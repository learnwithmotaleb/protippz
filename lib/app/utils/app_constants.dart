
import '../data/services/app_url.dart';

class AppConstants {

  static String bearerToken = "BearerToken";
  static String resetToken = "BearerToken";
  static String role = "role";
  static String userId = "UserId";
  static String onBoard = "Onboard";
  //============Strip===========================
  // static String stripePublishableKey = "pk_test_51NEO3gEODmIkbEGgyx7lG0t9UooE6pPTiE2fLb0cLVlR9OqK8cki4fkp82R4qHgkzBK1mW3h72RLfRkZdEXI9LDQ00zO32x6Mo";
  static String stripePublishableKey = "pk_live_51QUgZbJPpXEMJbZVHLCMuWjT6119SCW21W9tQiiB9XEgrKcCv1CY4sTQKtThhtcaXUy9Ow9ARdW0YeomWzw3K8RN00d0bVUgII";
  static String isRememberMe = "isRememberMe";
  //=======================Paypal==================
  // static String clientId = "Ac3Goaw8Yq3Q6IwydXM978Pal56HsTNzmQdqhhnqobrHyGR6rDoL_Q0DVI2xuih3oLz3UkVbVVry2mM1";
  static String clientId = "AQ3LCWNUqgYl31KaPJwIuGPI0EHXSfUBx-k-k4uI_C3EzCRK_ga5xd0iNlMnKBITZ_9yGMFdM91WoIwS";
  // static String clientSecret = "EIltQb7_hiXrI13ZvA7DGofNnEuzBYqS4QDXfbxDEpR7-RIpSLNz7Bon2NaOtEv_Ue1pihn3zWFX_CXA";
  static String clientSecret = "EMIKQ1IDTCXrlPPdhN4nNIyaRVAFY8VZ-3eJoAXsZ7E7MaXPXTAks8TLjn7Jo49JPwPWlmYqGuZdRCDh";



  static String successfull = "Request Successfull";
  static String error = "Oops, something went wrong";
  static String profileID = "profileID";
  static String userStatus = "userStatus";
  static String rememberMe = "rememberMe";
  static String profileImage = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqafzhnwwYzuOTjTlaYMeQ7hxQLy_Wq8dnQg&s';



}



enum Status { loading, error, completed, internetError }


