import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:valetparking_user/features/auth/managers/auth_cubit.dart';
import 'package:valetparking_user/utils/constants/api_constants.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class FillYourProfileFormWidget extends StatefulWidget {
  const FillYourProfileFormWidget({super.key});

  // final String phoneNumber;

  @override
  State<FillYourProfileFormWidget> createState() =>
      _FillYourProfileFormWidgetState();
}

class _FillYourProfileFormWidgetState extends State<FillYourProfileFormWidget> {
  XFile? _selectedImageToPerson;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController fullNameOfCarController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numberOfCarController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController invitationController = TextEditingController();
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode fullNameOfCarFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode numberOfCarFocusNode = FocusNode();
  final FocusNode dateOfBirthFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode invitationFocusNode = FocusNode();
  bool isFullNameFieldFocused = false;
  bool isFullNameOfCarFieldFocused = false;
  bool isEmailFieldFocused = false;
  bool isPasswordFieldFocused = false;
  bool isPhoneFieldFocused = false;
  bool isNumberOfCarFieldFocused = false;
  bool isDateOfBirthFieldFocused = false;
  bool isAddressFieldFocused = false;
  bool isCountryFieldFocused = false;
  bool isInvitationFieldFocused = false;

  bool isPass = true;

  final ImagePicker imagePicker = ImagePicker();
  File? selectedImage;
  File? selectedProfileImage;

  @override
  void initState() {
    super.initState();

    /// Add listener to focus node
    fullNameFocusNode.addListener(() =>
        setState(() => isFullNameFieldFocused = fullNameFocusNode.hasFocus));
    fullNameOfCarFocusNode.addListener(() => setState(
        () => isFullNameOfCarFieldFocused = fullNameOfCarFocusNode.hasFocus));
    emailFocusNode.addListener(
        () => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
    passwordFocusNode.addListener(() =>
        setState(() => isPasswordFieldFocused = passwordFocusNode.hasFocus));
    phoneFocusNode.addListener(
        () => setState(() => isPhoneFieldFocused = phoneFocusNode.hasFocus));
    numberOfCarFocusNode.addListener(() => setState(
        () => isNumberOfCarFieldFocused = numberOfCarFocusNode.hasFocus));
    dateOfBirthFocusNode.addListener(() => setState(
        () => isDateOfBirthFieldFocused = dateOfBirthFocusNode.hasFocus));
    addressFocusNode.addListener(() =>
        setState(() => isAddressFieldFocused = addressFocusNode.hasFocus));
    countryFocusNode.addListener(() =>
        setState(() => isCountryFieldFocused = countryFocusNode.hasFocus));
    invitationFocusNode.addListener(() => setState(
        () => isInvitationFieldFocused = invitationFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    fullNameFocusNode.dispose();
    fullNameOfCarFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    dateOfBirthFocusNode.dispose();
    addressFocusNode.dispose();
    countryFocusNode.dispose();
    fullNameController.dispose();
    fullNameOfCarController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dateOfBirthController.dispose();
    addressController.dispose();
    countryController.dispose();
    phoneFocusNode.dispose();
    numberOfCarFocusNode.dispose();
    phoneController.dispose();
    numberOfCarController.dispose();
    invitationController.dispose();
    super.dispose();
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text('Open Gallery', style: VStyles.bodyXLargeMedium(context)),
                onTap: () {
                  _pickImageFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text('Open Camera', style: VStyles.bodyXLargeMedium(context)),
                onTap: () {
                  _pickImageFromCamera();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void validateAndNavigate(BuildContext context) {
    String fullName = fullNameController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String carName = fullNameOfCarController.text;
    String carNumber = numberOfCarController.text;
    File? carImage = selectedImage; // Assuming carImageFile is a File object

    /// Validate Full Name
    if (fullName.isEmpty) {
      FloatingSnackBar.show(
        context: context,
        message: 'Full Name cannot be empty',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    }

    /// Validate Phone Number
    else if (phone.isEmpty || phoneController.text.length != 8) {
      FloatingSnackBar.show(
        context: context,
        message: phoneController.text.length != 8
            ? 'Enter 8 digits'
            : 'Enter a valid phone number',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    }

    /// Validate Email
    else if (email.isEmpty) {
      FloatingSnackBar.show(
        context: context,
        message: 'You must fill out this email field',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$")
        .hasMatch(email)) {
      FloatingSnackBar.show(
        context: context,
        message: 'You must fill this field in valid ex: example@gmail.com',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    }

    /// Validate Password
    else if (password.isEmpty) {
      FloatingSnackBar.show(
        context: context,
        message: 'Password cannot be empty',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    }

    /// Validate Car Name
    else if (carName.isEmpty) {
      FloatingSnackBar.show(
        context: context,
        message: 'Car Name cannot be empty',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    }

    /// Validate Car Number
    else if (carNumber.isEmpty) {
      FloatingSnackBar.show(
        context: context,
        message: 'Car Number cannot be empty',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    }

    /// Validate Car Image
    else if (carImage == null) {
      FloatingSnackBar.show(
        context: context,
        message: AppLocalizations.of(context)!.translate('pleaseUploadACarImage')!,
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    }

    /// Validate Profile Image
    else if (_selectedImageToPerson == null) {
      FloatingSnackBar.show(
        context: context,
        message: AppLocalizations.of(context)!.translate('pleaseUploadAProfileImage')!,
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    }

    /// If all validations pass, navigate to the OTP route
    else {
      context.pushNamed(VRoutesName.loginAccountRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          context.pushNamed(VRoutesName.otpRoute, arguments: {
            'emailAddress': emailController.text,
            'screenName': 'signupScreen',
          });

          FloatingSnackBar.show(
            context: context,
            message: AppLocalizations.of(context)!.translate('signupSuccessfully')!,
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.success,
          );
        } else if (state is SignupErrorState) {
          FloatingSnackBar.show(
            context: context,
            message: state.message!,
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.error,
          );
        }
      },
      builder: (context, state) {
        var signupCubit = AuthCubit.get(context);

        return SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      /// Image Profile
                      CircleAvatar(
                        radius: 60.r,
                        backgroundImage: _selectedImageToPerson != null
                            ? null
                            : const AssetImage(VImages.avatarIcon),
                        backgroundColor: Colors.transparent,
                        // child: SvgPicture.asset(VImages.avatarIcon),
                        child: _selectedImageToPerson != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60.r),
                                child: Image.file(
                                  File(_selectedImageToPerson!.path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            : null,
                      ),

                      /// Edite Icon
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWellWidget(
                          onTap: _openImageGalleryToPerson,
                          child: SvgPicture.asset(VImages.editIcon),
                        ),
                      ),
                    ],
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  /// Full Name
                  TextFormFieldWidget(
                    controller: fullNameController,
                    textInputType: TextInputType.name,
                    focusNode: fullNameFocusNode,
                    prefixIcon: Icon(
                      Iconsax.profile_circle_copy,
                      color: isFullNameFieldFocused
                          ? VColors.primaryColor500
                          : phoneController.text.isNotEmpty
                              ? VColors.greyScale900
                              : VColors.greyScale500,
                    ),
                    hintText:
                        AppLocalizations.of(context)!.translate('fullName')!,
                    hintColor: isFullNameFieldFocused
                        ? VColors.primaryColor500
                        : VColors.greyScale500,
                    fillColor: isFullNameFieldFocused
                        ? VColors.purpleTransparent.withOpacity(.08)
                        : VColors.greyScale50,
                    borderSide: isFullNameFieldFocused
                        ? BorderSide(color: VColors.primaryColor500)
                        : BorderSide.none,
                    obscureText: false,
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  /// Phone Number
                  TextFormFieldWidget(
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    focusNode: phoneFocusNode,
                    hintText:
                        AppLocalizations.of(context)!.translate('phoneNumber')!,
                    hintColor: isPhoneFieldFocused
                        ? VColors.primaryColor500
                        : VColors.greyScale500,
                    prefixIcon: SvgPicture.asset(VImages.phoneIcon,
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                            isPhoneFieldFocused
                                ? VColors.primaryColor500
                                : phoneController.text.isNotEmpty
                                    ? VColors.greyScale900
                                    : VColors.greyScale500,
                            BlendMode.srcIn)),
                    fillColor: isPhoneFieldFocused
                        ? VColors.purpleTransparent.withOpacity(.08)
                        : VColors.greyScale50,
                    borderSide: isPhoneFieldFocused
                        ? BorderSide(color: VColors.primaryColor500)
                        : BorderSide.none,
                    obscureText: false,
                    validator: (value) =>
                        VFormatter.formatPhoneNumber(value, '+2'),
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  /// Email
                  TextFormFieldWidget(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    hintText: AppLocalizations.of(context)!.translate('email')!,
                    hintColor: isEmailFieldFocused
                        ? VColors.primaryColor500
                        : VColors.greyScale500,
                    prefixIcon: SvgPicture.asset(VImages.email2Icon,
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                            isEmailFieldFocused
                                ? VColors.primaryColor500
                                : emailController.text.isNotEmpty
                                    ? VColors.greyScale900
                                    : VColors.greyScale500,
                            BlendMode.srcIn)),
                    fillColor: isEmailFieldFocused
                        ? VColors.purpleTransparent.withOpacity(.08)
                        : VColors.greyScale50,
                    borderSide: isEmailFieldFocused
                        ? BorderSide(color: VColors.primaryColor500)
                        : BorderSide.none,
                    obscureText: false,
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  /// Password
                  TextFormFieldWidget(
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    focusNode: passwordFocusNode,
                    hintText:
                        AppLocalizations.of(context)!.translate('password')!,
                    hintColor: isPasswordFieldFocused
                        ? VColors.primaryColor500
                        : VColors.greyScale500,
                    prefixIcon: SvgPicture.asset(VImages.passwordIcon,
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                            isPasswordFieldFocused
                                ? VColors.primaryColor500
                                : passwordController.text.isNotEmpty
                                    ? VColors.greyScale900
                                    : VColors.greyScale500,
                            BlendMode.srcIn)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() => isPass = !isPass);
                      },
                      child: SvgPicture.asset(
                          isPass ? VImages.eyeHideIcon : VImages.eyeShowIcon,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                              isPasswordFieldFocused
                                  ? VColors.primaryColor500
                                  : passwordController.text.isNotEmpty
                                      ? VColors.greyScale900
                                      : VColors.greyScale500,
                              BlendMode.srcIn)),
                    ),
                    fillColor: isPasswordFieldFocused
                        ? VColors.purpleTransparent.withOpacity(.08)
                        : VColors.greyScale50,
                    borderSide: isPasswordFieldFocused
                        ? BorderSide(color: VColors.primaryColor500)
                        : BorderSide.none,
                    obscureText: isPass,
                    obscureCharacter: '●',
                    maxLines: 1,
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  /// Date Of Birth
                  TextFormFieldWidget(
                    controller: dateOfBirthController,
                    textInputType: TextInputType.datetime,
                    focusNode: dateOfBirthFocusNode,
                    readOnly: true,
                    hintText:
                        AppLocalizations.of(context)!.translate('dateOfBirth')!,
                    hintColor: isDateOfBirthFieldFocused
                        ? VColors.primaryColor500
                        : VColors.greyScale500,
                    suffixIcon: InkWellWidget(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now())
                              .then((date) {
                            if (date != null) {
                              setState(() {
                                dateOfBirthController.text =
                                    VDeviceUtils.formatDateString(
                                        date: date,
                                        dateFormat: 'yyyy-MM-dd',
                                        context: context);
                              });
                            }
                          });
                        },
                        child: SvgPicture.asset(VImages.calendarIconNotSelected,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                                isDateOfBirthFieldFocused
                                    ? VColors.primaryColor500
                                    : VColors.greyScale900,
                                BlendMode.srcIn))),
                    fillColor: isDateOfBirthFieldFocused
                        ? VColors.purpleTransparent.withOpacity(.08)
                        : VColors.greyScale50,
                    borderSide: isDateOfBirthFieldFocused
                        ? BorderSide(color: VColors.primaryColor500)
                        : BorderSide.none,
                    obscureText: false,
                    inputFormatters: [DateInputFormatter()],
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  /// Full Name Of Car
                  TextFormFieldWidget(
                    controller: fullNameOfCarController,
                    textInputType: TextInputType.name,
                    focusNode: fullNameOfCarFocusNode,
                    hintText:
                        AppLocalizations.of(context)!.translate('carName')!,
                    prefixIcon: Icon(
                      Icons.car_crash_outlined,
                      color: isFullNameOfCarFieldFocused
                          ? VColors.primaryColor500
                          : phoneController.text.isNotEmpty
                              ? VColors.greyScale900
                              : VColors.greyScale500,
                    ),
                    hintColor: isFullNameOfCarFieldFocused
                        ? VColors.primaryColor500
                        : VColors.greyScale500,
                    fillColor: isFullNameOfCarFieldFocused
                        ? VColors.purpleTransparent.withOpacity(.08)
                        : VColors.greyScale50,
                    borderSide: isFullNameOfCarFieldFocused
                        ? BorderSide(color: VColors.primaryColor500)
                        : BorderSide.none,
                    obscureText: false,
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  /// Number Of Car
                  TextFormFieldWidget(
                    controller: numberOfCarController,
                    textInputType: TextInputType.phone,
                    focusNode: numberOfCarFocusNode,
                    hintText:
                        AppLocalizations.of(context)!.translate('carNumber')!,
                    hintColor: isNumberOfCarFieldFocused
                        ? VColors.primaryColor500
                        : VColors.greyScale500,
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: isNumberOfCarFieldFocused
                          ? VColors.primaryColor500
                          : phoneController.text.isNotEmpty
                              ? VColors.greyScale900
                              : VColors.greyScale500,
                    ),
                    fillColor: isNumberOfCarFieldFocused
                        ? VColors.purpleTransparent.withOpacity(.08)
                        : VColors.greyScale50,
                    borderSide: isNumberOfCarFieldFocused
                        ? BorderSide(color: VColors.primaryColor500)
                        : BorderSide.none,
                    obscureText: false,
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  GestureDetector(
                    onTap: () {
                      _showImageSourceActionSheet(context);
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: VDeviceUtils.getScreenHeight(context) / 4.2,
                      child: DottedBorder(
                        color: Colors.black,
                        strokeWidth: .8,
                        padding: EdgeInsets.all(12.sp),
                        radius: Radius.circular(30.r),
                        borderType: BorderType.RRect,
                        child: selectedImage == null
                            ? Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      'assets/images/lotties/uploadImage.json',
                                      height: VDeviceUtils.getScreenHeight(
                                              context) /
                                          6,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.translate('chooseYourCarImage')!,
                                      style: VStyles.bodyLargeSemiBold(context).copyWith(
                                        color: VColors.greyScale500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(14.r),
                                child: Image.file(
                                  selectedImage!,
                                  width: double.infinity,
                                  // height: VDeviceUtils.getScreenHeight(context) / 6,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  /// Sign in Button
                  MainButtonWidget(
                    centerWidgetInButton: state is SignupLoadingState
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            AppLocalizations.of(context)!
                                .translate('continue')!,
                            style: VStyles.bodyLargeBold(context)
                                .copyWith(color: VColors.whiteColor)),
                    onTap: () async {
                      String fullName = fullNameController.text;
                      String phone = phoneController.text;
                      String email = emailController.text;
                      String password = passwordController.text;
                      String carName = fullNameOfCarController.text;
                      String carNumber = numberOfCarController.text;
                      File? carImage =
                          selectedImage; // Assuming carImageFile is a File object

                      /// Validate Full Name
                      if (fullName.isEmpty) {
                        FloatingSnackBar.show(
                          context: context,
                          message: AppLocalizations.of(context)!.translate('fullNamecannotbeempty')!,
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      }

                      /// Validate Phone Number
                      else if (phone.isEmpty ||
                          // phoneController.text.length != 8 ||
                          phoneController.text.length != 11) {
                        FloatingSnackBar.show(
                          context: context,
                          message: AppLocalizations.of(context)!.translate('enterAvALIDnUMBER')!,
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      }

                      /// Validate Email
                      else if (email.isEmpty) {
                        FloatingSnackBar.show(
                          context: context,
                          message: AppLocalizations.of(context)!.translate('youMustFillOutThisEmailField')!,
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$")
                          .hasMatch(email)) {
                        FloatingSnackBar.show(
                          context: context,
                          message: AppLocalizations.of(context)!.translate('youMustFillThisFieldInValid')!,
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      }

                      /// Validate Password
                      else if (password.isEmpty) {
                        FloatingSnackBar.show(
                          context: context,
                          message: AppLocalizations.of(context)!.translate('passwordCannotBeEmpty')!,
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      }

                      /// Validate Car Name
                      else if (carName.isEmpty) {
                        FloatingSnackBar.show(
                          context: context,
                          message: AppLocalizations.of(context)!.translate('carNameCannotBeEmpty')!,
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      }

                      /// Validate Car Image
                      else if (carImage == null) {
                        FloatingSnackBar.show(
                          context: context,
                          message: AppLocalizations.of(context)!.translate('pleaseUploadACarImage')!,
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      }

                      /// Validate Profile Image
                      else if (_selectedImageToPerson == null) {
                        FloatingSnackBar.show(
                          context: context,
                          message: AppLocalizations.of(context)!.translate('pleaseUploadAProfileImage')!,
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      }

                      /// If all validations pass, navigate to the OTP route
                      else {
                        // signupCubit.signupFunction(
                        //   username: fullName,
                        //   email: email,
                        //   password: password,
                        //   phone: phone,
                        //   profileImage: _selectedImageToPerson!.path,
                        //   // profileImage: File(_selectedImageToPerson!.path),
                        //   carName: carName,
                        //   carNumber: carNumber,
                        //   carImage: carImage.path,
                        //   // carImage: selectedImage!.path,
                        // );
                        await signupCubit.signupFunction(
                          username: fullName,
                          email: email,
                          password: password,
                          phone: phone,
                          profileImage: _selectedImageToPerson!.path,
                          carName: carName,
                          carNumber: carNumber,
                          carImage: selectedImage!.path,
                        );

                        // logSuccess(_selectedImageToPerson!.path.toString());
                        // logSuccess(selectedImage!.path.toString());
                        // logSuccess(fullName);
                        // logSuccess(email);
                        // logSuccess(password);
                        // logSuccess(phone);
                        // logSuccess(carName);
                        // logSuccess(carNumber);
                        // context.pushNamed(VRoutesName.loginAccountRoute);
                      }
                      // validateAndNavigate(context);
                    },
                    margin: EdgeInsets.zero,
                    buttonColor: emailController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            fullNameController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            dateOfBirthController.text.isEmpty
                        ? VColors.disabledButton
                        : VColors.primaryColor500,
                    boxShadow: emailController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            fullNameController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            dateOfBirthController.text.isEmpty
                        ? []
                        : [AppBoxShadows.buttonShadowOne],
                  ),

                  SizedBox(height: 48.h),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openImageGalleryToPerson() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImageToPerson = image;
      });
    } else {
      print('No image selected');
    }
  }
}
