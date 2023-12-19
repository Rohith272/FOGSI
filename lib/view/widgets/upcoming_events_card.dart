import 'package:flutter/material.dart';
import 'package:fogsi/model/response/events_response.dart';
import 'package:fogsi/utils/colors.dart';

import '../../utils/constants.dart';

class UpcomingEventsCard extends StatelessWidget {
  final List<EventRecords> eventRecords;
  final int index;
  final String month;

  const UpcomingEventsCard({
    super.key,
    required this.eventRecords,
    required this.index,
    required this.month,
  });

  Map<String, List<EventRecords>> groupEventsByDate() {
    Map<String, List<EventRecords>> groupedEvents = {};

    for (EventRecords event in eventRecords) {

      if(isInThisMonth(month, event.eventStartDate ?? "")){
        String startDate = event.eventStartDate ?? "";
        String endDate = event.eventEndDate ?? "";
        String formattedStartDate = parseToDay(startDate);
        String formattedEndDate = parseToDay(endDate);

        String key;
        if (startDate == endDate || endDate.isEmpty) {
          key = formattedStartDate;
        } else {
          key = '$formattedStartDate to $formattedEndDate';
        }

        if (groupedEvents.containsKey(key)) {
          groupedEvents[key]!.add(event);
        } else {
          groupedEvents[key] = [event];
        }
      }
      }
      return groupedEvents;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<EventRecords>> groupedEvents = groupEventsByDate();
    List<String> dateKeys = groupedEvents.keys.toList();

    if (index < dateKeys.length) {
      String dateRange = dateKeys[index];
      List<EventRecords> events = groupedEvents[dateRange]!;

      return Visibility(
        visible: isUpComing(events[0].eventStartDate ?? ""),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16, right: 16),
              margin: EdgeInsets.only(top: 32),
              height: 28,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: dateBackGround,
              ),
              child: Text(
                dateRange,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: tealColor,
                  fontFamily: 'Rubik'
                ),
              ),
            ),
            Column(
              children: events
                  .map((event) => Container(
                constraints: BoxConstraints(
                  minHeight: 44
                ),
                margin: EdgeInsets.only(top: 12),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  event.eventTitle ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: menuTitleGrey,
                    fontFamily: 'Rubik'
                  ),
                ),
              ))
                  .toList(),
            ),
          ],
        ),
      );
    } else {
      // Handle index out of bounds, for example, show an error message or return an empty container.
      return Container();
    }
  }
}
