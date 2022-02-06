import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TopBar {

  success_top_bar(BuildContext context , String text) {
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: text,
      ),
    );
  }

  error_top_bar(BuildContext context, String text) {
    return showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: text,
      ),
    );
  }



}