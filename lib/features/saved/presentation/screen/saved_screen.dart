import 'package:valetparking_user/common/widgets/buttons/second_button_widget.dart';
import 'package:valetparking_user/features/home/managers/home_cubit.dart';
import 'package:valetparking_user/features/profile/presentation/widgets/profile/logout_widget.dart';
import 'package:valetparking_user/features/saved/managers/saved_cubit.dart';
import 'package:valetparking_user/features/saved/presentation/widgets/saved_container_widget.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool isSearchFieldFocused = false;

  @override
  void initState() {
    super.initState();

    SavedCubit.get(context).getAllUserSavedGaragesFunction();

    /// Add listener to focus node
    searchFocusNode.addListener(
        () => setState(() => isSearchFieldFocused = searchFocusNode.hasFocus));

    /// Add listener to search controller
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        // Call your function when search text is cleared
        // ProfileCubit.get(context).getAllFaqsIndexCategoryFunc(categoryId: indexGlobal);
      }
    });
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddGarageToSaveSuccessState) {
          SavedCubit.get(context).getAllUserSavedGaragesFunction();
          FloatingSnackBar.show(
            context: context,
            message: state.message!,
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.success,
          );
        } else if (state is RemoveGarageFromSaveSuccessState) {
          SavedCubit.get(context).getAllUserSavedGaragesFunction();
          FloatingSnackBar.show(
            context: context,
            message: state.message!,
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.success,
          );
        } else if (state is AddGarageToSaveErrorState) {
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
        var homeCubit = HomeCubit.get(context);

        return BlocBuilder<SavedCubit, SavedState>(
          // listener: (context, state) {},
          builder: (context, state) {
            var savedCubit = SavedCubit.get(context);
            var savedItem = savedCubit.getAllUserSavedGaragesModel.data;

            return RefreshIndicator(
              onRefresh: () {
                return savedCubit.getAllUserSavedGaragesFunction();
              },
              child: state is GetAllUserSavedGaragesLoadingState ||
                      savedItem == []
                  ? Center(
                      child: LoadingWidget(iconColor: VColors.primaryColor500),
                    )
                  : savedItem == null
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.translate('haveAnAProblemInGetSavedItems')!,
                                style: VStyles.h6Bold(context),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              left: 24.w, right: 24.w, top: 24.h),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  /// Search
                                  TextFormFieldWidget(
                                    controller: searchController,
                                    textInputType: TextInputType.emailAddress,
                                    focusNode: searchFocusNode,
                                    hintText: AppLocalizations.of(context)!
                                        .translate('search')!,
                                    hintColor: isSearchFieldFocused
                                        ? VColors.primaryColor500
                                        : VColors.greyScale500,
                                    prefixIcon: Image.asset(VImages.searchIcon2,
                                        color: isSearchFieldFocused
                                            ? VColors.primaryColor500
                                            : VColors.greyScale400),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        /// Clear Search Bar
                                        if (searchController.text.isNotEmpty)
                                          InkWellWidget(
                                            onTap: () {
                                              searchController.clear();
                                              savedCubit
                                                  .getAllUserSavedGaragesFunction();
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: VColors.primaryColor500,
                                            ),
                                          ),
                                      ],
                                    ),
                                    // suffixIcon:SvgPicture.asset(VImages.filterIcon,width: 20.w,height: 20,),
                                    fillColor: isSearchFieldFocused
                                        ? VColors.purpleTransparent
                                            .withOpacity(.08)
                                        : VColors.greyScale100,
                                    borderSide: isSearchFieldFocused
                                        ? BorderSide(
                                            color: VColors.primaryColor500)
                                        : BorderSide.none,
                                    obscureText: false,
                                    onChanged: (data) {
                                      setState(() {});
                                      if (searchController.length >= 2) {
                                        // faqsCubit.getAllFaqsIndexCategoryFunc(search: data);
                                        savedCubit
                                            .getAllUserSavedGaragesFunction(
                                                searchQuery:
                                                    searchController.text);
                                      }
                                      if (searchController.text.isEmpty) {
                                        // savedCubit.getAllUserSavedGaragesFunction(searchQuery: searchController.text);
                                        // ProfileCubit.get(context).getAllFaqsCategoryFunc();
                                      }
                                    },
                                  ),

                                  /// Make Space
                                  if(savedItem.isEmpty) SizedBox(height: 59.h),


                                  savedItem == null
                                      ? Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.translate('haveAnAProblemInGetSavedItems')!,
                                                style: VStyles.h6Bold(context),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )
                                      : savedItem.isEmpty
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Lottie.asset(
                                                    VImages.orderEmptyLottie),
                                                SizedBox(height: 40.h),
                                                Text( AppLocalizations.of(context)!.translate('emptySavedItems')!,
                                                    style:
                                                        VStyles.bodyXLargeBold(context)),
                                              ],
                                            )
                                          : savedItem == [] ||
                                                  state
                                                      is GetAllUserSavedGaragesLoadingState
                                              ? const CircularProgressIndicator()
                                              : Expanded(
                                                  child: ListView.separated(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        savedItem!.length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return Container(
                                                          height: 20.h);
                                                    },
                                                    itemBuilder:
                                                        (context, index) {
                                                      return SavedContainerWidget(
                                                        placeImage: VImages
                                                            .welBeckNorthImagePlace,
                                                        placeName: savedItem[
                                                                        index]
                                                                    .gragename !=
                                                                null
                                                            ? '${savedItem[index].gragename![0].toUpperCase()}${savedItem[index].gragename!.substring(1).toLowerCase()}'
                                                            : '',
                                                        placeDesc:
                                                            "${savedItem[index].lat!}, ${savedItem[index].lng}",
                                                        onTap: () {
                                                          VDeviceUtils
                                                              .showCustomBottomSheet(
                                                            context: context,
                                                            widget:
                                                                UnSavedWidget(
                                                              placeImage: VConstants
                                                                      .placesImages[
                                                                  index],
                                                              placeName: savedItem[
                                                                              index]
                                                                          .gragename !=
                                                                      null
                                                                  ? '${savedItem[index].gragename![0].toUpperCase()}${savedItem[index].gragename!.substring(1).toLowerCase()}'
                                                                  : '',
                                                              placeDesc:
                                                                  "${savedItem[index].lat!}, ${savedItem[index].lng}",
                                                              onTapYes: () {
                                                                context.pop();
                                                                homeCubit.removeGarageFromSaved(
                                                                    garageId: savedItem[
                                                                            index]
                                                                        .garageId!);
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                ],
                              ),
                              if (state is AddGarageToSaveLoadingState ||
                                  state is RemoveGarageFromSaveLoadingState)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.1),
                                    child: Center(
                                      child: LoadingWidget(
                                          iconColor: VColors.primaryColor500),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
            );
          },
        );
      },
    );
  }
}

class UnSavedWidget extends StatelessWidget {
  const UnSavedWidget({
    super.key,
    required this.placeImage,
    required this.placeName,
    required this.placeDesc,
    required this.onTapYes,
  });

  final String placeImage, placeName, placeDesc;

  final void Function() onTapYes;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: VDeviceUtils.getScreenHeight(context) / 2.8,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
        ),
        child: Column(
          children: [
            /// Make Space
            SizedBox(height: 35.h),

            SizedBox(
                width: double.infinity,
                height: VDeviceUtils.getScreenHeight(context) / 26,
                child: Text(
                    AppLocalizations.of(context)!
                        .translate('removeFromBookmark')!,
                    style: VStyles.h4Bold(context),
                    textAlign: TextAlign.center)),

            /// Make Space
            SizedBox(height: 24.h),

            Container(
              width: double.infinity,
              height: 1.w,
              color: VColors.greyScale200,
            ),

            /// Make Space
            SizedBox(height: 24.h),

            // SizedBox(
            //     width: double.infinity,
            //     height: VDeviceUtils.getScreenHeight(context) / 26,
            //     child: Text(
            //         AppLocalizations.of(context)!
            //             .translate('areYouSureLogout')!,
            //         style: VStyles.h5Bold.copyWith(color: VColors.greyScale800),
            //         textAlign: TextAlign.center)),
            SavedContainerWidget(
              placeImage: placeImage,
              placeName: placeName,
              placeDesc: placeDesc,
              onTap: () {},
            ),

            /// Make Space
            SizedBox(height: 24.h),

            /// Two Buttons (Cancel - Yes)
            SizedBox(
              width: double.infinity,
              height: VDeviceUtils.getScreenHeight(context) / 13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondButtonWidget(
                    bgColor: VColors.primaryColor100,
                    widget: Text(
                      AppLocalizations.of(context)!.translate('cancel')!,
                      style: VStyles.bodyLargeBold(context).copyWith(
                        color: VColors.primaryColor500,
                      ),
                    ),
                    onTap: () => context.pop(),
                  ),
                  SecondButtonWidget(
                    bgColor: VColors.primaryColor500,
                    widget: Text(
                      AppLocalizations.of(context)!.translate('yesRemove')!,
                      style: VStyles.bodyLargeBold(context).copyWith(
                        color: VColors.whiteColor,
                      ),
                    ),
                    onTap: onTapYes,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
