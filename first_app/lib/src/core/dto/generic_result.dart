import 'package:flutter/material.dart';

class GenericResult<T> {
  late bool? status;
  late T? result;

  GenericResult({
    Key? key,
    this.status,
    this.result,
  });
}
