import 'package:flutter/material.dart';
import 'package:fogsi/model/response/events_response.dart';
import 'package:fogsi/model/response/search_result_response.dart';
import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/view/widgets/content_screen.dart';

import '../../utils/constants.dart';


class SearchResultCard extends StatelessWidget {

  final List<SearchRecords> searchRecords;
  final int index;

  const SearchResultCard({
    super.key,
    required this.searchRecords,
    required this.index
  });

  @override
  Widget build(BuildContext context){
    SearchRecords record = searchRecords[index];
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageCarousel(listId: record.parentId ?? 0, displayOrder: record.displayOrder ?? 0,relationTypeId: record.relationTypeId ?? 0,),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: RichText(
          text: TextSpan(
            text: record.contentTitle?.trim() ?? "",
            style: TextStyle(color: menuTitleGrey, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Rubik'),
          ),
        ),
      ),
    );
  }
}