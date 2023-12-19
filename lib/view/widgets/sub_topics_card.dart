import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fogsi/model/response/list_response.dart';
import 'package:fogsi/utils/colors.dart';

import '../../utils/images.dart';
import '../../utils/posters.dart';
import 'content_screen.dart';

class SubTopicCard extends StatelessWidget {

  final List<Records> subTopicList;
  final int index;

  const SubTopicCard({
      super.key,
      required this.subTopicList,
      required this.index,
  });


  
  @override
  Widget build(BuildContext context){
    Records topicDetails = subTopicList[index];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageCarousel(listId: topicDetails.subTopicId ?? 0,displayOrder: 1,relationTypeId: 1,),
        ),
      );},
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl:topicDetails.iconUrl ?? "",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  height: 64,
                  width: 64,
                ),
              ),
            ),
            Flexible(
                child: Container(
              margin: EdgeInsets.only(left: 18),
              child: Text(topicDetails.subTopicTitle ?? "", style: TextStyle(color: menuTitleGrey, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Rubik' ),),
            ))
          ],
        ),
      ),
    );
  }
}

