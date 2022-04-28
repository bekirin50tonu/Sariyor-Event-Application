import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sariyor/constants/url_constant.dart';

import '../models/base/base_category_model.dart';

class CategoryCubit extends Cubit<CategoryBaseState> {
  CategoryCubit(this.service, this.context) : super(const CategoryIdleState());
  Dio service;
  BuildContext context;

  Future<void> getCategories() async {
    try {
      log("yükleniyir...");
      emit(const CategoryLoadingState());
      var response = await service.get(URLConstants.getCategories);
      log(response.data['message']);
      if (response.statusCode == 200) {
        emit(CategoryLoadedState(response.data['data']
            .map<Category>((json) => Category.fromJson(json))
            .toList()));
        return;
      }
      emit(const CategoryIdleState());
    } on DioError catch (e) {
      emit(CategoryErrorState(e.response!.data['errors'].join('\n')));
    }
  }
}

abstract class CategoryBaseState {
  const CategoryBaseState();
}

class CategoryIdleState extends CategoryBaseState {
  const CategoryIdleState();
}

class CategoryLoadingState extends CategoryBaseState {
  const CategoryLoadingState();
}

class CategoryLoadedState extends CategoryBaseState {
  List<Category> category;
  CategoryLoadedState(this.category);
}

class CategoryErrorState extends CategoryBaseState {
  String message;
  CategoryErrorState(this.message);
}
