import 'package:intl/intl.dart';
import 'package:valetparking_user/features/auth/models/user_data_model.dart';
import 'package:valetparking_user/features/profile/manager/profile_cubit.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class EditProfileFormWidget extends StatefulWidget {
  const EditProfileFormWidget({super.key, required this.userData});

  final UserData userData;

  @override
  State<EditProfileFormWidget> createState() => _EditProfileFormWidgetState();
}

class _EditProfileFormWidgetState extends State<EditProfileFormWidget> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController fullNameOfCarController = TextEditingController();
  TextEditingController numberOfCarController = TextEditingController();

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode fullNameOfCarFocusNode = FocusNode();
  final FocusNode dateOfBirthFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode numberOfCarFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();

  bool isFullNameFieldFocused = false;
  bool isFullNameOfCarFieldFocused = false;
  bool isDateOfBirthFieldFocused = false;
  bool isEmailFieldFocused = false;
  bool isPhoneFieldFocused = false;
  bool isNumberOfCarFieldFocused = false;
  bool isAddressFieldFocused = false;

  String selectCountry = 'Select Country';
  String selectedGender = 'Male';

  @override
  void initState() {
    // ProfileCubit.get(context).getAllProfileDataFunc();
    super.initState();

    /// Add listener to focus node
    fullNameFocusNode.addListener(() =>
        setState(() => isFullNameFieldFocused = fullNameFocusNode.hasFocus));
    fullNameOfCarFocusNode.addListener(() => setState(
        () => isFullNameOfCarFieldFocused = fullNameOfCarFocusNode.hasFocus));
    numberOfCarFocusNode.addListener(() => setState(
        () => isNumberOfCarFieldFocused = numberOfCarFocusNode.hasFocus));
    dateOfBirthFocusNode.addListener(() => setState(
        () => isDateOfBirthFieldFocused = dateOfBirthFocusNode.hasFocus));
    emailFocusNode.addListener(
        () => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
    phoneFocusNode.addListener(
        () => setState(() => isPhoneFieldFocused = phoneFocusNode.hasFocus));
    addressFocusNode.addListener(() =>
        setState(() => isAddressFieldFocused = addressFocusNode.hasFocus));

    // if(ProfileCubit.get(context).getProfileDataModel.result != null) {
    //   selectCountry = ProfileCubit.get(context).getProfileDataModel.result!.country!.name!;
    //   selectedGender = OConstants.genders.firstWhere((element) => element == ProfileCubit.get(context).getProfileDataModel.result!.gender!);
    //   fullNameController.text = ProfileCubit.get(context).getProfileDataModel.result!.name!;
    //   dateOfBirthController.text = ProfileCubit.get(context).getProfileDataModel.result!.dateOfBirth ?? '';
    //   emailController.text = ProfileCubit.get(context).getProfileDataModel.result!.email!;
    //   phoneController.text = ProfileCubit.get(context).getProfileDataModel.result!.phone!;
    // }
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    fullNameFocusNode.dispose();
    fullNameOfCarFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    dateOfBirthFocusNode.dispose();
    addressFocusNode.dispose();
    fullNameController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    numberOfCarFocusNode.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  List<String> uniqueCountries = [];
  int? idSelectedForCountry;
  final ImagePicker imagePicker = ImagePicker();
  File? selectedImage;

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileDataSuccessState) {
          FloatingSnackBar.show(
            context: context,
            message: 'Profile updated successfully',
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.success,
          );
          context.pushNamedAndRemoveUntil(VRoutesName.navigationMenuRoute,
              arguments: 0,
              predicate: (route) => false);
        }
        if (state is UpdateProfileDataErrorState) {
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
        var profileCubit = ProfileCubit.get(context);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Full Name
            TextFormFieldWidget(
              controller: fullNameController,
              textInputType: TextInputType.name,
              focusNode: fullNameFocusNode,
              // hintText: 'Omar AbdelAziz',
              hintText: widget.userData.username ?? '...',
              // hintText: profileCubit.getProfileDataModel.result == null ? '...' : profileCubit.getProfileDataModel.result!.name!,
              hintColor: isFullNameFieldFocused
                  ? VColors.primaryColor500
                  : VColors.greyScale900,
              prefixIcon: Icon(
                Iconsax.profile_circle_copy,
                color: isFullNameFieldFocused
                    ? VColors.greyScale900
                    : phoneController.text.isNotEmpty
                        ? VColors.greyScale900
                        : VColors.greyScale900,
              ),
              fillColor: isFullNameFieldFocused
                  ? VColors.purpleTransparent.withOpacity(.08)
                  : VColors.greyScale50,
              borderSide: isFullNameFieldFocused
                  ? BorderSide(color: VColors.primaryColor500)
                  : BorderSide.none,
              obscureText: false,
              isEdit: true,
            ),

            /// Make Space
            SizedBox(height: 24.h),

            // /// Phone Number
            // TextFormFieldWidget(
            //   controller: phoneController,
            //   textInputType: TextInputType.phone,
            //   focusNode:  phoneFocusNode,
            //   // hintText: 'Phone Number',
            //   hintText: widget.userData. ?? '...',
            //   // hintText: profileCubit.getProfileDataModel.result == null ? '...' : profileCubit.getProfileDataModel.result!.phone!,
            //   hintColor: isPhoneFieldFocused ? VColors.primaryColor500 : VColors.greyScale500,
            //   prefixIcon: SvgPicture.asset(VImages.phone2Icon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(VColors.greyScale900, BlendMode.srcIn)),
            //   fillColor: isPhoneFieldFocused ? VColors.purpleTransparent.withOpacity(.08) : VColors.greyScale50,
            //   borderSide: isPhoneFieldFocused ? BorderSide(color: VColors.primaryColor500) : BorderSide.none,
            //   obscureText: false,
            //   isEdit: true,
            // ),
            //
            //
            // /// Make Space
            // SizedBox(height: 24.h),

            /// Email
            TextFormFieldWidget(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              hintText: widget.userData.email ?? '...',
              // hintText: '3omar@gmail.com',
              // hintText: profileCubit.getProfileDataModel.result == null ? '...' : profileCubit.getProfileDataModel.result!.email!,
              hintColor: isEmailFieldFocused
                  ? VColors.primaryColor500
                  : VColors.greyScale900,
              prefixIcon: SvgPicture.asset(VImages.email2Icon,
                  fit: BoxFit.scaleDown,
                  colorFilter:
                      ColorFilter.mode(VColors.greyScale900, BlendMode.srcIn)),
              fillColor: isEmailFieldFocused
                  ? VColors.purpleTransparent.withOpacity(.08)
                  : VColors.greyScale50,
              borderSide: isEmailFieldFocused
                  ? BorderSide(color: VColors.primaryColor500)
                  : BorderSide.none,
              obscureText: false,
              isEdit: true,
            ),

            /// Make Space
            SizedBox(height: 24.h),

            // /// Date Of Birth
            // TextFormFieldWidget(
            //   controller: dateOfBirthController,
            //   textInputType: TextInputType.datetime,
            //   focusNode: dateOfBirthFocusNode,
            //   readOnly: true,
            //   // hintText: AppLocalizations.of(context)!.translate('enterDateOfBirth')!,
            //   hintText:  widget.userData. ?? '...',
            //   // hintText: profileCubit.getProfileDataModel.result!.dateOfBirth == null  ?
            //   // AppLocalizations.of(context)!.translate('enterDateOfBirth')! : profileCubit.getProfileDataModel.result!.dateOfBirth!,
            //   hintColor: isDateOfBirthFieldFocused ? VColors.primaryColor500 : VColors.greyScale900,
            //   suffixIcon: InkWellWidget(
            //       onTap: () {
            //         showDatePicker(context: context, firstDate: DateTime(1900), lastDate: DateTime.now()).then((date) {
            //           if(date != null) {
            //             setState(() {
            //               dateOfBirthController.text = VDeviceUtils.formatDateString(date: date, dateFormat: 'yyyy-MM-dd', context: context);
            //             });
            //           }
            //         });
            //       },
            //       child: SvgPicture.asset(VImages.calendarIconNotSelected, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(VColors.greyScale900, BlendMode.srcIn))),
            //   fillColor: isDateOfBirthFieldFocused ? VColors.purpleTransparent.withOpacity(.08) : VColors.greyScale50,
            //   borderSide: isDateOfBirthFieldFocused ? BorderSide(color: VColors.primaryColor500) : BorderSide.none,
            //   obscureText: false,
            //   inputFormatters: [DateInputFormatter()],
            //   isEdit: true,
            // ),
            //
            // /// Make Space
            // SizedBox(height: 24.h),

            /// Full Name Of Car
            TextFormFieldWidget(
              controller: fullNameOfCarController,
              textInputType: TextInputType.name,
              focusNode: fullNameOfCarFocusNode,
              hintText: widget.userData.carName ?? '...',
              // hintText: AppLocalizations.of(context)!.translate('carName')!,
              prefixIcon: Icon(
                Icons.car_crash_outlined,
                color: isFullNameOfCarFieldFocused
                    ? VColors.greyScale900
                    : phoneController.text.isNotEmpty
                        ? VColors.greyScale900
                        : VColors.greyScale900,
              ),
              hintColor: isFullNameOfCarFieldFocused
                  ? VColors.greyScale900
                  : VColors.greyScale900,
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
              hintText: widget.userData.carNumber ?? '...',
              // AppLocalizations.of(context)!.translate('carNumber')!,

              hintColor: isNumberOfCarFieldFocused
                  ? VColors.greyScale900
                  : VColors.greyScale900,
              prefixIcon: Icon(
                Icons.numbers,
                color: isNumberOfCarFieldFocused
                    ? VColors.greyScale900
                    : phoneController.text.isNotEmpty
                        ? VColors.greyScale900
                        : VColors.greyScale900,
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

            // GestureDetector(
            //   onTap: () {
            //     _showImageSourceActionSheet(context);
            //   },
            //   child: SizedBox(
            //     width: double.infinity,
            //     height: VDeviceUtils.getScreenHeight(context) / 4.2,
            //     child: DottedBorder(
            //       color: Colors.black,
            //       strokeWidth: .8,
            //       padding: EdgeInsets.all(12.sp),
            //       radius: Radius.circular(30.r),
            //       borderType: BorderType.RRect,
            //       child: selectedImage == null
            //           ? Center(
            //         child: Column(
            //           children: [
            //             Lottie.asset(
            //               'assets/images/lotties/uploadImage.json',
            //               height: VDeviceUtils.getScreenHeight(context) / 6,
            //             ),
            //             Text(
            //               '● Choice your car image',
            //               style: VStyles.bodyLargeSemiBold.copyWith(
            //                 color: VColors.greyScale500,
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            //           : ClipRRect(
            //         borderRadius: BorderRadius.circular(14.r),
            //         child: Image.file(
            //           selectedImage!,
            //           width: double.infinity,
            //           // height: VDeviceUtils.getScreenHeight(context) / 6,
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            /// Make Space
            SizedBox(height: 24.h),

            Align(
              alignment: Alignment.bottomCenter,
              child: MainButtonWidget(
                centerWidgetInButton: state is UpdateProfileDataLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(AppLocalizations.of(context)!.translate('update')!,
                        style: VStyles.bodyLargeBold(context)
                            .copyWith(color: VColors.whiteColor)),
                onTap: () {
                  profileCubit.updateProfileDataFunction(
                      name: fullNameController.text,
                      email: emailController.text,
                      carName: fullNameOfCarController.text,
                      carNumber: numberOfCarController.text,
                  );
                },
                margin: EdgeInsets.zero,
                buttonColor: fullNameController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        dateOfBirthController.text.isEmpty ||
                        addressController.text.isEmpty
                    ? VColors.disabledButton
                    : VColors.primaryColor500,
                boxShadow: fullNameController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        dateOfBirthController.text.isEmpty ||
                        addressController.text.isEmpty
                    ? []
                    : [AppBoxShadows.buttonShadowOne],
              ),
            ),

            SizedBox(height: 48.h),
          ],
        );
      },
    );
  }
}
