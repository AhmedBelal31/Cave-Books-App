import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/FavoriteDataModel.dart';
import '../../../Models/SearchModel.dart';
import '../../../Models/SearchModel.dart';
import '../../../component/component.dart';
import '../../../const.dart';
import '../../../style/color.dart';
import '../Cubit/HomeCubit.dart';
import '../Cubit/HomeStates.dart';
import 'BookDetailsPage.dart';

class BooksListScreen extends StatelessWidget {
  const BooksListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchContrller = TextEditingController();
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubobj = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        key: formKey,
                        controller: searchContrller,
                        onChanged: (value) {
                          cubobj.getSearch(value);
                        },
                        onFieldSubmitted: (String value) {
                          cubobj.getSearch(value);
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            labelText: "Search",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is ShopSearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if (cubobj.buildCategoryItem != null)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => InkWell(
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
                                            '${HomeCubit.get(context).imagesTestList[index]}'),
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
                                            '${cubobj.buildCategoryItem!.items[index].VolumeInfoModel!.title}',
                                            maxLines: 2,
                                            style: const TextStyle(
                                                height: 1.6,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  '${cubobj.buildCategoryItem!.items[index].VolumeInfoModel!.publisher}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: defaultColor,
                                                      height: 1.6),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${cubobj.buildCategoryItem!.items[index].VolumeInfoModel!.publishedDate}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: defaultColor),
                                                ),
                                              ),
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
                          itemCount: 6,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// Widget BuildSearchScreenItem( model ,context) => InkWell(
//   onTap: (){
//    NavigateTo(context, SearchData(id: model['selfLink'], ));
//   },
//   child: Container(
//     height: 150,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Stack(alignment: Alignment.bottomLeft, children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child:
//           // ConditionalBuilder(
//           //     condition: model['volumeInfo']['imageLinks']['thumbnail'] !=null,
//           //     builder: (context)=>Image(
//           //       image: NetworkImage('${model['volumeInfo']['imageLinks']['thumbnail']  }'),
//           //       width: 150,
//           //       height: 150,
//           //     ),
//           //     fallback:(context)=>Image(image: AssetImage( "lib/assets/images/onboarding.png",),),
//           // )
//             Image(
//               image: NetworkImage('${model['volumeInfo']['imageLinks']['thumbnail']  !=null
//                   ? model['volumeInfo']['imageLinks']['thumbnail'] :'' }'),
//               width: 150,
//               height: 150,
//             ),
//
//
//           ),
//         ]),
//         const SizedBox(
//           width: 15,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '${model['volumeInfo']['title']}',
//
//                 maxLines: 2,
//                 style: const TextStyle(
//                     height: 1.6,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16,
//                     overflow: TextOverflow.ellipsis),
//               ),
//               const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//
//                       "'${model['volumeInfo']['publisher']}'",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                           fontSize: 12, color: defaultColor),
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       "'${model['volumeInfo']['publishedDate']}'",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                           fontSize: 14, color: defaultColor),
//                     ),
//                   ),
//
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// );
}
