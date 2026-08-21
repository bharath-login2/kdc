import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kdc_chitty_mainnew/models/lead_management/callResultReasonModel.dart';
import 'package:lottie/lottie.dart';
import '../../core/common.dart';
import '../../models/lead_management/addLeadCommonDataModel.dart';
import '../../models/lead_management/addLeadFollowupModel.dart';
import '../../models/lead_management/leadSubTypeModel.dart';
import '../../screens/leadManagement/leadDetails.dart';
import '../../service/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../clients/addInvoice.dart';
import '../../widgets/leadDynamicFormWidget.dart';

// ignore: must_be_immutable
class AddFollowup extends StatefulWidget {
  String? token;
  bool editLead;
  bool deleteLead;
  bool cloudCall;
  String callMasterId;
  String? fromDate;
  String? toDate;
  String? status;
  String? category;
  String? staff;
  String? pageName;
  bool? isCalled;
  String? callingDate;
  String? callHistoryId;
  int? scrollToIndex;
  String? leadTypeId;
  String? leadType;
  String? leadSubTypeId;
  String? leadSubType;
  String? cost;
  String? address;
  String? searchKey;
  String? priority;
  String? priorityId;
  String? leadType1;
  String? job;
  String? location;
  String? customerNeed;
  String? purpose;
  String? challenges;
  String? newObjection;
  String? googleReviewStatus;
  String? reasonForLostSales;
  String? clientName;

  AddFollowup(
    this.token,
    this.editLead,
    this.deleteLead,
    this.cloudCall,
    this.callMasterId, {
    super.key,
    this.fromDate,
    this.toDate,
    this.status,
    this.category,
    this.staff,
    this.pageName,
    this.isCalled,
    this.callingDate,
    this.callHistoryId,
    this.scrollToIndex,
    this.leadTypeId,
    this.leadType,
    this.leadSubTypeId,
    this.leadSubType,
    this.cost,
    this.address,
    this.searchKey,
    this.priority,
    this.priorityId,
    this.leadType1,
    this.job,
    this.location,
    this.customerNeed,
    this.purpose,
    this.challenges,
    this.newObjection,
    this.googleReviewStatus,
    this.reasonForLostSales,
    this.clientName,
  });

  @override
  State<AddFollowup> createState() => _AddFollowupState();
}

class _AddFollowupState extends State<AddFollowup> {
  final GlobalKey<LeadDynamicFormWidgetState> leadFormKey = GlobalKey<LeadDynamicFormWidgetState>();
  LeadDynamicFormData currentFormData = LeadDynamicFormData();
  AddLeadCommonDataModel? commonDetails;
  LeadSubTypeModel? leadSubTypeList;
  CallResultResonModel? callResultReason;
  String callResult = 'Active';
  String callStatus = 'Select';
  String callResultId = '2';
  String callStatusId = '';
  String? nextFollowupDate = '';
  String leadType = 'Lead Category';
  String leadTypeId = '';
  String leadSubType = 'Lead Sub Category';
  String leadSubTypeId = '';
  String callResultReasonName = 'Reason';
  List<ColloctedStaff> filteredStaff = [];
  List<TargetGroup> filteredTargets = [];
  String callResultReasonId = '';
  TextEditingController cost = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController clientNameController = TextEditingController();
  TextEditingController calledDate1 = TextEditingController();
  TextEditingController nextFollowupDate1 = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController callResultVal = TextEditingController();
  TextEditingController callStatusVal = TextEditingController();
  TextEditingController leadTypeVal = TextEditingController();
  TextEditingController leadSubTypeVal = TextEditingController();
  TextEditingController priorityVal = TextEditingController();
  TextEditingController timeBefore = TextEditingController(text: '10');
  TextEditingController callReasonVal = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController customerNeed = TextEditingController();
  TextEditingController purpose = TextEditingController();
  TextEditingController challenges = TextEditingController();
  TextEditingController newObjection = TextEditingController();
  TextEditingController reasonForLostSales = TextEditingController();
  bool? result = true;
  bool? result1 = true;
  String? callHistoryId;
  String priority = 'Normal';
  String priorityId = '2';
  bool checked = false;
  bool addClient = false;
  bool isExpand = false;
  bool isChecked = false;
  bool googleReviewYes = false;
  bool googleReviewNo = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        result = true;
      });
    } else {
      setState(() {
        result = false;
      });
    }
    if (widget.token == null || widget.token!.isEmpty) {
      widget.token = await Common.getSharedPref("token");
    }
    if (widget.clientName != null && widget.clientName!.isNotEmpty) {
      clientNameController.text = widget.clientName!;
    }
    commonDetails = await HttpService.addLeadCommonData(widget.token);
    if (commonDetails != null && commonDetails!.data != null) {
      if (commonDetails!.data!.colloctedStaff != null &&
          commonDetails!.data!.colloctedStaff!.isNotEmpty) {
        filteredStaff.addAll(commonDetails!.data!.colloctedStaff!);
      }
      if (commonDetails!.data!.targetGroups != null &&
          commonDetails!.data!.targetGroups!.isNotEmpty) {
        filteredTargets.addAll(commonDetails!.data!.targetGroups!);
      }
      callResultReasonList();
      if (widget.leadTypeId != '') {
        leadSubTypeList = await HttpService.leadSubType(widget.leadTypeId);
        if (widget.leadType != null) {
          leadType = widget.leadType.toString();
          leadTypeId = widget.leadTypeId.toString();
        }
        if (widget.leadSubType != null) {
          leadSubType = widget.leadSubType.toString();
          leadSubTypeId = widget.leadSubTypeId.toString();
        }
        if (widget.cost != null) {
          cost.text = widget.cost.toString();
        }
        if (widget.address != null) {
          address.text = widget.address.toString();
        }

        if (widget.job != null) {
          job.text = widget.job.toString();
        }
        if (widget.location != null) {
          location.text = widget.location.toString();
        }
        if (widget.customerNeed != null) {
          customerNeed.text = widget.customerNeed.toString();
        }
        if (widget.purpose != null) {
          purpose.text = widget.purpose.toString();
        }
        if (widget.challenges != null) {
          challenges.text = widget.challenges.toString();
        }
        if (widget.newObjection != null) {
          newObjection.text = widget.newObjection.toString();
        }
        if (widget.reasonForLostSales != null) {
          reasonForLostSales.text = widget.reasonForLostSales.toString();
        }
        if (widget.googleReviewStatus != null) {
          if (widget.googleReviewStatus == 'true' ||
              widget.googleReviewStatus == 'Yes') {
            googleReviewYes = true;
            googleReviewNo = false;
          } else if (widget.googleReviewStatus == 'false' ||
              widget.googleReviewStatus == 'No') {
            googleReviewYes = false;
            googleReviewNo = true;
          }
        }
        if (widget.priority != null) {
          priority = widget.priority.toString();
          priorityId = widget.priorityId.toString();
        }

        setState(() {});
      }
      setState(() {});
    }
  }

  callResultReasonList() async {
    callResultReason = await HttpService.callResultReasonList(
      widget.token!,
      callResultId,
    );
    if (commonDetails != null) {
      setState(() {});
    }
  }

  String getYmdFromDmy(String dmy) {
    if (dmy.isEmpty) return dmy;
    final split = dmy.split("-");
    return "${split[2]}-${split[1]}-${split[0]}";
  }

  List<Map<String, String>> getLeadCategoryOptions() {
    List<Map<String, String>> categories = [];
    if (commonDetails?.data?.leadCategory != null) {
      for (var item in commonDetails!.data!.leadCategory!) {
        if (item.leadCategory != null && item.leadCategoryId != null) {
          categories.add({
            'id': item.leadCategoryId.toString(),
            'name': item.leadCategory.toString(),
          });
        }
      }
    }
    if (commonDetails?.data?.callResult != null) {
      for (var item in commonDetails!.data!.callResult!) {
        if (item.callResult != null && item.callResultId != null) {
          final idStr = item.callResultId.toString();
          if (!categories.any((c) => c['id'] == idStr)) {
            categories.add({
              'id': idStr,
              'name': item.callResult.toString(),
            });
          }
        }
      }
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    callResultVal.text = callResult;
    callStatusVal.text = callStatus;
    callReasonVal.text = callResultReasonName;
    leadTypeVal.text = leadType;
    leadSubTypeVal.text = leadSubType;
    priorityVal.text = priority;
    if (widget.callHistoryId != null) {
      callHistoryId = widget.callHistoryId.toString();
    } else {
      callHistoryId = '';
    }
    if (widget.callingDate != null) {
      calledDate1.text = DateFormat(
        'dd-MM-yyyy HH:mm',
      ).format(DateTime.parse(widget.callingDate.toString()));
    } else {
      calledDate1.text = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    }

    return result == true
        ? WillPopScope(
            onWillPop: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeadDetails(
                    widget.token!,
                    widget.editLead,
                    widget.deleteLead,
                    widget.cloudCall,
                    widget.callMasterId,
                    pageName: widget.pageName,
                    fromDate: widget.fromDate,
                    toDate: widget.toDate,
                    status: widget.status,
                    category: widget.category,
                    staff: widget.staff,
                    isCalled: widget.isCalled,
                    searchKey: widget.searchKey,
                    scrollToIndex: widget.scrollToIndex,
                    leadType: widget.leadType1,
                  ),
                ),
              );
              return true;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                  MediaQuery.of(context).size.height * 0.08,
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2a86c9), Color(0xFF406dbe)],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 10.0,
                      bottom: 10.0,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LeadDetails(
                                      widget.token!,
                                      widget.editLead,
                                      widget.deleteLead,
                                      widget.cloudCall,
                                      widget.callMasterId,
                                      pageName: widget.pageName,
                                      fromDate: widget.fromDate,
                                      toDate: widget.toDate,
                                      status: widget.status,
                                      category: widget.category,
                                      staff: widget.staff,
                                      isCalled: widget.isCalled,
                                      searchKey: widget.searchKey,
                                      scrollToIndex: widget.scrollToIndex,
                                      leadType: widget.leadType1,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 25),
                            const Text(
                              'Add Followup',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: commonDetails != null
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: clientNameController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  top: 2,
                                  bottom: 2,
                                ),
                                labelText: 'Name *',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: calledDate1,
                              readOnly: true,
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((selectedTime) {
                                      String newDate = selectedDate.toString();
                                      newDate = newDate.substring(
                                        0,
                                        newDate.indexOf(" "),
                                      );
                                      String convertedNewDate = getYmdFromDmy(
                                        newDate,
                                      );
                                      if (selectedTime != null) {
                                        calledDate1.text =
                                            "$convertedNewDate ${selectedTime.format(context)}";
                                      } else {}
                                    });
                                  }
                                });
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  top: 2,
                                  bottom: 2,
                                ),
                                labelText: 'Called Date',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.calendar_month_sharp,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 15),

                             // Lead Category (read-only field populated from Lead Details)
                             TextFormField(
                               controller: TextEditingController(
                                 text: (leadType.isEmpty || leadType == 'Lead Category')
                                     ? ''
                                     : leadType,
                               ),
                               readOnly: true,
                               style: const TextStyle(color: Colors.black),
                               decoration: const InputDecoration(
                                 contentPadding: EdgeInsets.only(
                                   left: 10,
                                   top: 2,
                                   bottom: 2,
                                 ),
                                 labelText: 'Lead Category',
                                 fillColor: Colors.white,
                                 filled: true,
                                 prefixIcon: Icon(
                                   Icons.category_outlined,
                                   color: Colors.grey,
                                 ),
                                 border: OutlineInputBorder(),
                                 focusedBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.grey),
                                 ),
                                 labelStyle: TextStyle(color: Colors.grey),
                               ),
                             ),
                             const SizedBox(height: 15),
                            LeadDynamicFormWidget(
                              key: leadFormKey,
                              token: widget.token!,
                              commonDetails: commonDetails,
                              onChanged: (formData) {
                                setState(() {
                                  currentFormData = formData;
                                  callResultId = formData.callStatusId ?? '';
                                  callStatusId = formData.callStatusReasonId ?? '';
                                  callResultReasonId = formData.callStatusReasonId ?? '';
                                });
                              },
                            ),
                            
                            const SizedBox(height: 15),
                            if (callResultId == '4' &&
                                commonDetails!.data!.customerAddPermission ==
                                    true)
                              CheckboxListTile(
                                title: const Text('Add Client'),
                                value: addClient,
                                onChanged: (bool? value) {
                                  setState(() {
                                    addClient = value!;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            if (callResultId == '2')
                              TextFormField(
                                controller: nextFollowupDate1,
                                readOnly: true,
                                onTap: () async {
                                  await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((selectedTime) {
                                        String newDate = selectedDate
                                            .toString();
                                        newDate = newDate.substring(
                                          0,
                                          newDate.indexOf(" "),
                                        );
                                        String convertedNewDate = getYmdFromDmy(
                                          newDate,
                                        );
                                        if (selectedTime != null) {
                                          DateTime selectedDateTime = DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day,
                                            selectedTime.hour,
                                            selectedTime.minute,
                                          );
                                          if (selectedDateTime.isBefore(
                                            DateTime.now(),
                                          )) {
                                            Common.toastMessaage(
                                              "Cannot select past time",
                                              Colors.red,
                                            );
                                          } else {
                                            nextFollowupDate1.text =
                                                  "$convertedNewDate ${selectedTime.format(context)}";
                                          }
                                        } else {}
                                      });
                                    }
                                  });
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  labelText: 'Reschedule Date & Time',
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.calendar_month_sharp,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            if (callResultId == '2') const SizedBox(height: 10),
                            if (callResultId == '2')
                              Row(
                                children: [
                                  SizedBox(
                                    width: 230,
                                    child: CheckboxListTile(
                                      title: const Text(
                                        "Remind Me Before",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: checked,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checked = newValue!;
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  ),
                                  if (checked == true)
                                    SizedBox(
                                      width: 90,
                                      child: Container(
                                        width: 80,
                                        foregroundDecoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5.0,
                                          ),
                                          border: Border.all(
                                            color: Colors.blueGrey,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(8.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5.0,
                                                        ),
                                                  ),
                                                ),
                                                controller: timeBefore,
                                                keyboardType:
                                                    const TextInputType.numberWithOptions(
                                                      decimal: false,
                                                      signed: true,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 38.0,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                        ),
                                                    child: InkWell(
                                                      child: const Icon(
                                                        Icons.arrow_drop_up,
                                                        size: 18.0,
                                                      ),
                                                      onTap: () {
                                                        int currentValue =
                                                            int.parse(
                                                              timeBefore.text,
                                                            );
                                                        setState(() {
                                                          currentValue++;
                                                          timeBefore.text =
                                                              (currentValue)
                                                                  .toString();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  InkWell(
                                                    child: const Icon(
                                                      Icons.arrow_drop_down,
                                                      size: 18.0,
                                                    ),
                                                    onTap: () {
                                                      int currentValue =
                                                          int.parse(
                                                            timeBefore.text,
                                                          );
                                                      setState(() {
                                                        currentValue--;
                                                        timeBefore.text =
                                                            (currentValue > 0
                                                                    ? currentValue
                                                                    : 0)
                                                                .toString();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            if (checked == true) const SizedBox(height: 10),
                            SizedBox(
                              height: 30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    commonDetails!.data!.callResponse!.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 10,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          remarks.text = commonDetails!
                                              .data!
                                              .callResponse![i]
                                              .toString();
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 0,
                                          ),
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(6),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                              ),
                                              child: Text(
                                                commonDetails!
                                                    .data!
                                                    .callResponse![i]
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Color(0xFF717171),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: remarks,
                              maxLines: 2,
                              decoration: const InputDecoration(
                                labelText: 'Remarks',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            // const SizedBox(height: 15),
                            // Priority and Address in same row
                            Row(
                              children: [
                                // Expanded(
                                //   child: TextFormField(
                                //     controller: cost,
                                //     keyboardType: TextInputType.number,
                                //     decoration: const InputDecoration(
                                //       contentPadding: EdgeInsets.only(
                                //         left: 10,
                                //         top: 2,
                                //         bottom: 2,
                                //       ),
                                //       labelText: 'Cost',
                                //       fillColor: Colors.white,
                                //       filled: true,
                                //       prefixIcon: Icon(
                                //         Icons.currency_rupee,
                                //         color: Colors.grey,
                                //       ),
                                //       border: OutlineInputBorder(),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(
                                //           color: Colors.grey,
                                //         ),
                                //       ),
                                //       labelStyle: TextStyle(color: Colors.grey),
                                //     ),
                                //   ),
                                // ),
                                //  const SizedBox(width: 10),
                                // Expanded(
                                //   child: TextFormField(
                                //     controller: address,
                                //     decoration: const InputDecoration(
                                //       labelText: 'Address',
                                //       fillColor: Colors.white,
                                //       filled: true,
                                //       prefixIcon: Icon(
                                //         Icons.location_on_outlined,
                                //         color: Colors.grey,
                                //       ),
                                //       border: OutlineInputBorder(),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(
                                //           color: Colors.grey,
                                //         ),
                                //       ),
                                //       labelStyle: TextStyle(color: Colors.grey),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 25),

                             // Priority in single field
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 const Padding(
                                   padding: EdgeInsets.only(
                                     left: 4,
                                     bottom: 4,
                                   ),
                                   child: Text(
                                     'Possibility',
                                     style: TextStyle(
                                       fontSize: 11,
                                       color: Colors.grey,
                                       fontWeight: FontWeight.w500,
                                     ),
                                   ),
                                 ),
                                 TextFormField(
                                        controller: priorityVal,
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                scrollable: true,
                                                title: const Text('Priority'),
                                                content: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: commonDetails!
                                                      .data!
                                                      .priority!
                                                      .length,
                                                  itemBuilder: (context, ind) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          priority =
                                                              commonDetails!
                                                                  .data!
                                                                  .priority![ind]
                                                                  .priority
                                                                  .toString();
                                                          priorityId =
                                                              commonDetails!
                                                                  .data!
                                                                  .priority![ind]
                                                                  .priorityId
                                                                  .toString();
                                                          Navigator.pop(
                                                            context,
                                                            true,
                                                          );
                                                        });
                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: Text(
                                                          commonDetails!
                                                              .data!
                                                              .priority![ind]
                                                              .priority
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 18,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        maxLines: 1,
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 10,
                                            top: 12,
                                            bottom: 12,
                                          ),
                                          // REMOVED: labelText and labelStyle
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            color: Colors.grey,
                                          ),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 15),

                            // Lead Sub Category (appears only when available)
                            if (leadSubTypeList != null &&
                                leadSubTypeList!.data!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 4,
                                        bottom: 4,
                                      ),
                                      child: Text(
                                        'Lead Sub Category',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: leadSubTypeVal,
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              scrollable: true,
                                              title: const Text(
                                                'Lead Sub Category',
                                              ),
                                              content: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: leadSubTypeList!
                                                    .data!
                                                    .length,
                                                itemBuilder: (context, subIndex) {
                                                  return InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        leadSubType =
                                                            leadSubTypeList!
                                                                .data![subIndex]
                                                                .leadSubCategory
                                                                .toString();
                                                        leadSubTypeId =
                                                            leadSubTypeList!
                                                                .data![subIndex]
                                                                .leadSubCategoryId
                                                                .toString();
                                                        Navigator.pop(
                                                          context,
                                                          true,
                                                        );
                                                      });
                                                    },
                                                    child: SizedBox(
                                                      height: 50,
                                                      child: Text(
                                                        leadSubTypeList!
                                                            .data![subIndex]
                                                            .leadSubCategory
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      maxLines: 1,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 10,
                                          top: 12,
                                          bottom: 12,
                                        ),
                                        // REMOVED: labelText and labelStyle
                                        fillColor: Colors.white,
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.arrow_drop_down_circle_outlined,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Job and Location in same row
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           const Padding(
                            //             padding: EdgeInsets.only(
                            //               left: 4,
                            //               bottom: 4,
                            //             ),
                            //             child: Text(
                            //               'Job',
                            //               style: TextStyle(
                            //                 fontSize: 12,
                            //                 color: Colors.grey,
                            //                 fontWeight: FontWeight.w500,
                            //               ),
                            //             ),
                            //           ),
                            //           TextFormField(
                            //             controller: job,
                            //             decoration: const InputDecoration(
                            //               contentPadding: EdgeInsets.only(
                            //                 left: 10,
                            //                 top: 12,
                            //                 bottom: 12,
                            //               ),
                            //               fillColor: Colors.white,
                            //               filled: true,
                            //               // prefixIcon: Icon(
                            //               //   Icons.work_outline,
                            //               //   color: Colors.grey,
                            //               // ),
                            //               border: OutlineInputBorder(),
                            //               focusedBorder: OutlineInputBorder(
                            //                 borderSide: BorderSide(
                            //                   color: Colors.grey,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           const Padding(
                            //             padding: EdgeInsets.only(
                            //               left: 4,
                            //               bottom: 4,
                            //             ),
                            //             child: Text(
                            //               'Location',
                            //               style: TextStyle(
                            //                 fontSize: 12,
                            //                 color: Colors.grey,
                            //                 fontWeight: FontWeight.w500,
                            //               ),
                            //             ),
                            //           ),
                            //           TextFormField(
                            //             controller: location,
                            //             decoration: const InputDecoration(
                            //               contentPadding: EdgeInsets.only(
                            //                 left: 10,
                            //                 top: 12,
                            //                 bottom: 12,
                            //               ),

                            //               fillColor: Colors.white,
                            //               filled: true,
                            //               // prefixIcon: Icon(
                            //               //   Icons.location_on_outlined,
                            //               //   color: Colors.grey,
                            //               // ),
                            //               border: OutlineInputBorder(),
                            //               focusedBorder: OutlineInputBorder(
                            //                 borderSide: BorderSide(
                            //                   color: Colors.grey,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 15),

                            // Customer Need and Purpose in same row
                            Row(
                              children: [
                                // Expanded(
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       const Padding(
                                //         padding: EdgeInsets.only(
                                //           left: 4,
                                //           bottom: 4,
                                //         ),
                                //         child: Text(
                                //           'Customer Need & Purpose',
                                //           style: TextStyle(
                                //             fontSize: 12,
                                //             color: Colors.grey,
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //         ),
                                //       ),
                                //       TextFormField(
                                //         controller: customerNeed,
                                //         decoration: const InputDecoration(
                                //           contentPadding: EdgeInsets.only(
                                //             left: 10,
                                //             top: 12,
                                //             bottom: 12,
                                //           ),

                                //           fillColor: Colors.white,
                                //           filled: true,
                                //           // prefixIcon: Icon(
                                //           //   Icons.person_outline,
                                //           //   color: Colors.grey,
                                //           // ),
                                //           border: OutlineInputBorder(),
                                //           focusedBorder: OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //               color: Colors.grey,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // const SizedBox(width: 10),
                                // Expanded(
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       const Padding(
                                //         padding: EdgeInsets.only(
                                //           left: 4,
                                //           bottom: 4,
                                //         ),
                                //         child: Text(
                                //           'Challenges',
                                //           style: TextStyle(
                                //             fontSize: 12,
                                //             color: Colors.grey,
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //         ),
                                //       ),
                                //       TextFormField(
                                //         controller: challenges,
                                //         decoration: const InputDecoration(
                                //           contentPadding: EdgeInsets.only(
                                //             left: 10,
                                //             top: 12,
                                //             bottom: 12,
                                //           ),

                                //           fillColor: Colors.white,
                                //           filled: true,
                                //           // prefixIcon: Icon(
                                //           //   Icons.warning_outlined,
                                //           //   color: Colors.grey,
                                //           // ),
                                //           border: OutlineInputBorder(),
                                //           focusedBorder: OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //               color: Colors.grey,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                
                                // Expanded(
                                //   child: TextFormField(
                                //     controller: purpose,
                                //     decoration: const InputDecoration(
                                //       labelText: 'Purpose',
                                //       fillColor: Colors.white,
                                //       filled: true,
                                //       prefixIcon: Icon(
                                //         Icons.flag_outlined,
                                //         color: Colors.grey,
                                //       ),
                                //       border: OutlineInputBorder(),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(
                                //           color: Colors.grey,
                                //         ),
                                //       ),
                                //       labelStyle: TextStyle(color: Colors.grey),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // Challenges and New Objection in same row
                            Row(
                              children: [
                                // Expanded(
                                //   child: TextFormField(
                                //     controller: challenges,
                                //     decoration: const InputDecoration(
                                //       labelText: 'Challenges',
                                //       fillColor: Colors.white,
                                //       filled: true,
                                //       prefixIcon: Icon(
                                //         Icons.warning_outlined,
                                //         color: Colors.grey,
                                //       ),
                                //       border: OutlineInputBorder(),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(
                                //           color: Colors.grey,
                                //         ),
                                //       ),
                                //       labelStyle: TextStyle(color: Colors.grey),
                                //     ),
                                //   ),
                                // ),
                                //  const SizedBox(width: 10),
                                // Expanded(
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       const Padding(
                                //         padding: EdgeInsets.only(
                                //           left: 4,
                                //           bottom: 4,
                                //         ),
                                //         child: Text(
                                //           'New Objection',
                                //           style: TextStyle(
                                //             fontSize: 12,
                                //             color: Colors.grey,
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //         ),
                                //       ),
                                //       TextFormField(
                                //         controller: newObjection,
                                //         decoration: const InputDecoration(
                                //           contentPadding: EdgeInsets.only(
                                //             left: 10,
                                //             top: 12,
                                //             bottom: 12,
                                //           ),

                                //           fillColor: Colors.white,
                                //           filled: true,
                                //           // prefixIcon: Icon(
                                //           //   Icons.block_outlined,
                                //           //   color: Colors.grey,
                                //           // ),
                                //           border: OutlineInputBorder(),
                                //           focusedBorder: OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //               color: Colors.grey,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // Google Review (Yes/No)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Request Status for Google Review',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RadioListTile(
                                          title: const Text('Yes'),
                                          value: true,
                                          groupValue: googleReviewYes
                                              ? true
                                              : googleReviewNo
                                              ? false
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              googleReviewYes = true;
                                              googleReviewNo = false;
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile(
                                          title: const Text('No'),
                                          value: false,
                                          groupValue: googleReviewYes
                                              ? true
                                              : googleReviewNo
                                              ? false
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              googleReviewYes = false;
                                              googleReviewNo = true;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Reason for Lost Sales
                            TextFormField(
                              controller: reasonForLostSales,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Enter customer feed back',
                                fillColor: Colors.white,
                                filled: true,
                                // prefixIcon: Icon(
                                //   Icons.description_outlined,
                                //   color: Colors.grey,
                                // ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Submit Button
                            InkWell(
                              onTap: () async {
                                final connectivityResult = await (Connectivity()
                                    .checkConnectivity());
                                if (connectivityResult ==
                                        ConnectivityResult.mobile ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {
                                  if (leadTypeId.isEmpty || leadType.isEmpty || leadType == 'Lead Category') {
                                    Common.toastMessaage('Please select Lead Category', Colors.red);
                                    return;
                                  }
                                  if (leadFormKey.currentState != null && !leadFormKey.currentState!.validate()) {
                                    return;
                                  }
                                  if (callResultId == '2' && nextFollowupDate1.text.isEmpty) {
                                    Common.toastMessaage(
                                      'Choose next followup date',
                                      Colors.red,
                                    );
                                  } else {
                                    if (context.mounted) {
                                      Common.showProgressDialog(
                                        context,
                                        "Loading..",
                                      );
                                    }

                                    Map<String, dynamic> extraDynamicFields = {
                                      'connecting_channel_id': currentFormData.connectingChannelId,
                                      'connecting_channel_name': currentFormData.connectingChannelName,
                                      'connecting_status_id': currentFormData.connectingStatusId,
                                      'connecting_status_name': currentFormData.connectingStatusName,
                                      'connecting_reason_id': currentFormData.connectingReasonId,
                                      'connecting_reason_name': currentFormData.connectingReasonName,
                                      'connecting_reason_type': currentFormData.connectingReasonType,
                                      'lead_status': currentFormData.leadStatus,
                                      'rejection_category_ids': jsonEncode(currentFormData.rejectionCategoryIds),
                                      'rejection_category_reasons': jsonEncode(currentFormData.rejectionCategoryReasons),
                                      'tried_to_reduce_rejection': currentFormData.triedToReduceRejection,
                                      'reduce_rejection_method_ids': jsonEncode(currentFormData.reduceRejectionMethodIds),
                                      'reduction_challenges': currentFormData.reductionChallenges,
                                      'rejection_to_relation': currentFormData.rejectionToRelation,
                                      'relation_action_ids': jsonEncode(currentFormData.relationActionIds),
                                      'relation_challenges': currentFormData.relationChallenges,
                                      'prospect_qualified': currentFormData.prospectQualified,
                                      'prospect_parameter_ids': jsonEncode(currentFormData.prospectParameterIds),
                                      'prospect_purpose': currentFormData.sharedPurpose,
                                      'prospect_pain_point': currentFormData.sharedPainPoint,
                                      'prospect_challenges': currentFormData.prospectChallenges,
                                      'product_customization': currentFormData.productCustomization,
                                      'customization_parameter_ids': jsonEncode(currentFormData.customizationParameterIds),
                                      'customization_challenges': currentFormData.customizationChallenges,
                                      'customer_summary': currentFormData.customerSummary,
                                      'customer_challenges': currentFormData.customerChallenges,
                                      'customer_rating': currentFormData.customerRating,
                                    };

                                    AddLeadFollowupModel? object1 =
                                        await HttpService.addLeadsFollowup(
                                          widget.token,
                                          callResultId,
                                          callStatusId,
                                          nextFollowupDate1.text,
                                          cost.text,
                                          address.text,
                                          leadTypeId,
                                          leadSubTypeId,
                                          remarks.text,
                                          widget.callMasterId,
                                          calledDate1.text,
                                          callHistoryId,
                                          callResultReasonId,
                                          priorityId,
                                          checked,
                                          timeBefore.text,
                                          addClient,
                                          job.text,
                                          location.text,
                                          customerNeed.text,
                                          purpose.text,
                                          challenges.text,
                                          newObjection.text,
                                          googleReviewYes
                                              ? 'Yes'
                                              : googleReviewNo
                                              ? 'No'
                                              : '',
                                          reasonForLostSales.text,
                                          dynamicFormData: extraDynamicFields,
                                        );
                                    if (object1!.status == true) {
                                      Common.toastMessaage(
                                        object1.message,
                                        Colors.green,
                                      );
                                      if (context.mounted) {
                                        if (object1.data != '' &&
                                            commonDetails!
                                                    .data!
                                                    .customerAddPermission ==
                                                true &&
                                            commonDetails!
                                                    .data!
                                                    .customerAddInvoicePermission ==
                                                true) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddInvoice(
                                                widget.token!,
                                                object1.data!,
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LeadDetails(
                                                widget.token!,
                                                widget.editLead,
                                                widget.deleteLead,
                                                widget.cloudCall,
                                                widget.callMasterId,
                                                pageName: widget.pageName,
                                                status: widget.status,
                                                staff: widget.staff,
                                                isCalled: widget.isCalled,
                                                fromDate: widget.fromDate,
                                                toDate: widget.toDate,
                                                category: widget.category,
                                                scrollToIndex:
                                                    widget.scrollToIndex,
                                                searchKey: widget.searchKey,
                                                leadType: widget.leadType1,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    } else {
                                      Common.toastMessaage(
                                        object1.message,
                                        Colors.red,
                                      );
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  }
                                } else {
                                  setState(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'No Network Found..Try Again Later..',
                                        ),
                                        backgroundColor: Colors.redAccent,
                                        elevation: 10,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(10),
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Lottie.asset(
                        'assets/main/loading.json',
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/noNetwork.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text(
                    'No Network Found !',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      getData();
                    },
                    child: SizedBox(
                      width: 120,
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              'Try Again',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
