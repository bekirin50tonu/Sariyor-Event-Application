import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ProfileCubit extends Cubit<ProfileBaseState> {
  Dio service;
  BuildContext context;
  ProfileCubit(this.service, this.context) : super(const ProfileIdleState());
}

abstract class ProfileBaseState {
  const ProfileBaseState();
}

class ProfileIdleState extends ProfileBaseState {
  const ProfileIdleState();
}

class ProfileLoadingState extends ProfileBaseState {
  const ProfileLoadingState();
}

class ProfileLoadedState extends ProfileBaseState {
  const ProfileLoadedState();
}

class ProfileErrorState extends ProfileBaseState {
  String error;
  ProfileErrorState(this.error);
}
