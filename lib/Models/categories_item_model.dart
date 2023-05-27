class CategoriesItemModel
{
  int? totalItems ;
  List<CategoriesItemDataModel> items = [] ;

  CategoriesItemModel.fromJson(Map<String , dynamic> json)
  {
     json['items'].forEach((element){
       items.add(CategoriesItemDataModel.fromJson(element) );
     });
  }
}

class CategoriesItemDataModel
{
  String? id ;
  String? selfLink ;
  VolumeDataModel? VolumeInfoModel ;
  CategoriesItemDataModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    selfLink = json['selfLink'];
    VolumeInfoModel= VolumeDataModel.fromJson(json['volumeInfo'] );

  }
}

class VolumeDataModel
{
  String? title ;
  String? publishedDate ;
  String? publisher ;
  String? previewLink ;
  String? description ;
  ImagesItemsModel? Images ;
  VolumeDataModel.fromJson(Map<String , dynamic> json)
  {
    title = json['title'];
    publishedDate = json['publishedDate'];
    previewLink = json['previewLink'];
    description = json['description'];
    publisher = json['publisher'];
    Images = json['imageLinks'] != null ? ImagesItemsModel.fromJson(json['imageLinks'] ) : null;

  }
}

class ImagesItemsModel
{
  String? smallThumbnail ;
  String? thumbnail ;

  ImagesItemsModel.fromJson(Map<String , dynamic> json)
  {
    smallThumbnail = json['smallThumbnail'];
    thumbnail = json['thumbnail'];
  }
}