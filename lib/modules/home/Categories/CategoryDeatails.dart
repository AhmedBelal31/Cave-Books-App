import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Models/categories_item_model.dart';
import '../../../component/component.dart';
import '../../../const.dart';
import '../../../style/color.dart';
import '../Cubit/HomeCubit.dart';
import '../Cubit/HomeStates.dart';
import '../Search/BookDetailsPage.dart';

class CategoryDeatails extends StatelessWidget {
  // const CategoryDeatails({Key? key}) : super(key: key);
  final String CatDetails;

  CategoryDeatails(this.CatDetails);

  @override
  Widget build(BuildContext context) {
    CategoryDetails = CatDetails;
    return BlocProvider(
      create: (context) => HomeCubit()..buildCategoryItemData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubobj = HomeCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body: ConditionalBuilder(
                  condition: cubobj.buildCategoryItem != null,
                  builder: (context) => ListView.separated(
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
                                              overflow: TextOverflow.ellipsis),
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
                                                overflow: TextOverflow.ellipsis,
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
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: defaultColor),
                                              ),
                                            ),
                                            Expanded(
                                              child: MaterialButton(
                                                onPressed: () {
                                                  favoriteScreenSelfLink=cubobj.buildCategoryItem!.items[index].selfLink! ;
                                                  print(favoriteScreenSelfLink);

                                                },
                                                child: const CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: defaultColor,
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white,
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
                        itemCount: cubobj.imagesTestList.length,
                      ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator())));
        },
      ),
    );
  }
}
