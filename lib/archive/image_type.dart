import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:vip_delivery_version_1/model/mediatype.dart';

class ImageType {
  File file;
  bool Damaged;
  Media mediaType;
  RawImage? thum;

  ImageType(this.file, this.Damaged, this.mediaType);

}