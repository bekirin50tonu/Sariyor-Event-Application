import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/features/auth/cubit/auth_cubit.dart';
import 'package:sariyor/widgets/custom_check_form_field.dart';
import 'package:sariyor/widgets/custom_elevated_button.dart';
import 'package:sariyor/widgets/custom_text_form_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthBaseState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Center(
            child: Text(state.message),
          )));
        }
      },
      builder: (context, state) =>
          Scaffold(key: scaffoldKey, body: buildRegisterPage(context, state)),
    );
  }

  Widget buildRegisterPage(BuildContext context, AuthBaseState state) {
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/image17.png',
                                fit: BoxFit.cover,
                                color: Colors.black,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RouteConstants.loginRoute,
                                      (route) => false);
                                },
                                child: const Text(
                                  'Giriş Yap',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Üye Ol',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  label: 'Adınız',
                                  validator: (value) {
                                    if (value.length < 2) {
                                      return 'Adınız, 2 Karakterden Az Olamaz.';
                                    }
                                    return null;
                                  },
                                  controller: context
                                      .watch<AuthCubit>()
                                      .firstnameController,
                                  secureText: false,
                                ),
                                CustomTextFormField(
                                  label: 'Soyadınız',
                                  validator: (value) {
                                    if (value.length < 2) {
                                      return 'Soyadınız, 2 Karakterden Az Olamaz.';
                                    }
                                    return null;
                                  },
                                  controller: context
                                      .watch<AuthCubit>()
                                      .lastnameController,
                                  secureText: false,
                                ),
                                CustomTextFormField(
                                  label: 'Kullanıcı Adınız',
                                  validator: (value) {
                                    if (value.length < 2 || value.length > 16) {
                                      return 'Soyadınız, 2 Karakterden Az ve 16 Karakterden Fazla Olamaz.';
                                    }
                                    return null;
                                  },
                                  controller: context
                                      .watch<AuthCubit>()
                                      .usernameController,
                                  secureText: false,
                                ),
                                CustomTextFormField(
                                  label: 'E-Postanız',
                                  inputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Email boş bırakılamaz';
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return 'Lütfen geçerli bir mail giriniz!';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: context
                                      .watch<AuthCubit>()
                                      .emailController,
                                  secureText: false,
                                ),
                                CustomTextFormField(
                                  label: 'Şifreniz',
                                  validator: (value) {
                                    if (value.length < 6) {
                                      return 'Şifre en az 6 karakter olmalı.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: context
                                      .watch<AuthCubit>()
                                      .passwordController,
                                  secureText: true,
                                ),
                                CustomTextFormField(
                                  label: 'Şifrenizi Tekrar Giriniz',
                                  validator: (value) {
                                    if (context
                                            .read<AuthCubit>()
                                            .checkPasswordController
                                            .text ==
                                        value) {
                                      return null;
                                    }
                                    return 'Şifreler eşleşmiyor';
                                  },
                                  controller: context
                                      .watch<AuthCubit>()
                                      .checkPasswordController,
                                  secureText: true,
                                ),
                                CustomCheckFormField(
                                    state: context
                                        .watch<AuthCubit>()
                                        .mailCheckBoxState,
                                    onChanged: (value) {
                                      context
                                          .read<AuthCubit>()
                                          .mailCheckBoxState = value;
                                    },
                                    text:
                                        'E-posta güncellemelerini kabul ediyorum.'),
                                const SizedBox(
                                  height: 8,
                                ),
                                state is AuthLoadingState
                                    ? const SizedBox(
                                        width: 350,
                                        height: 50,
                                        child: Center(
                                            child: CircularProgressIndicator
                                                .adaptive()),
                                      )
                                    : CustomElevatedButton(
                                        disabled: context
                                            .watch<AuthCubit>()
                                            .mailCheckBoxState,
                                        onPressed: () {
                                          bool _validate =
                                              _formKey.currentState!.validate();

                                          if (_validate) {
                                            _formKey.currentState!.save();
                                            context
                                                .read<AuthCubit>()
                                                .register();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Lütfen Hatalı Olan Yerleri Düzeltiniz.')));
                                          }
                                        },
                                        label: 'Hesap Oluştur',
                                      ),
                              ],
                            ),
                          ),
                        ]),
                  )))
        ],
      ),
    );
  }
}
