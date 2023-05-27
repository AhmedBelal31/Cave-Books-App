import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Models/home_model.dart';
import '../../../component/component.dart';
import '../../../const.dart';
import '../Categories/CategoryDeatails.dart';
import '../Cubit/HomeCubit.dart';
import '../Cubit/HomeStates.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubitObject = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: cubitObject.readingAppHomeModel != null,
            builder: (context) =>
                ProductsBuilder(cubitObject.readingAppHomeModel!, context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget ProductsBuilder(ReadingAppHomeModel model, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: const [
                  Image(
                    image: AssetImage("lib/assets/images/onboarding.png"),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Image(
                    image: AssetImage("lib/assets/images/home.png"),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
                options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    scrollDirection: Axis.horizontal,
                    autoPlayCurve: Curves.easeInOut,
                    viewportFraction: 1)),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Categories ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.0,
                children: List.generate(
                    9,
                    (index) => InkWell(
                          onTap: () {
                            NavigateTo(
                                context,
                                CategoryDeatails(model
                                    .items[index].volumeInfo!.categories[0]));
                          },
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage(
                                      '${HomeCubit.get(context).categoriesImagesList[index]}'),
                                  width: double.infinity,
                                  height: 120,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${model.items[index].volumeInfo!.categories[0]}",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
            )
          ],
        ),
      );

// Widget BuildGridViewItem(ReadingAppCategoryVolumeInfoModel model, context) => Container(
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(alignment: Alignment.bottomCenter, children: [
//
//             Image(
//               image: AssetImage('${HomeCubit.get(context).categoriesImagesList[index] }'),
//               width: double.infinity,
//               height: 150,
//             ),
//
//               Container(
//                   color: Colors.deepOrange,
//                   child:  Text(
//                     "${model.categories}",
//
//                     style: TextStyle(fontSize: 10, color: Colors.white),
//                   ))
//           ]),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${model.publishedDate}",
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "${model.publishedDate}",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style:
//                           const TextStyle(fontSize: 14, color: defaultColor),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//
//                       Text(
//                         "${model.publishedDate}",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             fontSize: 10,
//                             color: Colors.grey,
//                             decoration: TextDecoration.lineThrough),
//                       ),
//
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

// Widget BuildCategoryItem(ReadingAppCategoryVolumeInfoModel model ) => Stack(
//       alignment: AlignmentDirectional.bottomCenter,
//       children: [
//         Image(
//           image: NetworkImage(model.images!.thumbnail! !=null ? model.images!.thumbnail! : 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg' ),
//           fit: BoxFit.cover,
//           width: 200,
//           height: 200,
//         ),
//         Container(
//             width: 100,
//             alignment: Alignment.bottomCenter,
//             color: Colors.black.withOpacity(.6),
//             height: 30,
//             child: Text(
//               model.title!,
//               maxLines: 1,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             )),
//       ],
//     );
}

// Categories
/*

"Ethical relativism"

 "Fertility, Human"

"Subject headings, Library of Congress"


"Information services"



"Literary Collections"


"Cataloging"


"Subject cataloging"


"Language Arts & Disciplines"

"Africa"

"History"

 "Ethical relativism"



*/
