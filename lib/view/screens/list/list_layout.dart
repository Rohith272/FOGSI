import 'package:flutter/material.dart';
import 'package:fogsi/controller/list-layout/list_layout_controller.dart';
import 'package:fogsi/model/response/list_response.dart';
import 'package:fogsi/view/widgets/custom_loading_indicator.dart';
import 'package:fogsi/view/widgets/sub_topics_card.dart';
import 'package:get/get.dart';
import '../../../controller/main-layout/main_layout_controller.dart';
import '../../../utils/colors.dart';

class SubTopicScreen extends StatefulWidget {

  const SubTopicScreen({Key? key}) : super(key: key);

  @override
  State<SubTopicScreen> createState() => _SubTopicScreenState();
}

class _SubTopicScreenState extends State<SubTopicScreen>{

  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());
  final SubTopicListLayoutController subTopicLayoutController = Get.put(SubTopicListLayoutController());

  List<Records> subTopicList = <Records>[];
  final _scrollController = ScrollController();
  var isLoading = false.obs;
  var isNormalLoading = true.obs;

  @override
  void initState(){
    subTopicLayoutController.pageIndex.value = 1;
    super.initState();
    subTopicList = [];
    Future.delayed(Duration.zero, () async {
      await getAndPrefillData();
    });
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset == _scrollController.position.maxScrollExtent){
      _loadMoreVertical();
    }
  }

  Future _loadMoreVertical() async{
    isLoading.value = true;
    setState(() {});
    subTopicLayoutController.pageIndex.value = subTopicLayoutController.pageIndex.value ++;
    await subTopicLayoutController.getSubTopics(mainLayoutController.menuId.value.toInt());
    List<Records> tList = [];
    for (int i = 0; i < subTopicLayoutController.records.length; i++) {
      tList.add(subTopicLayoutController.records[i]);
    }
    subTopicList.addAll(tList);
    isLoading.value = false;
    setState(() {
      subTopicLayoutController.pageIndex.value++;
    });
  }

  Future<void> getAndPrefillData() async {
    await subTopicLayoutController.getSubTopics(mainLayoutController.menuId.value.toInt());
    List<Records> tList = [];
    for (int i = 0; i < subTopicLayoutController.records.length; i++) {
      tList.add(subTopicLayoutController.records[i]);
    }
    subTopicList.addAll(tList);
    isNormalLoading.value = false;
    setState(() {
      subTopicLayoutController.pageIndex.value++;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.teal, size: 29,),
                        onPressed: () {
                          mainLayoutController.setIndex(0, "", 0);
                          mainLayoutController.removeScreen();
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      alignment: Alignment.center,
                      child: Text(mainLayoutController.title.value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: tealColor, fontFamily: 'Rubik'),),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Obx(() {
                  if (isNormalLoading.value) {
                    return  Center(
                      child: SizedBox(
                        width: 40,
                        height: MediaQuery.of(context).size.height*0.8,
                        child: CustomLoadingIndicator(),
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
                            padding: const EdgeInsets.only(bottom: 20),
                            margin: EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  reverse: false,
                                  padding: const EdgeInsets.only(top: 20),
                                  shrinkWrap: true,
                                  itemCount: subTopicList.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return SubTopicCard(subTopicList: subTopicList, index: index);
                                  },
                                ),
                                Container(
                                  height: 60,
                                  child: isLoading.value ? CircularProgressIndicator() : Container(),
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
        ),
      ),
    );
  }

}