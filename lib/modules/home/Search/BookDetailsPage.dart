import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Models/search_model.dart';
import '../../../Network/WebView/webview.dart';
import '../../../component/component.dart';
import '../../../const.dart';
import '../../../style/color.dart';
import '../Cubit/HomeCubit.dart';
import '../Cubit/HomeStates.dart';

class BookDetailsPage extends StatelessWidget {
  // const SearchData({Key? key}) : super(key: key);
  final String id;

  BookDetailsPage({required this.id });


  @override
  Widget build(BuildContext context) {
    dataId = id;
    // print(dataId);
    return BlocProvider(
      create: (context) => HomeCubit()..buildSearchItemData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubobj = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body:ConditionalBuilder(
                condition: state is! SearchLoadingState ,
                builder: (context) =>WidgetBuildBookItem(cubobj.readingAppSearch!,context),
                fallback: (context) => const Center(child: CircularProgressIndicator())
            ) ,
          );

        },
      ),
    );
  }
  
  WidgetBuildBookItem(ReadingAppSearch model ,context)=>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(

          children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Expanded(
                 child: Text(
                   "${model.data!.title} " ,
                   textAlign: TextAlign.center,
                   style: const TextStyle(
                       fontSize: 18 ,
                       color: defaultColor ,
                       fontWeight: FontWeight.bold
                   ),
                 ),
               ),

             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Expanded(
                 child: Text(
                   "${model.data!.subtitle} " ,
                   textAlign: TextAlign.center,
                   style: TextStyle(
                       fontSize: 15 ,
                       color: Colors.grey[700] ,
                       fontWeight: FontWeight.bold
                   ),
                 ),
               ),

             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Expanded(
                 child: Stack(
                   alignment: Alignment.bottomCenter,
                   children: [
                     ClipRRect(
                       borderRadius: BorderRadius.circular(20.0),
                       child: Image(
                         image: NetworkImage("${model.data!.images!.medium} "),

                         width: 280,
                         height: 380,
                         fit: BoxFit.cover,
                       ),
                     ),
                     Container(
                       width: 280,
                       color: Colors.black.withOpacity(.6),

                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Expanded(
                             flex: 2,
                             child: Text(
                               "${model.data!.publisher} " ,
                               textAlign: TextAlign.center,
                               style: const TextStyle(
                                   fontSize: 14 ,
                                   color: Colors.white ,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                           Expanded(
                             child: Text(
                               "   ${model.data!.publishedDate} " ,
                               textAlign: TextAlign.center,

                               style: const TextStyle(
                                   fontSize: 12 ,
                                   color: defaultColor,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                         ],
                       ),
                     )

                   ],
                 ),
               )
             ],
           ),
           const SizedBox(height: 20,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Expanded(
                 child: Text(
                   "${model.data!.description} " ,
                   maxLines: 3,

                   style: const TextStyle(
                       fontSize: 16 ,
                       height: 1.6,
                       color: defaultColor ,
                       fontWeight: FontWeight.bold ,
                     overflow: TextOverflow.ellipsis
                   ),
                 ),
               ),

             ],
           ),
           const SizedBox(height:30 ,),
           Container(

             width: 250,
             height: 50,
             decoration: BoxDecoration(
              color: Colors.deepOrange,
               borderRadius: BorderRadius.circular(20)
             ),
             child: MaterialButton(
                onPressed:()
                {
                 NavigateTo(context, WebViewScreen(url: "${model.data!.previewLink}"));
                },
                child: const Text(

                  "Read " ,

                  style: TextStyle(
                    fontSize: 22 ,
                    color: Colors.white ,
                    fontWeight: FontWeight.bold,


                  ),
                ),
              ),
           )
          ],
        ),
      ),
    );
}
