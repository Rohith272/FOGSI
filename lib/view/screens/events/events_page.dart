import 'package:flutter/material.dart';
import 'package:fogsi/controller/events/events_controller.dart';
import 'package:fogsi/controller/main-layout/main_layout_controller.dart';
import 'package:fogsi/model/response/events_response.dart';
import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/utils/components_list.dart';
import 'package:fogsi/utils/images.dart';
import 'package:fogsi/view/screens/home/regular_home.dart';
import 'package:fogsi/view/screens/library/library_page.dart';
import 'package:fogsi/view/widgets/ongoing_events_card.dart';
import 'package:fogsi/view/widgets/upcoming_events_card.dart';
import 'package:get/get.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>{


  final EventsController eventsController = Get.put(EventsController());
  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());

  var isNormalLoading = true.obs;
  List<EventRecords> eventList = <EventRecords>[];
  final List<Widget> components= ComponentList.components;
  int currentMonthIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final List<String> monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

  @override
  void initState(){
    super.initState();
    if (mainLayoutController.indexStack.last != 1){
      setState(() {
        mainLayoutController.addScreen(EventsScreen());
      });
    }
    eventList = [];
    getAndPrefillData();
    _scrollController.addListener(_onScroll);
  }

  Future<void> getAndPrefillData() async {
    await eventsController.getEvents();
    List<EventRecords> tList = [];
    for (int i = 0; i < eventsController.records.length; i++) {
      tList.add(eventsController.records[i]);
    }
    eventList.addAll(tList);
    isNormalLoading.value = false;
    setState(() {});
  }

  void _onScroll() {
    if (_scrollController.offset >= MediaQuery.of(context).size.height*0.08) {
      eventsController.showGoToTopButton.value = true;
    } else {
      eventsController.showGoToTopButton.value = false;
    }
  }

  void onNextMonth() {
    if (currentMonthIndex < monthNames.length - 1) {
      currentMonthIndex++;
    }
    setState(() {});
  }

  void onPreviousMonth() {
    if (currentMonthIndex > 0) {
      currentMonthIndex--;
    }
    setState(() {});
  }

  void goToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: Obx(() {
        return eventsController.showGoToTopButton.value ?
          FloatingActionButton(
            shape: CircleBorder(),
            onPressed: goToTop,
            child: Icon(Icons.arrow_upward),)
            : Container();
      }),
      body: SingleChildScrollView(
        controller: _scrollController,
          child: Container(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Obx(() => Visibility(
                  visible: eventsController.hasOngoing.value,
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 16),
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                        color: tealColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Today", style: TextStyle( color:  lightTeal, fontSize: 24, fontWeight: FontWeight.w500, fontFamily: 'Rubik'),),
                        ),
                        Container(
                            child: Obx(() {
                              if (isNormalLoading.value) {
                                return const Center(
                                  child: SizedBox(
                                    width: 40,
                                  ),
                                );
                              }
                              return NotificationListener<OverscrollIndicatorNotification>(
                                onNotification: (overscroll) {
                                  overscroll.disallowIndicator();
                                  return true;
                                },
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            ListView.separated(
                                              physics: const NeverScrollableScrollPhysics(),
                                              reverse: false,
                                              padding: const EdgeInsets.only(top: 0),
                                              shrinkWrap: true,
                                              itemCount: eventList.length,
                                              separatorBuilder: (context, index) {
                                                return const SizedBox(

                                                );
                                              },
                                              itemBuilder: (context, index) {
                                                return OngoingEventsCard(eventRecords: eventList, index: index,);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            ))
                      ],
                    ),
                  ),
                ),),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(monthNames[currentMonthIndex], style: TextStyle(color: tealColor, fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Rubik'),),
                      ),
                      Container(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: onPreviousMonth,
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: pageProminent,
                                    borderRadius: BorderRadius.circular(35)
                                ),
                                child: Image.asset(Images.previousIcon),
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: onNextMonth,
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: pageProminent,
                                    borderRadius: BorderRadius.circular(35)
                                ),
                                child: Image.asset(Images.nextIcon),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Obx(() {
                    if (isNormalLoading.value) {
                      return const Center(
                        child: SizedBox(
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 20, top: 0),
                              child: Column(
                                children: [
                                  ListView.separated(
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(top: 0),
                                    shrinkWrap: true,
                                    itemCount: eventList.length,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox();
                                    },
                                    itemBuilder: (context, index) {
                                      return UpcomingEventsCard(eventRecords: eventList, index: index, month: monthNames[currentMonthIndex],);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          )
      ),
    );
  }
}