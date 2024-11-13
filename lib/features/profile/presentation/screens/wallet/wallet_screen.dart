import 'package:flutter/material.dart';
import 'package:valetparking_user/features/profile/manager/profile_cubit.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var walletCubit = ProfileCubit.get(context);

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: VColors.whiteColor,
                  title: Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: Text(
                      '${AppLocalizations.of(context)!.translate('wallet')!}',
                      style: VStyles.h4Bold(context),
                    ),
                  ),
                  leading: null,
                  floating: true,
                  pinned: true,
                  flexibleSpace: Container(
                    color: VColors.whiteColor,
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, top: 24.h, bottom: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 24.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [AppBoxShadows.buttonShadowThree],
                        gradient: AppGradients.gradientUltramarineBlue,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.translate('valetCash')!,
                            style: VStyles.bodyLargeBold(context).copyWith(
                              color: VColors.whiteColor,
                            ),
                          ),

                          /// Make Space
                          SizedBox(height: 12.h),

                          state is GetWalletSuccessState &&
                              state.message == 'This user have wallet'
                              ? ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'kwd  ${walletCubit.balance}',
                              style: VStyles.h2Bold(context).copyWith(
                                color: VColors.greyScale50,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: VColors.whiteColor,
                              size: 22.sp,
                            ),
                            onTap: () {},
                          )
                              : state is GetWalletSuccessState &&
                              state.message == 'This user does not have wallet'
                              ? Text(
                            'Don\'t have wallet',
                            style: VStyles.h2Bold(context).copyWith(
                              color: VColors.greyScale50,
                            ),
                          )
                              : state is GetWalletLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : Text(
                            'Unexpected state',
                            style: VStyles.h2Bold(context).copyWith(
                              color: VColors.greyScale50,
                            ),
                          ),



                          /// Make Space
                          SizedBox(height: 20.h),

                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: VColors.whiteColor,
                                size: 22.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                AppLocalizations.of(context)!.translate('valetCash')!,
                                style: VStyles.bodyLargeBold(context).copyWith(
                                  color: VColors.whiteColor,
                                ),
                              ),
                            ],
                          ),

                          /// Make Space
                          SizedBox(height: 24.h),

                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: VColors.gradientPrimary100,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [AppBoxShadows.cardShadowFour],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: VColors.whiteColor,
                                  size: 22.sp,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.translate('addFunds')!,
                                  style: VStyles.bodyLargeBold(context).copyWith(
                                    color: VColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
