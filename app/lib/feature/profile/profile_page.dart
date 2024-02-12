import 'package:app/feature/profile/profile_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final _viewModel = ProfileViewModel();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppStyle.horizontalPadding16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: AppStyle.verticalPadding16,
                    bottom: AppStyle.verticalPadding8,
                  ),
                  child: SizedBox(
                    height: AppStyle.customAppBarHeight,
                    child: Text(
                      AppStrings.profilePageTitle,
                      style: TextStyle(
                        color: AppStyle.textColor,
                        fontSize: AppStyle.fontSize28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1, // TODO: remove magic numbers when fix design
                      ),
                      Center(
                        child: UserAvatarView(
                          initial: _viewModel.username[0],
                          radius: 80,
                          fontSize: 60,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppStyle.verticalPadding16,
                        ),
                        child: Text(
                          _viewModel.username,
                          style: TextStyle(
                            color: AppStyle.textColor,
                            fontSize: AppStyle.fontSize20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppStyle.verticalPadding20,
                          horizontal: AppStyle.horizontalPadding20,
                        ),
                        child: PrimaryButton(
                          text: AppStrings.signOutButton,
                          bgColor: AppStyle.negativeColor.withOpacity(0.15),
                          onPressed: () async {
                            await _viewModel.signOut();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
