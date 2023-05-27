import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../Models/FavoriteDataModel.dart';
import '../../../Models/search_model.dart';
import '../../../Network/WebView/webview.dart';
import '../../../component/component.dart';
import '../../../const.dart';
import '../../../style/color.dart';
import '../Cubit/HomeCubit.dart';
import '../Cubit/HomeStates.dart';
import '../Search/BookDetailsPage.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubobj = HomeCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
                condition:  cubobj.favoriteScreenData !=null,
                builder: (context) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>  InkWell(
                        onTap: () {
                          NavigateTo(
                              context,
                              BookDetailsPage(
                                id: cubobj.buildCategoryItem!.items[index]
                                    .selfLink!,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 30,
                          ),
                          child: Container(
                            height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: NetworkImage(
                                        '${HomeCubit.get(context).favoriteScreenData!.data!.images!.medium}'),
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(

                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${cubobj.favoriteScreenData!.data!.title}',
                                        maxLines: 2,
                                        style: const TextStyle(
                                            height: 1.6,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex :2 ,
                                            child: Text(
                                              '${cubobj.favoriteScreenData!.data!.publisher}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: defaultColor,
                                                  height: 1.6),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${cubobj.favoriteScreenData!.data!.publisher}',
                                              maxLines: 2,

                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: defaultColor),
                                            ),
                                          ),
                                          Expanded(
                                            child: MaterialButton(
                                              onPressed:()
                                              {


                                              } ,
                                              child: const CircleAvatar(
                                                radius: 12,
                                                backgroundColor:defaultColor,
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color:Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      separatorBuilder: (context, index) => myDivider(),
                      itemCount:1 ,
                    ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator())),

          );

        },
      );
  }



}
