import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Models/CategoryModel.dart';
import '../../../Models/ChangeFavoriteModel.dart';
import '../../../Models/FavoriteDataModel.dart';
import '../../../Models/HomeModel.dart';
import '../../../Models/LoginModel.dart';
import '../../../Models/categories_item_model.dart';
import '../../../Models/home_model.dart';
import '../../../Models/search_model.dart';
import '../../../Network/endpoint.dart';
import '../../../Network/remote/Dio_Helper.dart';
import '../../../Network/remote/reading_dio_helper.dart';
import '../../../const.dart';
import '../Search/BookDetailsPage.dart';
import 'HomeStates.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());

  static HomeCubit get(context) {
    return BlocProvider.of(context);
  }

  int currentIndex = 0;

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }


  // List<dynamic> searchList = [];

  // List<dynamic> searchDataList = [];

  void getSearch(String search) {
    emit(ShopSearchLoadingState());
    DioHelper.GetData(
        url: 'v1/volumes',
        query: {
          'q': search,
          'key': apiKey
        }
    ).then((value) {
      // searchList = value.data['items'];
      buildCategoryItem = CategoriesItemModel.fromJson(value.data);
      buildCategoryItem!.items.forEach((element) {
        if(element.VolumeInfoModel!.Images !=null  )
        {
          imagesTestList.add(element.VolumeInfoModel!.Images!.thumbnail);

        }

        if(element.VolumeInfoModel!.publisher == null)
        {
          element.VolumeInfoModel!.publisher = '' ;
        }
        if(element.VolumeInfoModel!.publishedDate == null)
        {
          element.VolumeInfoModel!.publishedDate = '' ;
        }
        if(element.VolumeInfoModel!.title == null)
        {
          element.VolumeInfoModel!.title = '' ;
        }
      });

      // print(buildCategoryItem!.items[1].VolumeInfoModel!.Images!.thumbnail);

      print(imagesTestList.length);
      print(buildCategoryItem!.items[0].VolumeInfoModel!.publisher!);


      emit(ShopSearchSuccessState());
    }).catchError((error) {

    });
  }


  ReadingAppSearch? readingAppSearch;

  void buildSearchItemData() {
    emit(SearchLoadingState());
    DioHelper.GetData(
        url: dataId!
    ).then((value) {
      // print(value.data);
      readingAppSearch = ReadingAppSearch.fromJson(value.data);

      if (readingAppSearch!.data!.publisher! ==null
          ||readingAppSearch!.data!.publishedDate == null
          ||readingAppSearch!.data!.description == null
      )
        {
          readingAppSearch!.data!.publisher = ' ' ;
          readingAppSearch!.data!.publishedDate = ' ' ;
          readingAppSearch!.data!.description = ' ' ;
        }

   if (readingAppSearch!.data!.images!.medium == null)
        {
          print("Hello World hhhh ");
          readingAppSearch!.data!.images!.medium = 'http://books.google.com/books/content?id=A8h2p5JteKIC&printsec=frontcover&img=1&zoom=3&edge=curl&imgtk=AFLRE70QkvLD77A6cRpzQPH7yBD6_QtLM75qqp7PcKn-sIri4jz67gM7_RGyMFytufnZ2xDOk6SL98gDVYleGWSZzMclH-AiVNLPy1xIjyfUWWoQFuPuh46P2dNn3sG9nwQUrgU5cUIo&source=gbs_api' ;
          print(readingAppSearch!.data!.images!.medium );
        }
      print(readingAppSearch!.data!.images!.medium );
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error);
    });
  }


  ReadingAppHomeModel? readingAppHomeModel;
  Map<String , dynamic> categoriesImages ={} ;
   List categoriesImagesList =[];


  void getDataFromCategoryModel() {
    emit(ReadingAppHomeLoadingState());
    DioHelper.GetData(
        url: 'https://www.googleapis.com/books/v1/volumes?q=subject'
    ).then((value) {

      readingAppHomeModel = ReadingAppHomeModel.fromJson(value.data);
      readingAppHomeModel!.items.forEach((element) {
        // print(element.volumeInfo!.categories[0]);
        // print(element.id);
        if(element.volumeInfo!.categories[0] =='Ethical relativism')
          {

            categoriesImagesList.add('lib/assets/images/ethical.png');
            // print(categoriesImagesList[0]);

          }
        else if (element.volumeInfo!.categories[0]  == 'Fertility, Human')
          {
            categoriesImagesList.add('lib/assets/images/human.jpg');
          }
        else if (element.volumeInfo!.categories[0]  == 'Subject headings, Library of Congress')
        {
          categoriesImagesList.add('lib/assets/images/library.png');
        }
        else if (element.volumeInfo!.categories[0]  ==  'Information services')
        {
          categoriesImagesList.add('lib/assets/images/infosystem.png');
        }
        else if (element.volumeInfo!.categories[0]  == 'Literary Criticism')
        {
          categoriesImagesList.add('lib/assets/images/LiteraryCriticism.jpg');
        }
        else if (element.volumeInfo!.categories[0]  =='Literary Collections')
        {
          categoriesImagesList.add('lib/assets/images/a1.jpg');
        }
        else if (element.volumeInfo!.categories[0]  == 'Cataloging')
        {
          categoriesImagesList.add('lib/assets/images/Cataloging.jpg');
        }
        else if (element.volumeInfo!.categories[0]  =='Subject cataloging')
        {
          categoriesImagesList.add('lib/assets/images/subject.png');
        }
        else if (element.volumeInfo!.categories[0]  =='Language Arts & Disciplines')
        {
          categoriesImagesList.add('lib/assets/images/arts.jpg');
        }
        else if (element.volumeInfo!.categories[0]  =='Africa')
        {
          categoriesImagesList.add('lib/assets/images/login1.png');
        }
        else if (element.volumeInfo!.categories[0]  =='yLLTugEACAAJ')
        {
          categoriesImagesList.add('lib/assets/images/arts.jpg');
        }

      });


      emit(ReadingAppHomeSuccessState());
    }).catchError((error) {
      emit(ReadingAppHomeErrorState(error));
      print("Error Occurred From CategoryCubit ${error.toString()}");
    });
  }

  HomeModel? homeModel;

  Map<int, bool> favorite = {};

  void getDataFromHomeModel() {
    DioHelper.GetData(
      url: HOME,
    ).then((value) {
      emit(ShopHomeLoadingState());
      homeModel = HomeModel.fromJson(value.data);

      // print(homeModel);
      // print(homeModel!.status);
      // print(homeModel!.data!.products[1].image);

      homeModel!.data!.products.forEach((element) {
        favorite.addAll({element.id!: element.inFavorites!});
      });
      // print(favorite.toString());
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      ShopHomeErrorState(error.toString());
      print(error.toString());
    });
  }

  CategoriesItemModel? buildCategoryItem ;
  List imagesTestList =[];

  void buildCategoryItemData() {
    emit(ReadingAppCategoryLoadingState());
    DioHelper.GetData(
        url: 'v1/volumes?q=${CategoryDetails!}'
    ).then((value) {

      buildCategoryItem = CategoriesItemModel.fromJson(value.data);
      buildCategoryItem!.items.forEach((element) {
        if(element.VolumeInfoModel!.Images !=null  )
          {
            imagesTestList.add(element.VolumeInfoModel!.Images!.thumbnail);

          }

        if(element.VolumeInfoModel!.publisher == null)
          {
            element.VolumeInfoModel!.publisher = '' ;
          }
      });

      // print(buildCategoryItem!.items[1].VolumeInfoModel!.Images!.thumbnail);

      // print(imagesTestList.length);
      // print(buildCategoryItem!.items[0].VolumeInfoModel!.publisher!);


      emit(ReadingAppCategorySuccessState());
    }).catchError((error) {
      print(error);
      emit(ReadingAppCategoryErrorState(error));
    });
  }

List FavoriteIconList =[];

 // void clickFavoriteIcon (String id )
 // {
 //   favoriteScreenSelfLink = id ;
 //   print(favoriteScreenSelfLink);
 //   buildFavoriteScreenData();
 //   // favoriteScreenSelfLink=buildCategoryItem.items[index].selfLink! ;
 //
 //
 // }

  ReadingAppSearch? favoriteScreenData ;

  void buildFavoriteScreenData() {

    emit(FavoriteLoadingState());

    DioHelper.GetData(
        url: favoriteScreenSelfLink!
        // url:'v1/volumes/UeA7AFjDm_wC'
    ).then((value) {
      // print(value.data);
      favoriteScreenData = ReadingAppSearch.fromJson(value.data);

      if (favoriteScreenData!.data!.publisher! ==null
          ||favoriteScreenData!.data!.publishedDate == null
          ||favoriteScreenData!.data!.description == null
      )
      {
        favoriteScreenData!.data!.publisher = ' ' ;
        favoriteScreenData!.data!.publishedDate = ' ' ;
        favoriteScreenData!.data!.description = ' ' ;
      }

      if (favoriteScreenData!.data!.images!.medium == null)
      {

        favoriteScreenData!.data!.images!.medium = 'http://books.google.com/books/content?id=A8h2p5JteKIC&printsec=frontcover&img=1&zoom=3&edge=curl&imgtk=AFLRE70QkvLD77A6cRpzQPH7yBD6_QtLM75qqp7PcKn-sIri4jz67gM7_RGyMFytufnZ2xDOk6SL98gDVYleGWSZzMclH-AiVNLPy1xIjyfUWWoQFuPuh46P2dNn3sG9nwQUrgU5cUIo&source=gbs_api' ;

      }
      // print(favoriteScreenData!.data!.images!.medium );
      print(favoriteScreenSelfLink );


      emit(FavoriteSuccessState());
    }).catchError((error) {
      print(error);
    });
  }








  LoginModel? profilemodel;

  void getProfileData() {
    emit(ShopProfileLoadingState());
    DioHelper2.GetData(url: PROFILE, token: token).then((value) {
      profilemodel = LoginModel.fromJson(value.data);
      print(profilemodel);

      emit(ShopProfileSuccessState());
    }).catchError((error) {
      print("Error From Profile Model ${error.toString()}");
      emit(ShopProfileErrorState() );
    });
  }

  void updateProfileData(
      {required String name, required String email, required String phone}) {
    emit(ShopProfileLoadingState());

    DioHelper2.PutData(
        url: UPDATE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
      profilemodel = LoginModel.fromJson(value.data);

      emit(ShopUpdateProfileSuccessState(profilemodel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateProfileErrorState());
    });
  }


}