import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kdc_chitty_mainnew/models/lead_management/callResultReasonModel.dart';
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
import '../../widgets/leadDynamicFormWidget.dart';

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
  String? clientName;
  bool isViewOnly;

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
    this.clientName,
    this.isViewOnly = false,
  });

  @override
  State<EditFollowup> createState() => _EditFollowupState();
}

class _EditFollowupState extends State<EditFollowup> {
  final GlobalKey<LeadDynamicFormWidgetState> leadFormKey = GlobalKey<LeadDynamicFormWidgetState>();
  LeadDynamicFormData currentFormData = LeadDynamicFormData();
  AddLeadCommonDataModel? commonDetails;
  LeadSubTypeModel? leadSubTypeList;
  CallResultResonModel? callResultReason;
  String callResultReasonName = 'Reason';
  String callResultReasonId = '';
  String callResult = 'New';
  String callStatus = 'New';
  String callResultId = '1';
  String callStatusId = '';
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
  TextEditingController clientNameController = TextEditingController();
  TextEditingController calledDate1 = TextEditingController();
  TextEditingController nextFollowupDate1 = TextEditingController();
  TextEditingController leadTypeVal = TextEditingController();
  TextEditingController leadSubTypeVal = TextEditingController();
  TextEditingController callResultVal = TextEditingController();
  TextEditingController callStatusVal = TextEditingController();
  TextEditingController priorityVal = TextEditingController();
  TextEditingController callReasonVal = TextEditingController();
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
    if (widget.token == null || widget.token!.isEmpty) {
      widget.token = await Common.getSharedPref("token");
    }
    commonDetails = await HttpService.addLeadCommonData(widget.token);
    followupDetails = await HttpService.followupDetails(
      widget.token,
      widget.callFollowupId,
    );
    callResultReasonList();
    if (followupDetails != null && followupDetails!.data != null) {
      if (followupDetails!.data!.leadCategoryId.toString() != '') {
        leadSubTypeList = await HttpService.leadSubType(
          followupDetails!.data!.leadCategoryId.toString(),
        );
      }

      setState(() {
        clientNameController.text =
            followupDetails?.data?.clientName ?? widget.clientName ?? '';
        callResult = followupDetails!.data!.callResult.toString();
        callResultId = followupDetails!.data!.callResultId.toString();
        callStatus = followupDetails!.data!.callResponse.toString();
        callStatusId = followupDetails!.data!.callResponseId.toString();
        calledDate1.text = DateFormat(
          'dd-MM-yyyy HH:mm',
        ).format(DateTime.parse(followupDetails!.data!.calledDate.toString()));

        if (followupDetails!.data!.followupDate != null &&
            followupDetails!.data!.followupDate!.isNotEmpty) {
          nextFollowupDate1.text = DateFormat('dd-MM-yyyy HH:mm').format(
            DateTime.parse(followupDetails!.data!.followupDate.toString()),
          );
        }

        if (followupDetails!.data!.callResult != null &&
            followupDetails!.data!.callResult!.isNotEmpty) {
          leadType = followupDetails!.data!.callResult.toString();
          leadTypeId = followupDetails!.data!.callResultId?.toString() ??
              followupDetails!.data!.leadCategoryId.toString();
        } else {
          leadType = followupDetails!.data!.leadCategory.toString();
          leadTypeId = followupDetails!.data!.leadCategoryId.toString();
        }

        cost.text = followupDetails!.data!.cost?.toString() ?? '';
        remarks.text = followupDetails!.data!.remarks?.toString() ?? '';
        address.text = followupDetails!.data!.address?.toString() ?? '';

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
        leadTypeVal.text = leadType;
        leadSubTypeVal.text = followupDetails!.data!.leadSubCategory.toString();
        callResultVal.text = followupDetails!.data!.callResult.toString();
        callStatusVal.text =
            followupDetails!.data!.callResponse?.toString() ?? '';
        priorityVal.text = priority; // You might need to get this from API
      });
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
                          Text(
                            widget.isViewOnly ? 'View Followup' : 'Edit Followup',
                            style: const TextStyle(color: Colors.white, fontSize: 18),
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
                    child: IgnorePointer(
                      ignoring: widget.isViewOnly,
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
                          TextFormField(
                            controller: clientNameController,
                            readOnly: widget.isViewOnly,
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
                              if (widget.isViewOnly) return;
                              await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
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
                            isReadOnly: widget.isViewOnly,
                            initialChannelId: followupDetails?.data?.connectingChannelId,
                            initialStatusId: followupDetails?.data?.connectingStatusId,
                            initialReasonId: followupDetails?.data?.connectingReasonId,
                            initialCallStatusId: followupDetails?.data?.callResultId,
                            initialCallStatusReasonId: followupDetails?.data?.callStatusReasonId ?? followupDetails?.data?.callResponseId,
                            initialTriedToReduce: followupDetails?.data?.triedToReduceRejection,
                            initialReduceMethods: followupDetails?.data?.reduceRejectionMethodIds is List
                                ? (followupDetails!.data!.reduceRejectionMethodIds as List).map((e) => e.toString()).toList()
                                : null,
                            initialReductionChallenges: followupDetails?.data?.reductionChallenges,
                            initialRejectionToRelation: followupDetails?.data?.rejectionToRelation,
                            initialRelationActions: followupDetails?.data?.relationActionIds is List
                                ? (followupDetails!.data!.relationActionIds as List).map((e) => e.toString()).toList()
                                : null,
                            initialRelationChallenges: followupDetails?.data?.relationChallenges,
                            initialProspectQualified: followupDetails?.data?.prospectQualified,
                            initialProspectParams: followupDetails?.data?.prospectParameterIds is List
                                ? (followupDetails!.data!.prospectParameterIds as List).map((e) => e.toString()).toList()
                                : null,
                            initialProspectParamValues: followupDetails?.data?.prospectParamValues is Map
                                ? Map<String, Map<String, String>>.from(followupDetails!.data!.prospectParamValues)
                                : null,
                            initialProspectChallenges: followupDetails?.data?.prospectChallenges,
                            initialProductCustomization: followupDetails?.data?.productCustomization,
                            initialCustomizationParams: followupDetails?.data?.customizationParameterIds is List
                                ? (followupDetails!.data!.customizationParameterIds as List).map((e) => e.toString()).toList()
                                : null,
                            initialCustomizationChallenges: followupDetails?.data?.customizationChallenges,
                            initialCustomerSummary: followupDetails?.data?.customerSummary,
                            initialCustomerChallenges: followupDetails?.data?.customerChallenges,
                            initialCustomerRating: followupDetails?.data?.customerRating != null
                                ? int.tryParse(followupDetails!.data!.customerRating.toString())
                                : null,
                             initialRelationshipBuild: followupDetails?.data?.relationshipBuild,
                             initialRelationshipParams: followupDetails?.data?.relationshipParameterIds is List
                                 ? (followupDetails!.data!.relationshipParameterIds as List).map((e) => e.toString()).toList()
                                 : null,
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

                          // Next Followup Date (only when callResultId is '2')
                          callResultId == '2'
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    controller: nextFollowupDate1,
                                    readOnly: true,
                                    onTap: () async {
                                      if (widget.isViewOnly) return;
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
                                              DateTime selectedDateTime =
                                                  DateTime(
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
                            readOnly: widget.isViewOnly,
                          ),
                          
                          const SizedBox(height: 15),

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
                                        if (widget.isViewOnly) return;
                                        if (commonDetails != null &&
                                            commonDetails!.data!.priority !=
                                                null) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                scrollable: true,
                                                title: const Text('Possibility'),
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
                                        }
                                      },
                                      maxLines: 1,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 10,
                                          top: 12,
                                          bottom: 12,
                                        ),
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
                          const SizedBox(height: 15),

                          // Lead Sub Category
                          leadSubTypeList != null &&
                                  leadSubTypeList!.data!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          if (widget.isViewOnly) return;
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
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 10,
                                            top: 12,
                                            bottom: 12,
                                          ),
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
                                )
                              : const SizedBox(),

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
                                        onChanged: widget.isViewOnly
                                            ? null
                                            : (value) {
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
                                        onChanged: widget.isViewOnly
                                            ? null
                                            : (value) {
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
                            readOnly: widget.isViewOnly,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Enter Customer Feed back',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 25),

                          // Submit Button
                          if (!widget.isViewOnly)
                          InkWell(
                            onTap: () async {
                              final connectivityResult = await (Connectivity()
                                  .checkConnectivity());
                              if (connectivityResult == ConnectivityResult.mobile ||
                                  connectivityResult == ConnectivityResult.wifi) {
                                  if (leadTypeId.isEmpty || leadType.isEmpty || leadType == 'Lead Category') {
                                    Common.toastMessaage('Please select Lead Category', Colors.red);
                                    return;
                                  }
                                 if (leadFormKey.currentState != null && !leadFormKey.currentState!.validate()) {
                                   return;
                                 }
                                 if (callResultId == '2' &&
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
                                     'call_lead_category': leadTypeId,
                                     'relationship_build': currentFormData.relationshipBuild,
                                     'relationship_parameters': jsonEncode(currentFormData.relationshipParameterIds),
                                   };

                                   EditLeadFollowupModel object1 =
                                       await HttpService.editLeadsFollowup(
                                         widget.token,
                                         widget.callFollowupId,
                                         callResultId,
                                         nextFollowupDate1.text,
                                         cost.text,
                                         leadTypeId,
                                         leadSubTypeId,
                                         callResultReasonId,
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
                                         dynamicFormData: extraDynamicFields,
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
