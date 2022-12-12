import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/config/routes/app_routes.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/core/utils/constants.dart';
import 'package:store_task/features/authantication/presentation/cubit/authantication_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/default_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 50.h),
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/login_image.png',
                    width: 130.w,
                    height: 100.h,
                  ),
                  SizedBox(height: 35.h),
                  Text(
                    AppStrings.loginTitle,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    AppStrings.loginSubTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppStrings.userName,
                          style: Theme.of(context).textTheme.headline5),
                      CustomFormField(
                        hint: AppStrings.userNameHint,
                        controller: _userNameController,
                        textInputType: TextInputType.emailAddress,
                        onSaved: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.fieldRequierd;
                          }
                          return null;
                        },
                      ),
                      Text(AppStrings.password,
                          style: Theme.of(context).textTheme.headline5),
                      BlocBuilder<AuthanticationCubit, AuthanticationState>(
                        builder: (context, state) {
                          return CustomFormField(
                            hint: AppStrings.passwordHint,
                            controller: _passwordController,
                            textInputType: TextInputType.visiblePassword,
                            suffix: IconButton(
                              icon: Icon(
                                context.watch<AuthanticationCubit>().visibility
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye,
                                color: AppColors.textGray,
                              ),
                              onPressed: () {
                                context
                                    .read<AuthanticationCubit>()
                                    .changePasswordVisibility();
                              },
                            ),
                            isPassword:
                                context.read<AuthanticationCubit>().visibility
                                    ? false
                                    : true,
                            onSaved: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.fieldRequierd;
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  BlocConsumer<AuthanticationCubit, AuthanticationState>(
                    listener: (context, state) {
                      if (state is AuthanticationErrorState) {
                        showError(context, state.message);
                      }
                      if (state is LoginSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(AppStrings.loginSuccess),
                          ),
                        );
                        Constants.navigateNamedFinish(
                            context: context, route: Routes.initialRoute);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthanticationLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return DefaultButton(
                          text: AppStrings.loginButton,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthanticationCubit>().login(
                                    userName: _userNameController.text,
                                    password: _passwordController.text,
                                  );
                            }
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppStrings.dontHaveAccount,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.textGray)),
                      SizedBox(
                        width: 10.w,
                      ),
                      TextButton(
                        onPressed: () {
                          Constants.navigateNamedTo(
                              context: context, route: Routes.registerRoute);
                        },
                        child: Text(AppStrings.registerButton,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationThickness: 20,
                                decorationStyle: TextDecorationStyle.solid,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
