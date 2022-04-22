import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/features/auth/cubit/login_cubit.dart';
import 'package:sariyor/utils/web_service/web_service.dart';
import 'package:sariyor/widgets/custom_check_form_field.dart';
import 'package:sariyor/widgets/custom_elevated_button.dart';
import 'package:sariyor/widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            LoginCubit(service: WebService.getInstance(), context: context),
        child: Scaffold(
            body: BlocBuilder<LoginCubit, BaseState>(
          builder: ((context, state) => buildLoginPage(context, state)),
        )));
  }

  Widget buildLoginPage(BuildContext context, BaseState state) {
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
                                onPressed: () {},
                                child: const Text(
                                  'Giriş Yap',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RouteConstants.registerRoute,
                                      (route) => false);
                                },
                                child: const Text(
                                  'Üye Ol',
                                  style: TextStyle(
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
                                      .watch<LoginCubit>()
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
                                      .watch<LoginCubit>()
                                      .passwordController,
                                  secureText: true,
                                ),
                                CustomCheckFormField(
                                    state:
                                        context.watch<LoginCubit>().rememberMe,
                                    onChanged: (value) {
                                      context.read<LoginCubit>().rememberMe =
                                          value;
                                    },
                                    text: 'Beni Hatırla.'),
                                const SizedBox(
                                  height: 8,
                                ),
                                state is LoadingState
                                    ? const SizedBox(
                                        width: 350,
                                        height: 50,
                                        child: Center(
                                            child: CircularProgressIndicator
                                                .adaptive()),
                                      )
                                    : CustomElevatedButton(
                                        disabled: false,
                                        onPressed: () {
                                          bool _validate =
                                              _formKey.currentState!.validate();

                                          if (_validate) {
                                            _formKey.currentState!.save();
                                            context.read<LoginCubit>().login();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Lütfen Hatalı Olan Yerleri Düzeltiniz.')));
                                          }
                                        },
                                        label: 'Giriş Yap',
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
