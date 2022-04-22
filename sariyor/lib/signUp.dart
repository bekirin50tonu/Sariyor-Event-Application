import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SingUpWidget extends StatefulWidget {
  const SingUpWidget({Key? key}) : super(key: key);

  @override
  State<SingUpWidget> createState() => _SingUpWidgetState();
}

class _SingUpWidgetState extends State<SingUpWidget> {
  String _email = '', _password = '', _userName = '';

  final _formKey = GlobalKey<FormState>();

  bool userCheckboxState = false;
  bool mailCheckBoxState = false;
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Giriş Yap',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Ad',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90)),
                                ),
                              ),
                              onSaved: (deger) {
                                _userName = deger!;
                              },
                              validator: (deger) {
                                if (deger!.length < 2) {
                                  return 'Ad 2 karakterden az olamaz';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Soyad',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90)),
                                ),
                              ),
                              onSaved: (deger) {
                                _email = deger!;
                              },
                              validator: (deger) {
                                if (deger!.isEmpty) {
                                  return 'Email boş bırakılamaz';
                                } else if (!EmailValidator.validate(deger)) {
                                  return 'Lütfen geçerli bir mail giriniz!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: isObscure,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    icon: Icon(
                                      isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    )),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Şifre',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90)),
                                ),
                              ),
                              onSaved: (deger) {
                                _password = deger!;
                              },
                              validator: (deger) {
                                if (deger!.length < 6) {
                                  return 'Şifre en az 6 karakter olmalı.';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Şifre Tekrar',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90)),
                                ),
                              ),
                              onSaved: (deger) {},
                              validator: (deger) {
                                if (_password == deger) {
                                  return null;
                                } else
                                  return 'Şifreler eşleşmiyor';
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CheckboxListTile(
                        value: userCheckboxState,
                        onChanged: (deger) {
                          setState(() {
                            userCheckboxState = deger!;
                          });
                        },
                        title: Text(
                          'Kullanım Şartlarını Kabul Ediyorum.',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CheckboxListTile(
                        value: mailCheckBoxState,
                        onChanged: (deger) {
                          setState(() {
                            mailCheckBoxState = deger!;
                          });
                        },
                        title: Text(
                          'E-posta güncellemelerini kabul ediyorum.',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          bool _validate = _formKey.currentState!.validate();

                          if (_validate) {
                            _formKey.currentState!.save();
                            String result =
                                'Ad : $_userName \nemail: $_email \nSifre:$_password';
                            print(result);
                            _formKey.currentState!.reset();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Lütfen Hatalı Olan Yerleri Düzeltiniz.')));
                          }
                        },
                        child: Text('OLUŞTUR'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(350, 50),
                            primary: Color.fromARGB(255, 178, 102, 201),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90)))),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
