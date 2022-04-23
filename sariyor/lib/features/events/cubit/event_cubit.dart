import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EventCubit extends Cubit<BaseState> {
  final Dio service;
  final BuildContext context;

  EventCubit(this.service, this.context) : super(const IdleState());

}

abstract class BaseState {
  const BaseState();
}

class IdleState extends BaseState {
  const IdleState();
}

class LoadingState extends BaseState {
  const LoadingState();
}
