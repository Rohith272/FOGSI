import 'package:flutter/material.dart';
import 'package:fogsi/controller/list-layout/list_layout_controller.dart';
import 'package:fogsi/model/response/list_response.dart';
import 'package:fogsi/model/response/search_result_response.dart';
import 'package:fogsi/view/widgets/search_result_card.dart';
import 'package:fogsi/view/widgets/sub_topics_card.dart';
import 'package:get/get.dart';
import '../../../controller/main-layout/main_layout_controller.dart';
import '../../../utils/colors.dart';

class SearchResultScreen extends StatefulWidget {

  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen>{

  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());

  List<SearchRecords> subTopicList = <SearchRecords>[];
  final _scrollController = ScrollController();
  var isLoading = false.obs;
  var isNormalLoading = true.obs;

  @override
  void initState(){
    super.initState();
    subTopicList = [];
    Future.delayed(Duration.zero, () async {
      await getAndPrefillData();
    });
  }




  Future<void> getAndPrefillData() async {
    List<SearchRecords> tList = [];
    for (int i = 0; i < mainLayoutController.searchRecords.length; i++) {
      tList.add(mainLayoutController.searchRecords[i]);
    }
    subTopicList.addAll(tList);
    isNormalLoading.value = false;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
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
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              ListView.separated(
                                padding: EdgeInsets.only(top: 12, bottom: 28, left: 20, right: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                reverse: false,
                                shrinkWrap: true,
                                itemCount: mainLayoutController.searchRecords.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 8,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return SearchResultCard(searchRecords: mainLayoutController.searchRecords, index: index);
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
          ),
        ),
      ),
    );
  }
}