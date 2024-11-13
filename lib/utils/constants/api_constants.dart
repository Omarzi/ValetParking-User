class ApiConstants {
  // static const baseUrl = 'http://192.168.146.10:8080/';
  // static const baseUrl = 'http://192.168.28.10:8080/';
  // static const baseUrl = 'http://172.29.64.1:8080/';
  // static const baseUrl = 'http://192.168.10.10:8080/';
  static const baseUrl = 'https://valet-parking-back-end-production.up.railway.app/';
  // static const baseUrl = 'https://valter-parking-production.up.railway.app/';
  // static const baseUrl = 'http://192.168.1.11:8080/';

  static const loginUrl = 'auth/login';
  static const verifyResetCodeOfLoginUrl = 'auth/verifyResetCodeOfLogin';
  static const signupUrl = 'auth/signUp';
  static const forgetPasswordUrl = 'auth/forgotPassword';
  static const verifyResetCodeUrl = 'auth/verifyResetCode';
  static const createNewPasswordUrl = 'auth/resetPassword';
  static const profileDataUrl = 'user/getProfile/';
  static const getAllGaragesUrl = 'user/getAllGarages';
  static const makeOrderUrl = 'user/makeOrder/';
  static const getAllOrdersUrl = 'user/getAllOrdersForSpecificUser';
  static const getSpecificOrderUrl = 'user/getOrder/';
  static const addGarageToSavedUrl = 'user/addGarageToSaved';
  static const removeGarageFromSavedUrl = 'user/removeGarageFromSaved';
  static const getUserSavedGarageUrl = 'user/getUserSavedGarage';
  static const changePasswordUrl = 'user/updatePassword/';
  static const walletUrl = 'user/getUserWallet/';
  static const updateProfileDataUrl = 'user/updateProfile/';


  static const verifyOTPUrl = 'api/user/login';
  static const fillYourAccountUrl = 'api/user/register';
  static const countryUrl = 'api/country';
  static const cityUrl = 'api/city';
  static const servicesUrl = 'api/service';
  static const allOffersUrl = 'api/user/offer';
  static const getAllAddressesUrl = 'api/user/location';
  static const subServiceUrl = 'api/sub_service';
  static const orderUrl = 'api/user/order';
  static const faqCategoryUrl = 'api/faq-category';
  static const faqIndexUrl = 'api/faq';
  static const getProfileDataUrl = 'api/user/profile';
  static const customerServicesUrl = 'api/ticket';
}