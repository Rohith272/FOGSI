import 'package:flutter/cupertino.dart';
import 'package:fogsi/view/screens/faq/faq_screen.dart';
import 'package:fogsi/view/screens/home/doctor_home.dart';
import 'package:fogsi/view/screens/list/list_layout.dart';
import 'package:fogsi/view/screens/medication-reference/medication_details_screen.dart';
import 'package:fogsi/view/screens/medication-reference/medication_references_screen.dart';
import 'package:fogsi/view/screens/search/search_result.dart';
import 'package:fogsi/view/widgets/no_internet_screen.dart';
import '../view/screens/events/events_page.dart';
import '../view/screens/library/library_page.dart';
import '../view/screens/home/regular_home.dart';

class ComponentList{
  static const List<Widget> components = [
    HomeScreen(),
    EventsScreen(),
    LibraryScreen(),
    SubTopicScreen(),
    DoctorHomeScreen(),
    MedicationReferenceScreen(),
    SearchResultScreen(),
    NoInternetScreenScreen(),
    FaqScreen(),
  ];
}