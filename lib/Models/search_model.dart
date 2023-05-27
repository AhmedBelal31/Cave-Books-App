import 'package:flutter/cupertino.dart';

class ReadingAppSearch
{
  String? id ;
  ReadingAppVolumeInfo? data ;

  ReadingAppSearch.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
   data = ReadingAppVolumeInfo.fromJson(json['volumeInfo'] ) ;
  }

}
class ReadingAppVolumeInfo
{
  String? title ;
  String? subtitle ;
  String? publisher ;
  String? publishedDate ;
  String? description ;
  String? previewLink ;
  String? infoLink ;
  ReadingAppImageLinks? images ;
  ReadingAppVolumeInfo.fromJson(Map<String , dynamic> json)
  {
    title = json['title'] ;
    subtitle = json['subtitle'] != null ?  json['subtitle'] : '' ;
    publisher = json['publisher'] ;
    publishedDate = json['publishedDate'] ;
    description = json['description'] != null ?  json['description'] : '';
    previewLink = json['previewLink'] ;
    infoLink = json['infoLink'] ;
    images = ReadingAppImageLinks.fromJson(json['imageLinks'] ) ;

  }




}

class ReadingAppImageLinks
{

  String? thumbnail ;
  String? small ;
  String? medium ;

  ReadingAppImageLinks.fromJson(Map<String , dynamic> json)
  {
    thumbnail = json['thumbnail'] ;
    small = json['small'] ;
    medium = json['medium'] ;


  }
}

