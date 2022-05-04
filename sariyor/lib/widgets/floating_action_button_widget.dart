import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:permission/permission.dart';
import 'package:sariyor/extensions/context_extensions.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/widgets/category_picker_field.dart';
import 'package:sariyor/widgets/custom_elevated_button.dart';
import 'package:sariyor/widgets/custom_multi_text_field.dart';
import 'package:sariyor/widgets/custom_text_form_field.dart';
import 'package:sariyor/widgets/datetime_picker_field.dart';

import '../enums/image_route_enum.dart';

class FloatingButton extends StatelessWidget {
  bool isEnteredStartTime = false;
  bool isEnteredEndTime = false;
  bool isEnteredJoinStartTime = false;
  bool isEnteredJoinEndTime = false;

  FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventCubit>(context).getCategories();
    BlocProvider.of<EventCubit>(context).getLocation();
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 85, 72, 164),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) =>
                    buildModalDialog(context, setState),
              );
            });
      },
      child: const Icon(Icons.add),
    );
  }

  Widget buildModalDialog(BuildContext context, StateSetter setState) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            ListTile(
              title: Center(
                  child: Text(
                "Etkinlik Ekle",
                style: context.themeText.headline5,
              )),
              subtitle: Form(
                  child: Column(
                children: [
                  InkWell(
                      onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (contextshow) =>
                              showImagePickerDialog(contextshow)),
                      child: Stack(
                        children: [
                          BlocProvider.of<EventCubit>(context).state
                                  is EventPhotoLoadedState
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: FileImage(
                                      (BlocProvider.of<EventCubit>(context)
                                              .state as EventPhotoLoadedState)
                                          .image))
                              : CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      ImageRouteType.event.url(null))),
                          const Positioned(
                              bottom: 4,
                              right: 4,
                              child: Icon(Icons.add_a_photo)),
                        ],
                      )),
                  CategoryPicker(
                    categories:
                        BlocProvider.of<EventCubit>(context).categories!,
                    onSelected: (item) {
                      BlocProvider.of<EventCubit>(context).selectedCategory =
                          item;
                      log(BlocProvider.of<EventCubit>(context)
                          .selectedCategory!
                          .name);
                    },
                  ),
                  CustomTextFormField(
                      label: "Etkinlik Adı",
                      controller: BlocProvider.of<EventCubit>(context)
                          .eventNameController,
                      secureText: false),
                  CustomMultiTextFormField(
                      label: "Etkinlik Hakkında",
                      controller: BlocProvider.of<EventCubit>(context)
                          .eventDescriptionController,
                      secureText: false),
                  CustomTextFormField(
                      inputType: TextInputType.number,
                      label: "Katılımcı Sayısını Giriniz.",
                      controller: BlocProvider.of<EventCubit>(context)
                          .eventCountController,
                      secureText: false),
                  Expanded(
                      flex: 2,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                BlocProvider.of<EventCubit>(context)
                                    .data!
                                    .latitude,
                                BlocProvider.of<EventCubit>(context)
                                    .data!
                                    .latitude)),
                      )),
                  CustomDateTimePicker(
                      displayLabel: isEnteredStartTime
                          ? BlocProvider.of<EventCubit>(context)
                              .startTime
                              .toString()
                          : "Tarih Seçiniz.",
                      label: "Başlama Tarihini Seçiniz.",
                      startTime: DateTime.now(),
                      endTime: DateTime.now().add(const Duration(days: 30)),
                      onPressed: (date) {
                        setState(() {
                          BlocProvider.of<EventCubit>(context).startTime =
                              date!;
                          isEnteredStartTime = true;
                        });
                      }),
                  CustomDateTimePicker(
                      displayLabel: isEnteredEndTime
                          ? BlocProvider.of<EventCubit>(context)
                              .endTime
                              .toString()
                          : "Tarih Seçiniz.",
                      label: "Bitiş Tarihini Seçiniz.",
                      startTime: BlocProvider.of<EventCubit>(context).startTime,
                      endTime: context
                          .watch<EventCubit>()
                          .startTime
                          .add(const Duration(days: 30)),
                      onPressed: (date) {
                        BlocProvider.of<EventCubit>(context).endTime = date!;
                        isEnteredEndTime = true;
                        setState(() {});
                      }),
                  CustomDateTimePicker(
                      displayLabel: isEnteredJoinStartTime
                          ? BlocProvider.of<EventCubit>(context)
                              .joinStartTime
                              .toString()
                          : "Tarih Seçiniz.",
                      label: "Katılım Başlama Tarihini Seçiniz.",
                      startTime:
                          BlocProvider.of<EventCubit>(context).joinStartTime,
                      endTime: context
                          .watch<EventCubit>()
                          .joinStartTime
                          .add(const Duration(days: 30)),
                      onPressed: (date) {
                        BlocProvider.of<EventCubit>(context).joinStartTime =
                            date!;
                        isEnteredJoinStartTime = true;
                        setState(() {});
                      }),
                  CustomDateTimePicker(
                      displayLabel: isEnteredJoinEndTime
                          ? BlocProvider.of<EventCubit>(context)
                              .joinEndTime
                              .toString()
                          : "Tarih Seçiniz.",
                      label: "Katılım Bitiş Tarihini Seçiniz.",
                      startTime:
                          BlocProvider.of<EventCubit>(context).joinStartTime,
                      endTime: context
                          .watch<EventCubit>()
                          .startTime
                          .add(const Duration(days: 30)),
                      onPressed: (date) {
                        BlocProvider.of<EventCubit>(context).joinEndTime =
                            date!;
                        isEnteredJoinEndTime = true;
                        setState(() {});
                      }),
                  ListTile(
                    title: const Text("Sadece Arkadaşlar"),
                    trailing: CupertinoSwitch(
                      value: BlocProvider.of<EventCubit>(context).onlyFriend,
                      onChanged: (value) {
                        BlocProvider.of<EventCubit>(context).onlyFriend = value;
                        setState(() {});
                      },
                    ),
                  ),
                  BlocProvider.of<EventCubit>(context).state
                          is EventLoadingState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : CustomElevatedButton(
                          label: "Etkinlik Oluştur.",
                          onPressed: () async {
                            await BlocProvider.of<EventCubit>(context)
                                .addEvent();
                            Navigator.pop(context);
                          },
                          disabled: false,
                        )
                ],
              )),
            )
          ],
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
        PickedFile? file = await BlocProvider.of<EventCubit>(context)
            .picker
            .getImage(source: source);
        if (file != null) {
          await BlocProvider.of<EventCubit>(context)
              .photoSelected(File(file.path));
        }
        const Duration(milliseconds: 500);
        Navigator.pop(context);
        break;
      case ImageSource.camera:
        PickedFile? file = await BlocProvider.of<EventCubit>(context)
            .picker
            .getImage(source: source);
        if (file != null) {
          await BlocProvider.of<EventCubit>(context)
              .photoSelected(File(file.path));
        }
        const Duration(milliseconds: 500);
        Navigator.pop(context);
        break;
      default:
    }
  }
}
