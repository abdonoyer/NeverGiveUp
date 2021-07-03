import 'package:flutter/material.dart';

showLoading(context) {
  return AlertDialog(
    title: Text('loading..'),
    content: Container(
      height: 50,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
