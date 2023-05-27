import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../component/component.dart';
import '../../style/color.dart';
import 'Cubit/HomeCubit.dart';
import 'Cubit/HomeStates.dart';
import 'Favorite/FavoriteScreen.dart';
import 'Home/HomeScreen.dart';
import 'Search/BooksList.dart';
import 'Settings/SettingsScreen.dart';

class Home_Layout extends StatelessWidget {
  List<Widget> screens = const [
    HomeScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getDataFromCategoryModel()..getProfileData()
        ,
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubitObject = HomeCubit.get(context);
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Cave books ",
                    style: TextStyle(fontSize: 25, color: defaultColor),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          NavigateTo(context, BooksListScreen());
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubitObject.currentIndex,
                  onTap: (value) {
                    cubitObject.changeBottomNavBarIndex(value);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: "Favorites"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: "Settings"),
                  ],
                ),
                body: screens[cubitObject.currentIndex]),
          );
        },
      ),
    );
  }
}
