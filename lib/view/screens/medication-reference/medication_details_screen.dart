import 'package:flutter/material.dart';
import 'package:fogsi/controller/main-layout/main_layout_controller.dart';
import 'package:fogsi/model/response/medication_response.dart';
import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/utils/images.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MedicationDetailsScreen extends StatefulWidget {

  final MedicationRecords records;

  const MedicationDetailsScreen({
    super.key,
    required this.records
  });

  @override
  State<MedicationDetailsScreen> createState() => _MedicationDetailsScreenState();
}

class _MedicationDetailsScreenState extends State<MedicationDetailsScreen>{

  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());
  bool isDosageClosed = true;
  bool isIndicationClosed = true;
  bool isContraIndicationClosed = true;
  bool isSideEffectsClosed =  true;
  bool isWarningClosed = true;

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
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
                          mainLayoutController.indexStack.removeLast();
                          mainLayoutController.stack.removeLast();
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      alignment: Alignment.center,
                      child: Text(widget.records.medicineName ?? '', style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: tealColor,
                          fontFamily: 'Rubik',
                          overflow: TextOverflow.ellipsis),
                        maxLines: 2,),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  isDosageClosed ? isDosageClosed = false : isDosageClosed = true;
                  setState(() {

                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  margin: EdgeInsets.only(top: 28),
                  height: 60,
                  decoration: BoxDecoration(
                      color: isDosageClosed ? medReferenceBackground : pageProminent,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          child: Image.asset( isDosageClosed ? Images.closedArrowIcon : Images.openedArrowIcon, height: 12, width: 12,)
                      ),
                      Container(
                          child: Text("Dosage Forms & Strength",
                            style: TextStyle(
                                color: isDosageClosed ? menuTitleGrey : tealColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Rubik'
                            ),
                            maxLines: 1,
                          )
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 2, bottom: 2, right: 4),
                        child: Image.asset(isDosageClosed ? Images.pillsInActive : Images.pillsActive),
                      )
                    ],
                  ),
                ),
              ),
              if(!isDosageClosed)
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.only(left: 10,right: 10),
                  width: MediaQuery.of(context).size.width*0.95,
                  child: HtmlWidget(
                      widget.records.dosage ?? '<p>No data</p>'
                  ),
                ),
              GestureDetector(
                onTap: (){
                  isIndicationClosed ? isIndicationClosed = false : isIndicationClosed = true;
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  margin: EdgeInsets.only(top: 20),
                  height: 60,
                  decoration: BoxDecoration(
                      color: isIndicationClosed ? medReferenceBackground : pageProminent,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          child: Image.asset( isIndicationClosed ? Images.closedArrowIcon : Images.openedArrowIcon, height: 12, width: 12,)
                      ),
                      Container(
                          child: Text("Indications",
                            style: TextStyle(
                                color: isIndicationClosed ? menuTitleGrey : tealColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Rubik'
                            ),
                            maxLines: 1,
                          )
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 2, bottom: 2, right: 4),
                        child: Image.asset(isIndicationClosed ? Images.indicationInActive : Images.indicationActive),
                      )
                    ],
                  ),
                ),
              ),
              if(!isIndicationClosed)
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.only(left: 10,right: 10),
                  width: MediaQuery.of(context).size.width*0.95,
                  child: HtmlWidget(
                      widget.records.indication ?? '<p>No data</p>'
                  ),
                ),
              GestureDetector(
                onTap: (){
                  isContraIndicationClosed ? isContraIndicationClosed = false : isContraIndicationClosed = true;
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  margin: EdgeInsets.only(top: 20),
                  height: 60,
                  decoration: BoxDecoration(
                      color: isContraIndicationClosed ? medReferenceBackground : pageProminent,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          child: Image.asset( isContraIndicationClosed ? Images.closedArrowIcon : Images.openedArrowIcon, height: 12, width: 12,)
                      ),
                      Container(
                          child: Text("Contraindications",
                            style: TextStyle(
                                color: isContraIndicationClosed ? menuTitleGrey : tealColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Rubik'
                            ),
                            maxLines: 1,
                          )
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 2, bottom: 2, right: 4),
                        child: Image.asset(isContraIndicationClosed ? Images.contraIndicationInActive : Images.contraIndicationActive),
                      )
                    ],
                  ),
                ),
              ),
              if(!isContraIndicationClosed)
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.only(left: 10,right: 10),
                  width: MediaQuery.of(context).size.width*0.95,
                  child: HtmlWidget(
                      widget.records.contradiction ?? '<p>No data</p>'
                  ),
                ),
              GestureDetector(
                onTap: (){
                  isSideEffectsClosed ? isSideEffectsClosed = false : isSideEffectsClosed = true;
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  margin: EdgeInsets.only(top: 20),
                  height: 60,
                  decoration: BoxDecoration(
                      color: isSideEffectsClosed ? medReferenceBackground : pageProminent,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          child: Image.asset( isSideEffectsClosed ? Images.closedArrowIcon : Images.openedArrowIcon, height: 12, width: 12,)
                      ),
                      Container(
                          child: Text("Side Effects",
                            style: TextStyle(
                                color: isSideEffectsClosed ? menuTitleGrey : tealColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Rubik'
                            ),
                            maxLines: 1,
                          )
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 2, bottom: 2, right: 4),
                        child: Image.asset(isSideEffectsClosed ? Images.sideEffectInActive : Images.sideEffectsActive),
                      )
                    ],
                  ),
                ),
              ),
              if(!isSideEffectsClosed)
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.only(left: 10,right: 10),
                  width: MediaQuery.of(context).size.width*0.95,
                  child: HtmlWidget(
                      widget.records.sideEffects ?? '<p>No data</p>'
                  ),
                ),
              GestureDetector(
                onTap: (){
                  isWarningClosed ? isWarningClosed = false : isWarningClosed = true;
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  margin: EdgeInsets.only(top: 20),
                  height: 60,
                  decoration: BoxDecoration(
                      color: isWarningClosed ? medReferenceBackground : pageProminent,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          child: Image.asset( isWarningClosed ? Images.closedArrowIcon : Images.openedArrowIcon, height: 12, width: 12,)
                      ),
                      Container(
                          child: Text("Warnings",
                            style: TextStyle(
                                color: isWarningClosed ? menuTitleGrey : tealColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Rubik'
                            ),
                            maxLines: 1,
                          )
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 2, bottom: 2, right: 4),
                        child: Image.asset(isWarningClosed ? Images.warningInActive : Images.warningActive),
                      )
                    ],
                  ),
                ),
              ),
              if(!isWarningClosed)
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.only(left: 10,right: 10),
                  width: MediaQuery.of(context).size.width*0.95,
                  child: HtmlWidget(
                      widget.records.warnings ?? '<p>No data</p>'
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}