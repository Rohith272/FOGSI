import 'package:flutter/material.dart';
import 'package:fogsi/controller/events/events_controller.dart';
import 'package:fogsi/model/response/events_response.dart';
import 'package:fogsi/utils/colors.dart';

import '../../utils/constants.dart';


class OngoingEventsCard extends StatelessWidget {

  final List<EventRecords> eventRecords;
  final int index;

  const OngoingEventsCard({
    super.key,
    required this.eventRecords,
    required this.index
  });



  @override
  Widget build(BuildContext context){

    EventRecords eventDetails = eventRecords[index];
    return Visibility(
        visible: isToday(eventDetails.eventStartDate ?? ''),
        child: Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5, bottom: 8),
            child: Text(eventDetails.eventTitle ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: lightGreen, fontFamily: 'Rubik'),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              softWrap: false,),
          )
        ],
      ),
    ));
  }
}

