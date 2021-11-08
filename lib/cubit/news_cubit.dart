import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';

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

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getSciences();
    }
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  //apiKey=deefe734b699481fb182ba577d474b5a
// (base url) => https://newsapi.org/
// method(url) => v2/top-headlines?
// queries => country=eg&category=business&apiKey=deefe734b699481fb182ba577d474b5a
  //https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=deefe734b699481fb182ba577d474b5a

//=======================================================================================================================================================

  List<dynamic> business = [];

  getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'deefe734b699481fb182ba577d474b5a'
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetGetBusinessDataSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessDataErrorState(error.toString()));
    });
  }

//=======================================================================================================================================================
  List<dynamic> sports = [];

  getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'deefe734b699481fb182ba577d474b5a'
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsDataSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsDataErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsDataSuccessState());
    }
  }

//=======================================================================================================================================================

  List<dynamic> science = [];

  getSciences() {
    emit(NewsGetSportsLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'deefe734b699481fb182ba577d474b5a'
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetSciencesDataSuccessState());
      }).catchError((error) {
        emit(NewsGetSciencesDataErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSciencesDataSuccessState());
    }
  }

//=======================================================================================================================================================

  List<dynamic> search = [];

  getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
            url: 'v2/everything',
            query: {'q': value, 'apiKey': 'deefe734b699481fb182ba577d474b5a'})
        .then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchDataSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchDataErrorState(error.toString()));
    });
  }

//=======================================================================================================================================================

}
