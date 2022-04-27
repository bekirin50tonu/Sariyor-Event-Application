import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission/permission.dart';
import 'package:sariyor/enums/image_route_enum.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/features/user/cubit/user_cubit.dart';
import 'package:sariyor/widgets/background_widget.dart';
import 'package:sariyor/widgets/custom_elevated_button.dart';
import 'package:sariyor/widgets/custom_text_form_field.dart';
import 'package:sariyor/widgets/profile_card_field.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserBaseState>(
        listener: (context, state) async {
      if (state is UserErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(
          child: Text(state.error),
        )));
      }
    }, builder: (context, state) {
      return buildScaffold(context, state);
    });
  }

  Scaffold buildScaffold(BuildContext context, UserBaseState state) {
    // if (state is UserIdleState) context.read<UserCubit>().getUserData();
    return Scaffold(
        key: scaffoldKey,
        appBar: buildAppBarWidget(),
        body: backgroundImageWidget(buildProfilePageWidget(context, state)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: buildBottomNavigationBarWidget(),
        floatingActionButton: buildFloatingActionButtonWidget(context));
  }

  Column buildProfilePageWidget(BuildContext context, UserBaseState state) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(ImageRouteType.profile
                        .url(Auth.instance!.user!.imagePath!)),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                alignment: const Alignment(0, 0),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(ImageRouteType.profile
                                  .url(Auth.instance!.user!.imagePath!))),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(90)),
                    ),
                    Text(Auth.instance!.user!.fullName),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            isScrollControlled: true,
                            context: context,
                            builder: (_) =>
                                buildProfileUpdateWidget(context, state));
                      },
                      child: const Text('Profili Düzenle'),
                      style: ElevatedButton.styleFrom(
                          side:
                              const BorderSide(width: 2.0, color: Colors.black),
                          minimumSize: const Size(150, 40),
                          primary: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 100,
                  color: Colors.transparent,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ProfileCard(userName: 'Bekir'),
                      ProfileCard(userName: 'Bekir'),
                      ProfileCard(userName: 'Bekir'),
                      ProfileCard(userName: 'Bekir'),
                      ProfileCard(userName: 'Bekir'),
                      ProfileCard(userName: 'Bekir'),
                    ],
                  ),
                )
              ],
            )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfileUpdateWidget(BuildContext context, UserBaseState state) {
    return AbsorbPointer(
      absorbing: state is UserLoadingState,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: context.watch<UserCubit>().globalKey,
          child: Column(
            children: [
              InkWell(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (contextshow) =>
                          showImagePickerDialog(contextshow)),
                  child: Stack(
                    children: [
                      state is UserCacheImageState
                          ? CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.transparent,
                              backgroundImage: FileImage(state.image))
                          : CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(ImageRouteType
                                  .profile
                                  .url(Auth.instance!.user!.imagePath!))),
                      const Positioned(
                          bottom: 4, right: 4, child: Icon(Icons.add_a_photo)),
                    ],
                  )),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                        label: 'Adınız',
                        controller:
                            context.watch<UserCubit>().firstnameController,
                        secureText: false),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                        label: 'Soyadınız',
                        controller:
                            context.watch<UserCubit>().lastnameController,
                        secureText: false),
                  ),
                ],
              ),
              CustomTextFormField(
                  label: 'Kullanıcı Adınız',
                  controller: context.watch<UserCubit>().usernameController,
                  secureText: false),
              CustomTextFormField(
                  label: 'E Posta Adresiniz',
                  controller: context.watch<UserCubit>().emailController,
                  secureText: false),
              CustomElevatedButton(
                  disabled: false,
                  label: 'Kaydet',
                  onPressed: () async {
                    log("bekle");
                    await context.read<UserCubit>().updateProfile();
                    log("bitti1");
                    await context.read<UserCubit>().getUserData();
                    log("bitti2");
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget showImagePickerDialog(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text("Galeriden Görsel Seçmek İstiyorum."),
          onTap: () async =>
              await selectImagePicker(ImageSource.gallery, context),
        ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Kamerayı Kullanmak İstiyorum.'),
          onTap: () async =>
              await selectImagePicker(ImageSource.camera, context),
        )
      ],
    );
  }

  Future<void> selectImagePicker(
      ImageSource source, BuildContext context) async {
    await Permission.requestPermissions(
        [PermissionName.Camera, PermissionName.Storage]);
    switch (source) {
      case ImageSource.gallery:
        PickedFile? file = await BlocProvider.of<UserCubit>(context)
            .picker
            .getImage(source: source);
        if (file != null) {
          await BlocProvider.of<UserCubit>(context)
              .photoSelected(File(file.path));
        }
        const Duration(milliseconds: 500);
        Navigator.pop(context);
        break;
      case ImageSource.camera:
        PickedFile? file = await BlocProvider.of<UserCubit>(context)
            .picker
            .getImage(source: source);
        if (file != null) {
          await BlocProvider.of<UserCubit>(context)
              .photoSelected(File(file.path));
        }
        const Duration(milliseconds: 500);
        Navigator.pop(context);
        break;
      default:
    }
  }

  FloatingActionButton buildFloatingActionButtonWidget(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 85, 72, 164),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (_) => buildDraggableCreateEvent(context));
      },
      child: const Icon(Icons.add),
    );
  }

  Widget buildDraggableCreateEvent(BuildContext context) {
    return Column(
      children: const [
        Center(child: Text('Etkinlik Ekleme Buraya Gelecek!!!'))
      ],
    );
  }

  Widget buildBottomNavigationBarWidget() {
    return BottomAppBar(
      notchMargin: 2.0,
      clipBehavior: Clip.antiAlias,
      color: const Color.fromARGB(255, 85, 72, 164),
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.airplanemode_active_outlined),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
            iconSize: 35,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }

  AppBar buildAppBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 1,
      centerTitle: true,
      title: const Image(
        height: 50,
        fit: BoxFit.scaleDown,
        image: AssetImage('images/image17.png'),
      ),
    );
  }
}
