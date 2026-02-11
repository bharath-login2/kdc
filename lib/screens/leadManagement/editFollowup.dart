import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';
import '../../core/common.dart';
import '../../models/lead_management/addLeadCommonDataModel.dart';
import '../../models/lead_management/editLeadFollowupModel.dart';
import '../../models/lead_management/followupDetailsModel.dart';
import '../../models/lead_management/leadSubTypeModel.dart';
import '../../screens/leadManagement/leadDetails.dart';
import '../../service/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/inputTextFeildWidget.dart';

// ignore: must_be_immutable
class EditFollowup extends StatefulWidget {
  String? token;
  bool editLead;
  bool deleteLead;
  bool cloudCall;
  String callMasterId;
  String callFollowupId;

  String? fromDate;
  String? toDate;
  String? status;
  String? category;
  String? staff;
  String? pageName;
  bool? isCalled;
  int? scrollToIndex;

  EditFollowup(
    this.token,
    this.editLead,
    this.deleteLead,
    this.cloudCall,
    this.callMasterId,
    this.callFollowupId, {
    super.key,
    this.fromDate,
    this.toDate,
    this.status,
    this.category,
    this.staff,
    this.pageName,
    this.isCalled,
    this.scrollToIndex,
  });

  @override
  State<EditFollowup> createState() => _EditFollowupState();
}

class _EditFollowupState extends State<EditFollowup> {
  AddLeadCommonDataModel? commonDetails;
  LeadSubTypeModel? leadSubTypeList;
  String callResult = 'New';
  String callResultId = '1';
  String leadType = 'Customer Interested Product';
  String leadTypeId = '';
  String leadSubType = 'Lead Sub Category';
  String leadSubTypeId = '';
  TextEditingController cost = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController customerNeed = TextEditingController();
  TextEditingController purpose = TextEditingController();
  TextEditingController challenges = TextEditingController();
  TextEditingController newObjection = TextEditingController();
  TextEditingController reasonForLostSales = TextEditingController();

  bool? result = true;
  bool? result1 = true;
  bool googleReviewYes = false;
  bool googleReviewNo = false;
  String priority = 'Normal';
  String priorityId = '2';

  FollowupDetailsModel? followupDetails;
  TextEditingController calledDate1 = TextEditingController();
  TextEditingController nextFollowupDate1 = TextEditingController();
  TextEditingController leadTypeVal = TextEditingController();
  TextEditingController leadSubTypeVal = TextEditingController();
  TextEditingController callResultVal = TextEditingController();
  TextEditingController priorityVal = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  String getYmdFromDmy(String dmy) {
    if (dmy.isEmpty) return dmy;
    final split = dmy.split("-");
    return "${split[2]}-${split[1]}-${split[0]}";
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
    commonDetails = await HttpService.addLeadCommonData(widget.token);
    followupDetails = await HttpService.followupDetails(
      widget.token,
      widget.callFollowupId,
    );

    if (followupDetails != null && followupDetails!.data != null) {
      if (followupDetails!.data!.leadCategoryId.toString() != '') {
        leadSubTypeList = await HttpService.leadSubType(
          followupDetails!.data!.leadCategoryId.toString(),
        );
      }

      setState(() {
        // Populate all fields from followupDetails
        callResult = followupDetails!.data!.callResult.toString();
        callResultId = followupDetails!.data!.callResultId.toString();

        calledDate1.text = DateFormat(
          'dd-MM-yyyy HH:mm',
        ).format(DateTime.parse(followupDetails!.data!.calledDate.toString()));

        if (followupDetails!.data!.followupDate != null &&
            followupDetails!.data!.followupDate!.isNotEmpty) {
          nextFollowupDate1.text = DateFormat('dd-MM-yyyy HH:mm').format(
            DateTime.parse(followupDetails!.data!.followupDate.toString()),
          );
        }

        leadType = followupDetails!.data!.leadCategory.toString();
        leadTypeId = followupDetails!.data!.leadCategoryId.toString();

        cost.text = followupDetails!.data!.cost?.toString() ?? '';
        remarks.text = followupDetails!.data!.remarks?.toString() ?? '';
        address.text =  followupDetails!.data!.address?.toString() ?? '';

        leadSubType = followupDetails!.data!.leadSubCategory.toString();
        leadSubTypeId = followupDetails!.data!.leadSubCategoryId.toString();

        // New fields
        job.text = followupDetails!.data!.job?.toString() ?? '';
        location.text = followupDetails!.data!.location?.toString() ?? '';
        customerNeed.text =
            followupDetails!.data!.customerNeed?.toString() ?? '';
        purpose.text = followupDetails!.data!.purpose?.toString() ?? '';
        challenges.text = followupDetails!.data!.challenges?.toString() ?? '';
        newObjection.text =
            followupDetails!.data!.newObjection?.toString() ?? '';
        reasonForLostSales.text =
            followupDetails!.data!.reasonForLostSales?.toString() ?? '';

        String googleReview =
            followupDetails!.data!.googleReviewStatus?.toString() ?? '';
        if (googleReview == 'true') {
          googleReviewYes = true;
          googleReviewNo = false;
        } else if (googleReview == 'false') {
          googleReviewYes = false;
          googleReviewNo = true;
        }

        // Set controller values for display
        leadTypeVal.text = followupDetails!.data!.leadCategory.toString();
        leadSubTypeVal.text = followupDetails!.data!.leadSubCategory.toString();
        callResultVal.text = followupDetails!.data!.callResult.toString();
        priorityVal.text = priority; // You might need to get this from API
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return result == true
        ? Scaffold(
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
                              Navigator.of(context).pop();
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
                            'Edit Followup',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: commonDetails != null && followupDetails != null
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Called Date
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
                            style: const TextStyle(color: Colors.black),
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

                          // Lead Status
                          TextFormField(
                            controller: callResultVal,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: const Text('Status'),
                                    content: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: commonDetails!
                                          .data!
                                          .callResult!
                                          .length,
                                      itemBuilder: (context, ind) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              callResultVal.text =
                                                  commonDetails!
                                                      .data!
                                                      .callResult![ind]
                                                      .callResult
                                                      .toString();
                                              callResult = commonDetails!
                                                  .data!
                                                  .callResult![ind]
                                                  .callResult
                                                  .toString();

                                              callResultId = commonDetails!
                                                  .data!
                                                  .callResult![ind]
                                                  .callResultId
                                                  .toString();
                                              if (callResultId != '2') {
                                                nextFollowupDate1.text = '';
                                              }
                                              Navigator.pop(context, true);
                                            });
                                          },
                                          child: SizedBox(
                                            height: 50,
                                            child: Text(
                                              commonDetails!
                                                  .data!
                                                  .callResult![ind]
                                                  .callResult
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
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                top: 2,
                                bottom: 2,
                              ),
                              labelText: 'Lead Status',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.arrow_drop_down_circle_outlined,
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

                          // Next Followup Date (only when callResultId is '2')
                          callResultId == '2'
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
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
                                            String convertedNewDate =
                                                getYmdFromDmy(newDate);
                                            if (selectedTime != null) {
                                              nextFollowupDate1.text =
                                                  "$convertedNewDate ${selectedTime.format(context)}";
                                            } else {}
                                          });
                                        }
                                      });
                                    },
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 2,
                                        bottom: 2,
                                      ),
                                      labelText: 'Next Followup Date',
                                      fillColor: Colors.white,
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.calendar_month_sharp,
                                        color: Colors.grey,
                                      ),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                )
                              : const SizedBox(),

                          // Remarks
                          const SizedBox(height: 15),
                          InputTextField(
                            hintText: 'Remarks',
                            hintTextColor: Colors.white,
                            backgroundColor: Colors.white,
                            controller: remarks,
                            width: 1,
                            height: 80,
                            maxLine: 3,
                          ),
                          const SizedBox(height: 15),

                          // Address and Cost in same row
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: address,
                                  decoration: const InputDecoration(
                                    labelText: 'Address',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              // const SizedBox(width: 10),
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
                            ],
                          ),
                          const SizedBox(height: 15),

                          // Customer Interested Product and Priority in same row
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: leadTypeVal,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: const Text(
                                            'Customer Interested Product',
                                          ),
                                          content: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: commonDetails!
                                                .data!
                                                .leadCategory!
                                                .length,
                                            itemBuilder: (context, ind) {
                                              return InkWell(
                                                onTap: () async {
                                                  leadSubTypeList =
                                                      await HttpService.leadSubType(
                                                        commonDetails!
                                                            .data!
                                                            .leadCategory![ind]
                                                            .leadCategoryId
                                                            .toString(),
                                                      );

                                                  setState(() {
                                                    leadTypeVal.text =
                                                        commonDetails!
                                                            .data!
                                                            .leadCategory![ind]
                                                            .leadCategory
                                                            .toString();
                                                    leadSubType =
                                                        'Lead Sub Category';
                                                    leadSubTypeId = '';
                                                    leadType = commonDetails!
                                                        .data!
                                                        .leadCategory![ind]
                                                        .leadCategory
                                                        .toString();
                                                    leadTypeId = commonDetails!
                                                        .data!
                                                        .leadCategory![ind]
                                                        .leadCategoryId
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
                                                        .leadCategory![ind]
                                                        .leadCategory
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
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      top: 2,
                                      bottom: 2,
                                    ),
                                    labelText: 'Customer Interested Product',
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
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: priorityVal,
                                  onTap: () {
                                    if (commonDetails != null &&
                                        commonDetails!.data!.priority != null) {
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
                                                      priority = commonDetails!
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
                                                      priorityVal.text =
                                                          priority;
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
                                    }
                                  },
                                  maxLines: 1,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      top: 2,
                                      bottom: 2,
                                    ),
                                    labelText: 'Priority',
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
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          // Lead Sub Category
                          leadSubTypeList != null &&
                                  leadSubTypeList!.data!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
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
                                              itemCount:
                                                  leadSubTypeList!.data!.length,
                                              itemBuilder: (context, subIndex) {
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      leadSubTypeVal.text =
                                                          leadSubTypeList!
                                                              .data![subIndex]
                                                              .leadSubCategory
                                                              .toString();
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
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      labelText: 'Lead Sub Category',
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
                                      labelStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                )
                              : const SizedBox(),

                          // Job and Location in same row
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: job,
                                  decoration: const InputDecoration(
                                    labelText: 'Job',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.work_outline,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: location,
                                  decoration: const InputDecoration(
                                    labelText: 'Location',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          // Customer Need and Purpose in same row
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: customerNeed,
                                  decoration: const InputDecoration(
                                    labelText: 'Customer Need & Purpose',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
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
                                Expanded(
                                child: TextFormField(
                                  controller: challenges,
                                  decoration: const InputDecoration(
                                    labelText: 'Challenges',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.warning_outlined,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
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
                              // const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: newObjection,
                                  decoration: const InputDecoration(
                                    labelText: 'New Objection',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.block_outlined,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              
                            ],
                          ),
                          const SizedBox(height: 15),

                          // Google Review Status
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

                         
                          TextFormField(
                            controller: reasonForLostSales,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Reason for Lost Sales',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.description_outlined,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 25),

                          // Submit Button
                          InkWell(
                            onTap: () async {
                              final connectivityResult = await (Connectivity()
                                  .checkConnectivity());
                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                if (callResultId == '') {
                                  Common.toastMessaage(
                                    'Choose any Status',
                                    Colors.red,
                                  );
                                } else if (callResultId == '2' &&
                                    nextFollowupDate1.text == '') {
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
                                  String googleReviewStatus = '';
                                  if (googleReviewYes) {
                                    googleReviewStatus = 'Yes';
                                  } else if (googleReviewNo) {
                                    googleReviewStatus = 'No';
                                  }

                                  EditLeadFollowupModel object1 =
                                      await HttpService.editLeadsFollowup(
                                        widget.token,
                                        widget.callFollowupId,
                                        callResultId,
                                        nextFollowupDate1.text,
                                        cost.text,
                                        leadTypeId,
                                        leadSubTypeId,
                                        remarks.text,
                                        calledDate1.text,
                                        widget.callMasterId,
                                        address: address.text,
                                        job: job.text,
                                        location: location.text,
                                        customerNeed: customerNeed.text,
                                        purpose: purpose.text,
                                        challenges: challenges.text,
                                        newObjection: newObjection.text,
                                        googleReviewStatus: googleReviewStatus,
                                        reasonForLostSales:
                                            reasonForLostSales.text,
                                        priorityId: priorityId,
                                      );

                                  if (object1.status == true) {
                                    Common.toastMessaage(
                                      'Followup Updated Successfully',
                                      Colors.green,
                                    );
                                    if (context.mounted) {
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
                                            scrollToIndex: widget.scrollToIndex,
                                          ),
                                        ),
                                      );
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
                                  'Update',
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
