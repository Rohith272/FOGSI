import 'package:flutter/material.dart';
import 'package:fogsi/controller/main-layout/main_layout_controller.dart';
import 'package:get/get.dart';
import 'package:fogsi/utils/colors.dart';

import '../../model/response/segment_response_list.dart';
import '../../utils/images.dart';
import '../../utils/posters.dart';
import 'content_screen.dart';

class SegmentCard extends StatelessWidget {

  final List<Records> segmentList;
  final int index;

  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());

  SegmentCard({
    super.key,
    required this.segmentList,
    required this.index,
  });




  @override
  Widget build(BuildContext context){
    Records segmentDetails = segmentList[index];
    return GestureDetector(
      onTap: () {
          mainLayoutController.setIndex(3, "Safety", segmentDetails.segmentId ?? 0);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: menuGrey
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Image.network(segmentDetails.iconUrl ?? "",),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(segmentDetails.title ?? "", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: menuTitleGrey),),
            )
          ],
        ),
      ),
    );
  }
}