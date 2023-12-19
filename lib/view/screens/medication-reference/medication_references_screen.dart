import 'package:flutter/material.dart';
import 'package:fogsi/controller/main-layout/main_layout_controller.dart';
import 'package:fogsi/controller/medication/medication_references_controller.dart';
import 'package:fogsi/model/response/medication_response.dart';
import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/utils/enum.dart';
import 'package:fogsi/utils/images.dart';
import 'package:fogsi/view/screens/medication-reference/medication_details_screen.dart';
import 'package:fogsi/view/widgets/alphabetical_scroll_view.dart';
import 'package:get/get.dart';

class MedicationReferenceScreen extends StatefulWidget {

  const MedicationReferenceScreen({Key? key}) : super(key: key);

  @override
  State<MedicationReferenceScreen> createState() => _MedicationReferenceScreenState();
}

class _MedicationReferenceScreenState extends State<MedicationReferenceScreen>{

  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());
  final MedicationReferenceController medicationReferenceController = Get.put(MedicationReferenceController());

  int selectedIndex = 0;
  List<MedicationRecords> list = <MedicationRecords>[];

  @override
  void initState(){
    super.initState();
    list = [];
    Future.delayed(Duration.zero, () async {
      await getAndPrefillData();
    });
    medicationReferenceController.getMedicationReferences();
  }

  Future<void> getAndPrefillData() async {
    await medicationReferenceController.getMedicationReferences();
    List<MedicationRecords> tList = [];
    for (int i = 0; i < medicationReferenceController.records.length; i++) {
      tList.add(medicationReferenceController.records[i]);
    }
    list.addAll(tList);
    setState(() {
      medicationReferenceController.pageIndex.value++;
    });
  }


  double calculateItemExtent(int listLength, double desiredHeight) {
    return desiredHeight / listLength;
  }


  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    double dynamicFontSize = (screenWidth < 345) ? screenWidth * 0.033 : 24;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24, bottom: 40),
            height: MediaQuery.of(context).size.width * 0.20,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Image.asset(
                    Images.medicationIcon,
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child:  Text(
                          "Medication",
                          style: TextStyle(
                            fontSize: dynamicFontSize,
                            fontWeight: FontWeight.w500,
                            color: tealColor,
                            fontFamily: 'Rubik',
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        child: Text(
                          "References",
                          style: TextStyle(
                            fontSize: dynamicFontSize,
                            fontWeight: FontWeight.w500,
                            color: tealColor,
                            fontFamily: 'Rubik',
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: AlphabetScrollView(
              list: list.map((e) => AlphaModel(e.medicineName ?? '')).toList(),
              alignment: LetterAlignment.right,
              itemExtent: 40,
              unselectedTextStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: tealColor
              ),
              selectedTextStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: tealColor
              ),
              overlayWidget: (value) => Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$value'.toUpperCase(),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
              itemBuilder: (_, k, id) {
                MedicationRecords selectedRecord = list[k];
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ListTile(
                    title: GestureDetector(
                      onTap: () {
                        mainLayoutController.stack.add(
                          MedicationDetailsScreen(records: selectedRecord),
                        );
                        mainLayoutController.indexStack.add(Screens.medicalDetails);
                      },
                      child: Text(
                        id,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),

                    textColor: menuTitleGrey,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

}