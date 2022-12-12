import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/core/utils/constants.dart';
import 'package:store_task/features/authantication/presentation/cubit/authantication_cubit.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/default_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                    AppStrings.registerTitle,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    AppStrings.registerSubTitle,
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
                        textInputType: TextInputType.text,
                        onSaved: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.fieldRequierd;
                          }
                          return null;
                        },
                      ),
                      Text(
                        AppStrings.email,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      CustomFormField(
                        hint: AppStrings.emailHint,
                        controller: _emailController,
                        textInputType: TextInputType.emailAddress,
                        onSaved: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.fieldRequierd;
                          }
                          return null;
                        },
                      ),
                      Text(
                        AppStrings.firstName,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      CustomFormField(
                        hint: AppStrings.firstNameHint,
                        controller: _firstNameController,
                        textInputType: TextInputType.text,
                        onSaved: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.fieldRequierd;
                          }
                          return null;
                        },
                      ),
                      Text(
                        AppStrings.lastName,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      CustomFormField(
                        hint: AppStrings.lastName,
                        controller: _lastNameController,
                        textInputType: TextInputType.text,
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
                      Text(AppStrings.confirmPassword,
                          style: Theme.of(context).textTheme.headline5),
                      BlocBuilder<AuthanticationCubit, AuthanticationState>(
                        builder: (context, state) {
                          return CustomFormField(
                            hint: AppStrings.confirmPasswordHint,
                            controller: _confirmPasswordController,
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
                              if (value != _passwordController.text) {
                                return AppStrings.passwordNotMatch;
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
                      if (state is RegisterSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(AppStrings.registerSuccess),
                          ),
                        );
                        Constants.navigateNamedReplace(
                            context: context, route: Routes.loginRoute);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthanticationLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return DefaultButton(
                          text: AppStrings.registerButton,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthanticationCubit>().register(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    username: _userNameController.text,
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
                      const Text(AppStrings.alreadyHaveAccount,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.textGray)),
                      SizedBox(
                        width: 10.w,
                      ),
                      TextButton(
                        onPressed: () {
                          Constants.navigateNamedTo(
                              context: context, route: Routes.initialRoute);
                        },
                        child: Text(AppStrings.loginButton,
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
