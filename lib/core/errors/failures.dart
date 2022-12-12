import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Failures extends Equatable {
  final String message;

  const Failures({required this.message});

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failures {
  const ServerFailure({required String message}) : super(message: message);
}

class NetworkFailure extends Failures {
  const NetworkFailure({required String message}) : super(message: message);
}

class CachedFailure extends Failures {
  const CachedFailure({required String message}) : super(message: message);
}

dynamic failureToString(Failures failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      Map errorModel = jsonDecode(failure.message);
      debugPrint(errorModel.values.first.toString());

      return errorModel.values.first;

    case CachedFailure:
      return failure.message;
    default:
      return failure.message;
  }
}

void showError(context, message) {
  if (message.runtimeType == String) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        backgroundColor: Colors.red,
      ),
    );
  } else if (message.runtimeType == List) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message[0]),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        backgroundColor: Colors.red,
      ),
    );
  }
}
