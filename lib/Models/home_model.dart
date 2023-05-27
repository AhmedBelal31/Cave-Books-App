import 'package:flutter/cupertino.dart';

class ReadingAppHomeModel {
  int? totalItems;

  List<ReadingAppCategoryItemModel> items = [];

  ReadingAppHomeModel.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    json['items'].forEach((element) {
      items.add(ReadingAppCategoryItemModel.fromJson(element));
    });
  }
}

class ReadingAppCategoryItemModel {
  String? id;

  String? selfLink;

  ReadingAppCategoryVolumeInfoModel? volumeInfo;

  ReadingAppCategoryItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selfLink = json['selfLink'];
    volumeInfo = ReadingAppCategoryVolumeInfoModel.fromJson(json['volumeInfo']);
  }
}

class ReadingAppCategoryVolumeInfoModel {
  String? title;

  String? subtitle;

  List categories=[];

  String? previewLink;

  int? pageCount;

  String? publishedDate;
  ReadingAppImagesDataModel? images;

  // ImageLinks? imageLinks;


  ReadingAppCategoryVolumeInfoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
     json['categories'].forEach((element){
       categories.add(element);
     })  ;
    previewLink = json['previewLink'];
    images = json['imageLinks'] != null
        ? ReadingAppImagesDataModel.fromJson(json['imageLinks'])
        :null
    ;

    pageCount = json['pageCount'];
    publishedDate = json['publishedDate'];
  }
}

class ReadingAppImagesDataModel {
  String? smallThumbnail;

  String? thumbnail;

  ReadingAppImagesDataModel.fromJson(Map<String, dynamic> json) {
    smallThumbnail = json['smallThumbnail'];
    thumbnail = json['thumbnail'];
  }
}

