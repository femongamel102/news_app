import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
     ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'a7f53be37cbf446f8f577d7dc2d2bbad'
      }).then((value) {
        business = value.data['articles'];
        print(business);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetBusinessLoadingState());

    if(sports.isEmpty){
     DioHelper.getData(url: 'v2/top-headlines', query: {
       'country': 'eg',
       'category': 'sports',
       'apiKey': 'a7f53be37cbf446f8f577d7dc2d2bbad'
     }).then((value) {
       sports = value.data['articles'];
       print(sports);
       emit(NewsGetSportsSuccessState());
     }).catchError((error) {
       print(error.toString());
       emit(NewsGetSportsErrorState(error.toString()));
     });
   }else{
     emit(NewsGetSportsSuccessState());

   }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetBusinessLoadingState());
    if(science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'a7f53be37cbf446f8f577d7dc2d2bbad'
      }).then((value) {
        science = value.data['articles'];
        print(science);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }
}
