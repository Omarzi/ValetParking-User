import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:valetparking_user/app/valet_parking_app.dart';
import 'package:valetparking_user/features/home/managers/home_cubit.dart';
import 'package:valetparking_user/features/home/models/get_all_garages_model.dart';
import 'package:valetparking_user/features/saved/managers/saved_cubit.dart';
import 'package:valetparking_user/features/saved/presentation/screen/saved_screen.dart';
import 'package:valetparking_user/utils/constants/exports.dart';
import 'package:valetparking_user/utils/device/device_utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _controller;
  LatLng _initialPosition = const LatLng(0.0, 0.0);
  bool _loading = true;
  StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndStartLocationUpdates();
    SavedCubit.get(context).getAllUserSavedGaragesFunction();
  }

  Future<void> _checkPermissionsAndStartLocationUpdates() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return;
    }

    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission denied, show error
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return;
    }

    // If permissions are granted, start listening to location updates
    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _initialPosition = currentLatLng;
        _loading = false;
      });

      // Move the camera to the current location
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLatLng,
            zoom: 17,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    // Cancel the location subscription when the widget is disposed
    positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddGarageToSaveSuccessState) {
          HomeCubit.get(context).getAllGaragesFunction();
          FloatingSnackBar.show(
            context: context,
            message: state.message!,
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.success,
          );
        }
        else if (state is RemoveGarageFromSaveSuccessState) {
          HomeCubit.get(context).getAllGaragesFunction();
          FloatingSnackBar.show(
            context: context,
            message: state.message!,
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.success,
          );
        }
        else if (state is AddGarageToSaveErrorState) {
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
        var garagesList = homeCubit.getAllGaragesModel.garageDetails;

        return garagesList == null
            ? Center(
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
            : _loading || garagesList == [] || garagesList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.terrain,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 17,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller = controller;
                        },
                      ),
                      Positioned(
                        bottom: 20.h,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: EdgeInsets.only(left: 20.w),
                          height: VDeviceUtils.getScreenHeight(context) / 3.5,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: garagesList.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 24.w);
                            },
                            itemBuilder: (context, index) {
                              return GarageWidget(
                                garageImage: VImages.placeBanner,
                                garageTitle: garagesList[index].gragename !=
                                        null
                                    ? '${garagesList[index].gragename![0].toUpperCase()}${garagesList[index].gragename!.substring(1).toLowerCase()}'
                                    : '',
                                garageDescription: garagesList[index]
                                    .grageDescription
                                    .toString(),
                                // garageLocation: (garagesList[index].lat! + garagesList[index].lng!).toString(),
                                isSaved: garagesList[index].isSaved!,
                                onTap: () {
                                  GarageDetails garageItem = garagesList[index];

                                  context.pushNamed(
                                    VRoutesName.placeDetailsRoute,
                                    arguments: garageItem,
                                  );
                                  // context.pushNamed(VRoutesName.placeDetailsRoute);
                                },
                                onSaved: () {
                                  logSuccess('Save');
                                  garagesList[index].isSaved!
                                      ? VDeviceUtils.showCustomBottomSheet(
                                          context: context,
                                          widget: UnSavedWidget(
                                            placeImage:
                                                VConstants.placesImages[index],
                                            placeName: garagesList[index]
                                                        .gragename !=
                                                    null
                                                ? '${garagesList[index].gragename![0].toUpperCase()}${garagesList[index].gragename!.substring(1).toLowerCase()}'
                                                : '',
                                            placeDesc:
                                                "${garagesList[index].lat!}, ${garagesList[index].lng}",
                                            onTapYes: () {
                                              context.pop();
                                              homeCubit.removeGarageFromSaved(
                                                  garageId: garagesList[index]
                                                      .garageId!);
                                            },
                                          ),
                                        )
                                      : homeCubit.addGarageToSaved(
                                          garageId:
                                              garagesList[index].garageId!);
                                },
                              );
                            },
                          ),
                        ),
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
                  );
      },
    );
  }
}

class GarageWidget extends StatelessWidget {
  const GarageWidget({
    super.key,
    required this.onTap,
    required this.onSaved,
    required this.garageImage,
    required this.garageTitle,
    required this.garageDescription,
    required this.isSaved,
  });

  final void Function() onTap, onSaved;
  final String garageImage, garageTitle, garageDescription;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: onTap,
      child: Container(
        width: VDeviceUtils.getScreenWidth(context) / 1.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [AppBoxShadows.cardShadowTwo],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5.h),
              child: Image.asset(garageImage),
            ),

            /// Make Size
            SizedBox(height: 20.h),

            Container(
              width: VDeviceUtils.getScreenWidth(context) / 1.5,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: VDeviceUtils.getScreenWidth(context) / 2.2,
                        // color: Colors.red,
                        child: Text(
                          garageTitle,
                          style: VStyles.bodyLargeBold(context).copyWith(
                            fontSize: 18.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: onSaved,
                        child: SvgPicture.asset(
                          isSaved
                              ? VImages.savedIconSelected
                              : VImages.savedIconNotSelected,
                        ),
                      ),
                    ],
                  ),

                  /// Make Size
                  SizedBox(height: 8.h),

                  Container(
                    child: Text(
                      garageDescription,
                      style: VStyles.bodyLargeMedium(context).copyWith(
                        fontSize: 15.sp,
                        color: VColors.greyScale700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
