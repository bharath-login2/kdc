import 'package:connectivity_plus/connectivity_plus.dart';
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

  AddFollowup(this.token, this.editLead, this.deleteLead, this.cloudCall,
      this.callMasterId,
      {super.key,
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
      this.priorityId,this.leadType1});

  @override
  State<AddFollowup> createState() => _AddFollowupState();
}

class _AddFollowupState extends State<AddFollowup> {
  AddLeadCommonDataModel? commonDetails;
  LeadSubTypeModel? leadSubTypeList;
  String callResult = 'Followup';
  String callResultId = '2';
  String? nextFollowupDate = '';
  String leadType = 'Lead Category';
  String leadTypeId = '';
  String leadSubType = 'Lead Sub Category';
  String leadSubTypeId = '';
  TextEditingController cost = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController calledDate1 = TextEditingController();
  TextEditingController nextFollowupDate1 = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController callResultVal = TextEditingController();
  TextEditingController leadTypeVal = TextEditingController();
  TextEditingController leadSubTypeVal = TextEditingController();
  TextEditingController priorityVal = TextEditingController();
  TextEditingController timeBefore = TextEditingController(text: '10');
  bool? result = true;
  bool? result1 = true;
  String? callHistoryId;
  String priority = 'Normal';
  String priorityId = '2';
  bool checked = false;
  bool addClient=false;
  bool isExpand=false;
  bool isChecked=false;

  @override
  void initState() {
    // TODO: implement initState
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
    commonDetails = await HttpService.addLeadCommonData(widget.token);
    if (commonDetails != null) {
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
        if (widget.priority != null) {
          priority = widget.priority.toString();
          priorityId = widget.priorityId.toString();
        }

        setState(() {});
      }
      setState(() {});
    }
  }

  String getYmdFromDmy(String dmy) {
    if (dmy.isEmpty) return dmy;
    final split = dmy.split("-");
    return "${split[2]}-${split[1]}-${split[0]}";
  }

  @override
  Widget build(BuildContext context) {
    callResultVal.text = callResult;
    leadTypeVal.text = leadType;
    leadSubTypeVal.text = leadSubType;
    priorityVal.text = priority;
    if (widget.callHistoryId != null) {
      callHistoryId = widget.callHistoryId.toString();
    } else {
      callHistoryId = '';
    }
    if (widget.callingDate != null) {
      calledDate1.text = DateFormat('dd-MM-yyyy HH:mm')
          .format(DateTime.parse(widget.callingDate.toString()));
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
                        )),
              );
              return true;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
                child: Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF2a86c9), Color(0xFF406dbe)]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 10.0, right: 10),
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
                                          )),
                                );
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              'Add Followup',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: calledDate1,
                              readOnly: true,
                              onTap: () async {
                                await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100))
                                    .then((selectedDate) {
                                  if (selectedDate != null) {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((selectedTime) {
                                      String newDate = selectedDate.toString();
                                      newDate = newDate.substring(
                                          0, newDate.indexOf(" "));
                                      String convertedNewDate =
                                          getYmdFromDmy(newDate);
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
                                      left: 10, top: 2, bottom: 2),
                                  labelText: 'Called Date',
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.calendar_month_sharp,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
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
                                              .data!.callResultNew!.length,
                                          itemBuilder: (context, ind) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  callResult = commonDetails!
                                                      .data!
                                                      .callResultNew![ind]
                                                      .callResultNew
                                                      .toString();

                                                  callResultId = commonDetails!
                                                      .data!
                                                      .callResultNew![ind]
                                                      .callResultIdNew
                                                      .toString();
                                                  if (callResultId != '2') {
                                                    nextFollowupDate = '';
                                                    checked=false;
                                                  }
                                                  Navigator.pop(context, true);
                                                });
                                              },
                                              child: SizedBox(
                                                height: 50,
                                                child: Text(
                                                  commonDetails!
                                                      .data!
                                                      .callResultNew![ind]
                                                      .callResultNew
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    });
                              },
                              maxLines: 1,
                              readOnly: true,
                              controller: callResultVal,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 2, bottom: 2),
                                  labelText: 'Call Result',
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            if(callResultId=='4'&& commonDetails!.data!.customerAddPermission==true)
                              CheckboxListTile(
                                  title: const Text('Add  Client'),
                                  value: addClient, // initial value of the checkbox
                                  onChanged: (bool? value) {
                                    setState(() {
                                      addClient=value!;
                                    });

                                  },
                                  controlAffinity:
                                  ListTileControlAffinity
                                      .leading
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
                                          lastDate: DateTime(2100))
                                      .then((selectedDate) {
                                    if (selectedDate != null) {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((selectedTime) {
                                        String newDate =
                                            selectedDate.toString();
                                        newDate = newDate.substring(
                                            0, newDate.indexOf(" "));
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
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 10, top: 2, bottom: 2),
                                    labelText: 'Next Followup Date',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.calendar_month_sharp,
                                        color: Colors.grey),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    labelStyle: TextStyle(color: Colors.grey)),
                              ),
                            if (callResultId == '2')
                              const SizedBox(
                                height: 10,
                              ),
                            if (callResultId == '2')
                              Row(
                                children: [
                                  SizedBox(
                                    width: 230,
                                    child: CheckboxListTile(
                                      title: const Text(
                                        "Remind Me Before",
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      value: checked,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checked = newValue!;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                  ),
                                  if (checked == true)SizedBox(
                                    width: 90,
                                    child: Container(
                                      width:80,
                                      foregroundDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
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
                                                contentPadding: const EdgeInsets.all(8.0),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                ),
                                              ),
                                              controller: timeBefore,
                                              keyboardType: const TextInputType.numberWithOptions(
                                                decimal: false,
                                                signed: true,
                                              ),

                                            ),
                                          ),
                                          SizedBox(
                                            height: 38.0,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  decoration: const BoxDecoration(
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
                                                      int currentValue = int.parse(timeBefore.text);
                                                      setState(() {
                                                        currentValue++;
                                                        timeBefore.text = (currentValue)
                                                            .toString(); // incrementing value
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
                                                    int currentValue = int.parse(timeBefore.text);
                                                    setState(() {

                                                      currentValue--;
                                                      timeBefore.text =
                                                          (currentValue > 0 ? currentValue : 0)
                                                              .toString(); // decrementing value
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
                            if (checked == true)const SizedBox(height: 10,),
                            // if (checked == true)
                            //   Padding(
                            //     padding: const EdgeInsets.only(top: 10,bottom: 15),
                            //     child: TextFormField(
                            //       controller: timeBefore,
                            //       keyboardType: TextInputType.number,
                            //       decoration: const InputDecoration(
                            //           contentPadding: EdgeInsets.only(
                            //               left: 10, top: 2, bottom: 2),
                            //           labelText: 'Time Before',
                            //           fillColor: Colors.white,
                            //           filled: true,
                            //           prefixIcon: Icon(Icons.lock_clock,
                            //               color: Colors.grey),
                            //           border: OutlineInputBorder(),
                            //           focusedBorder: OutlineInputBorder(
                            //             borderSide:
                            //                 BorderSide(color: Colors.grey),
                            //           ),
                            //           labelStyle: TextStyle(color: Colors.grey)),
                            //     ),
                            //   ),

                            TextFormField(
                              controller: cost,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 2, bottom: 2),
                                  labelText: 'Cost',
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.currency_rupee,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: leadTypeVal,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: const Text('Lead Category'),
                                        content: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: commonDetails!
                                              .data!.leadCategory!.length,
                                          itemBuilder: (context, ind) {
                                            return InkWell(
                                              onTap: () async {
                                                leadSubTypeList =
                                                    await HttpService
                                                        .leadSubType(
                                                            commonDetails!
                                                                .data!
                                                                .leadCategory![
                                                                    ind]
                                                                .leadCategoryId
                                                                .toString());
                                                setState(() {
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
                                                  Navigator.pop(context, true);
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
                                                      fontSize: 18),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    });
                              },
                              maxLines: 1,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 2, bottom: 2),
                                  labelText: 'Lead Category',
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            leadSubTypeList != null &&
                                    leadSubTypeList!.data!.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: TextFormField(
                                      controller: leadSubTypeVal,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                scrollable: true,
                                                title: const Text(
                                                    'Lead Sub Category'),
                                                content: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: leadSubTypeList!
                                                      .data!.length,
                                                  itemBuilder:
                                                      (context, subIndex) {
                                                    return InkWell(
                                                      onTap: () async {
                                                        setState(() {
                                                          leadSubType =
                                                              leadSubTypeList!
                                                                  .data![
                                                                      subIndex]
                                                                  .leadSubCategory
                                                                  .toString();
                                                          leadSubTypeId =
                                                              leadSubTypeList!
                                                                  .data![
                                                                      subIndex]
                                                                  .leadSubCategoryId
                                                                  .toString();
                                                          Navigator.pop(
                                                              context, true);
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
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            });
                                      },
                                      maxLines: 1,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 10, top: 2, bottom: 2),
                                          labelText: 'Lead Sub Category',
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: Icon(
                                              Icons
                                                  .arrow_drop_down_circle_outlined,
                                              color: Colors.grey),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          labelStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  )
                                : const SizedBox(),

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
                                              .data!.priority!.length,
                                          itemBuilder: (context, ind) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  priority = commonDetails!
                                                      .data!
                                                      .priority![ind]
                                                      .priority
                                                      .toString();
                                                  priorityId = commonDetails!
                                                      .data!
                                                      .priority![ind]
                                                      .priorityId
                                                      .toString();
                                                  Navigator.pop(context, true);
                                                });
                                              },
                                              child: SizedBox(
                                                height: 50,
                                                child: Text(
                                                  commonDetails!.data!
                                                      .priority![ind].priority
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    });
                              },
                              maxLines: 1,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 2, bottom: 2),
                                  labelText: 'Priority',
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: address,
                              decoration: const InputDecoration(
                                  labelText: 'Address',
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.location_on_outlined,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    commonDetails!.data!.callResponse!.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          remarks.text = commonDetails!
                                              .data!.callResponse![i]
                                              .toString();
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 0),
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(6))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Text(
                                                commonDetails!
                                                    .data!.callResponse![i]
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
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: remarks,
                              maxLines: 2,
                              decoration: const InputDecoration(
                                  labelText: 'Remarks',
                                  fillColor: Colors.white,
                                  filled: true,
                                  //prefixIcon: Icon(myIcon, color: prefixIconColor),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // TextFormField(
                            //   controller: calledDate1,
                            //   readOnly: true,
                            //   onTap: () async {
                            //     await showDatePicker(
                            //             context: context,
                            //             initialDate: DateTime.now(),
                            //             firstDate: DateTime.now(),
                            //             lastDate: DateTime(2100))
                            //         .then((selectedDate) {
                            //       if (selectedDate != null) {
                            //         showTimePicker(
                            //                 context: context,
                            //                 initialTime: TimeOfDay.now())
                            //             .then((selectedTime) {
                            //           String newDate = selectedDate.toString();
                            //           newDate = newDate.substring(
                            //               0, newDate.indexOf(" "));
                            //           String convertedNewDate =
                            //               getYmdFromDmy(newDate);
                            //           if (selectedTime != null) {
                            //             calledDate1.text =
                            //                 "$convertedNewDate ${selectedTime.format(context)}";
                            //           } else {}
                            //         });
                            //       }
                            //     });
                            //   },
                            //   style: const TextStyle(
                            //     color: Colors.black,
                            //   ),
                            //   decoration: InputDecoration(
                            //       filled: true,
                            //       //<-- SEE HERE
                            //       fillColor: Colors.white,
                            //       prefixIcon: FittedBox(
                            //         fit: BoxFit.fill,
                            //         child: Row(
                            //           children: [
                            //             Container(
                            //               decoration: const BoxDecoration(
                            //                 color: Color(0xFF2a86c9),
                            //                 borderRadius: BorderRadius.only(
                            //                   topLeft: Radius.circular(40),
                            //                   bottomLeft: Radius.circular(40),
                            //                 ),
                            //               ),
                            //               width: 10,
                            //               height: 50,
                            //             ),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //             const Icon(
                            //               Icons.arrow_right,
                            //               color: Colors.grey,
                            //             ),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       counterText: "",
                            //       hintText: "Called Date",
                            //       isDense: true,
                            //       border: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: Colors.purple.shade100),
                            //           borderRadius: BorderRadius.circular(10))),
                            // ),
                            // const SizedBox(height: 10),
                            // TextFormField(
                            //     onTap: () {
                            //       showDialog(
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return AlertDialog(
                            //               scrollable: true,
                            //               title: const Text('Status'),
                            //               content: ListView.builder(
                            //                 shrinkWrap: true,
                            //                 itemCount: commonDetails!
                            //                     .data!.callResult!.length,
                            //                 itemBuilder: (context, ind) {
                            //                   return InkWell(
                            //                     onTap: () {
                            //                       setState(() {
                            //                         callResult = commonDetails!
                            //                             .data!
                            //                             .callResult![ind]
                            //                             .callResult
                            //                             .toString();
                            //
                            //                         callResultId = commonDetails!
                            //                             .data!
                            //                             .callResult![ind]
                            //                             .callResultId
                            //                             .toString();
                            //                         if (callResultId != '2') {
                            //                           nextFollowupDate = '';
                            //                         }
                            //                         Navigator.pop(context, true);
                            //                       });
                            //                     },
                            //                     child: SizedBox(
                            //                       height: 50,
                            //                       child: Text(
                            //                         commonDetails!
                            //                             .data!
                            //                             .callResult![ind]
                            //                             .callResult
                            //                             .toString(),
                            //                         style: const TextStyle(
                            //                             fontSize: 18),
                            //                       ),
                            //                     ),
                            //                   );
                            //                 },
                            //               ),
                            //             );
                            //           });
                            //     },
                            //     maxLines: 1,
                            //     readOnly: true,
                            //     keyboardType: TextInputType.text,
                            //     decoration: InputDecoration(
                            //         filled: true,
                            //         //<-- SEE HERE
                            //         fillColor: Colors.white,
                            //         prefixIcon: FittedBox(
                            //           fit: BoxFit.fill,
                            //           child: Row(
                            //             children: [
                            //               Container(
                            //                 decoration: const BoxDecoration(
                            //                   color: Color(0xFF2a86c9),
                            //                   borderRadius: BorderRadius.only(
                            //                     topLeft: Radius.circular(40),
                            //                     bottomLeft: Radius.circular(40),
                            //                   ),
                            //                 ),
                            //                 width: 10,
                            //                 height: 50,
                            //               ),
                            //               const SizedBox(
                            //                 width: 10,
                            //               ),
                            //               const Icon(
                            //                 Icons.arrow_right,
                            //                 color: Colors.grey,
                            //               ),
                            //               const SizedBox(
                            //                 width: 10,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         counterText: "",
                            //         hintText: callResult,
                            //         isDense: true,
                            //         border: OutlineInputBorder(
                            //             borderSide: BorderSide(
                            //                 color: Colors.purple.shade100),
                            //             borderRadius:
                            //                 BorderRadius.circular(10)))),
                            // const SizedBox(height: 10),
                            // if (callResultId == '2')
                            //   TextFormField(
                            //     controller: nextFollowupDate1,
                            //     readOnly: true,
                            //     onTap: () async {
                            //       await showDatePicker(
                            //               context: context,
                            //               initialDate: DateTime.now(),
                            //               firstDate: DateTime.now(),
                            //               lastDate: DateTime(2100))
                            //           .then((selectedDate) {
                            //         if (selectedDate != null) {
                            //           showTimePicker(
                            //                   context: context,
                            //                   initialTime: TimeOfDay.now())
                            //               .then((selectedTime) {
                            //             String newDate = selectedDate.toString();
                            //             newDate = newDate.substring(
                            //                 0, newDate.indexOf(" "));
                            //             String convertedNewDate =
                            //                 getYmdFromDmy(newDate);
                            //             if (selectedTime != null) {
                            //               nextFollowupDate1.text =
                            //                   "$convertedNewDate ${selectedTime.format(context)}";
                            //             } else {}
                            //           });
                            //         }
                            //       });
                            //     },
                            //     style: const TextStyle(
                            //       color: Colors.black,
                            //     ),
                            //     decoration: InputDecoration(
                            //         filled: true,
                            //         //<-- SEE HERE
                            //         fillColor: Colors.white,
                            //         prefixIcon: FittedBox(
                            //           fit: BoxFit.fill,
                            //           child: Row(
                            //             children: [
                            //               Container(
                            //                 decoration: const BoxDecoration(
                            //                   color: Color(0xFF2a86c9),
                            //                   borderRadius: BorderRadius.only(
                            //                     topLeft: Radius.circular(40),
                            //                     bottomLeft: Radius.circular(40),
                            //                   ),
                            //                 ),
                            //                 width: 10,
                            //                 height: 50,
                            //               ),
                            //               const SizedBox(
                            //                 width: 10,
                            //               ),
                            //               const Icon(
                            //                 Icons.arrow_right,
                            //                 color: Colors.grey,
                            //               ),
                            //               const SizedBox(
                            //                 width: 10,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         counterText: "",
                            //         hintText: "Next Followup Date",
                            //         isDense: true,
                            //         border: OutlineInputBorder(
                            //             borderSide: BorderSide(
                            //                 color: Colors.purple.shade100),
                            //             borderRadius: BorderRadius.circular(10))),
                            //   ),
                            // if (callResultId == '2') const SizedBox(height: 10),
                            // TextFormField(
                            //   controller: cost,
                            //   style: const TextStyle(
                            //     color: Colors.black,
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) return "Cost";
                            //     return null;
                            //   },
                            //   keyboardType: TextInputType.name,
                            //   decoration: InputDecoration(
                            //       filled: true,
                            //       //<-- SEE HERE
                            //       fillColor: Colors.white,
                            //       prefixIcon: FittedBox(
                            //         fit: BoxFit.fill,
                            //         child: Row(
                            //           children: [
                            //             Container(
                            //               decoration: const BoxDecoration(
                            //                 color: Color(0xFF2a86c9),
                            //                 borderRadius: BorderRadius.only(
                            //                   topLeft: Radius.circular(40),
                            //                   bottomLeft: Radius.circular(40),
                            //                 ),
                            //               ),
                            //               width: 10,
                            //               height: 50,
                            //             ),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //             const Icon(
                            //               Icons.arrow_right,
                            //               color: Colors.grey,
                            //             ),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       counterText: "",
                            //       hintText: "Cost",
                            //       isDense: true,
                            //       border: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: Colors.purple.shade100),
                            //           borderRadius: BorderRadius.circular(10))),
                            // ),
                            // const SizedBox(height: 10),
                            // TextFormField(
                            //     onTap: () {
                            //       showDialog(
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return AlertDialog(
                            //               scrollable: true,
                            //               title: const Text('Lead Category'),
                            //               content: ListView.builder(
                            //                 shrinkWrap: true,
                            //                 itemCount: commonDetails!
                            //                     .data!.leadCategory!.length,
                            //                 itemBuilder: (context, ind) {
                            //                   return InkWell(
                            //                     onTap: () async {
                            //                       leadSubTypeList =
                            //                           await HttpService
                            //                               .leadSubType(
                            //                                   commonDetails!
                            //                                       .data!
                            //                                       .leadCategory![
                            //                                           ind]
                            //                                       .leadCategoryId
                            //                                       .toString());
                            //                       setState(() {
                            //                         leadSubType =
                            //                             'Lead Sub Category';
                            //                         leadSubTypeId = '';
                            //                         leadType = commonDetails!
                            //                             .data!
                            //                             .leadCategory![ind]
                            //                             .leadCategory
                            //                             .toString();
                            //                         leadTypeId = commonDetails!
                            //                             .data!
                            //                             .leadCategory![ind]
                            //                             .leadCategoryId
                            //                             .toString();
                            //                         Navigator.pop(context, true);
                            //                       });
                            //                     },
                            //                     child: SizedBox(
                            //                       height: 50,
                            //                       child: Text(
                            //                         commonDetails!
                            //                             .data!
                            //                             .leadCategory![ind]
                            //                             .leadCategory
                            //                             .toString(),
                            //                         style: const TextStyle(
                            //                             fontSize: 18),
                            //                       ),
                            //                     ),
                            //                   );
                            //                 },
                            //               ),
                            //             );
                            //           });
                            //     },
                            //     maxLines: 1,
                            //     readOnly: true,
                            //     keyboardType: TextInputType.text,
                            //     decoration: InputDecoration(
                            //         filled: true,
                            //         //<-- SEE HERE
                            //         fillColor: Colors.white,
                            //         prefixIcon: FittedBox(
                            //           fit: BoxFit.fill,
                            //           child: Row(
                            //             children: [
                            //               Container(
                            //                 decoration: const BoxDecoration(
                            //                   color: Color(0xFF2a86c9),
                            //                   borderRadius: BorderRadius.only(
                            //                     topLeft: Radius.circular(40),
                            //                     bottomLeft: Radius.circular(40),
                            //                   ),
                            //                 ),
                            //                 width: 10,
                            //                 height: 50,
                            //               ),
                            //               const SizedBox(
                            //                 width: 10,
                            //               ),
                            //               const Icon(
                            //                 Icons.arrow_right,
                            //                 color: Colors.grey,
                            //               ),
                            //               const SizedBox(
                            //                 width: 10,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         counterText: "",
                            //         hintText: leadType,
                            //         isDense: true,
                            //         border: OutlineInputBorder(
                            //             borderSide: BorderSide(
                            //                 color: Colors.purple.shade100),
                            //             borderRadius:
                            //                 BorderRadius.circular(10)))),
                            // const SizedBox(height: 10),
                            // leadSubTypeList != null &&
                            //         leadSubTypeList!.data!.isNotEmpty
                            //     ? Padding(
                            //         padding: const EdgeInsets.only(bottom: 10),
                            //         child: TextFormField(
                            //             onTap: () {
                            //               showDialog(
                            //                   context: context,
                            //                   builder: (BuildContext context) {
                            //                     return AlertDialog(
                            //                       scrollable: true,
                            //                       title: const Text(
                            //                           'Lead Sub Category'),
                            //                       content: ListView.builder(
                            //                         shrinkWrap: true,
                            //                         itemCount: leadSubTypeList!
                            //                             .data!.length,
                            //                         itemBuilder:
                            //                             (context, subIndex) {
                            //                           return InkWell(
                            //                             onTap: () {
                            //                               setState(() {
                            //                                 leadSubType =
                            //                                     leadSubTypeList!
                            //                                         .data![
                            //                                             subIndex]
                            //                                         .leadSubCategory
                            //                                         .toString();
                            //                                 leadSubTypeId =
                            //                                     leadSubTypeList!
                            //                                         .data![
                            //                                             subIndex]
                            //                                         .leadSubCategoryId
                            //                                         .toString();
                            //                                 Navigator.pop(
                            //                                     context, true);
                            //                               });
                            //                             },
                            //                             child: SizedBox(
                            //                               height: 50,
                            //                               child: Text(
                            //                                 leadSubTypeList!
                            //                                     .data![subIndex]
                            //                                     .leadSubCategory
                            //                                     .toString(),
                            //                                 style:
                            //                                     const TextStyle(
                            //                                         fontSize: 18),
                            //                               ),
                            //                             ),
                            //                           );
                            //                         },
                            //                       ),
                            //                     );
                            //                   });
                            //             },
                            //             maxLines: 1,
                            //             readOnly: true,
                            //             keyboardType: TextInputType.text,
                            //             decoration: InputDecoration(
                            //                 filled: true,
                            //                 //<-- SEE HERE
                            //                 fillColor: Colors.white,
                            //                 prefixIcon: FittedBox(
                            //                   fit: BoxFit.fill,
                            //                   child: Row(
                            //                     children: [
                            //                       Container(
                            //                         decoration:
                            //                             const BoxDecoration(
                            //                           color: Color(0xFF2a86c9),
                            //                           borderRadius:
                            //                               BorderRadius.only(
                            //                             topLeft:
                            //                                 Radius.circular(40),
                            //                             bottomLeft:
                            //                                 Radius.circular(40),
                            //                           ),
                            //                         ),
                            //                         width: 10,
                            //                         height: 50,
                            //                       ),
                            //                       const SizedBox(
                            //                         width: 10,
                            //                       ),
                            //                       const Icon(
                            //                         Icons.arrow_right,
                            //                         color: Colors.grey,
                            //                       ),
                            //                       const SizedBox(
                            //                         width: 10,
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 counterText: "",
                            //                 hintText: leadSubType,
                            //                 isDense: true,
                            //                 border: OutlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color:
                            //                             Colors.purple.shade100),
                            //                     borderRadius:
                            //                         BorderRadius.circular(10)))),
                            //       )
                            //     : const SizedBox(),
                            // TextFormField(
                            //   controller: address,
                            //   style: const TextStyle(
                            //     color: Colors.black,
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) return "Address";
                            //     return null;
                            //   },
                            //   keyboardType: TextInputType.name,
                            //   decoration: InputDecoration(
                            //       filled: true,
                            //       //<-- SEE HERE
                            //       fillColor: Colors.white,
                            //       prefixIcon: FittedBox(
                            //         fit: BoxFit.fill,
                            //         child: Row(
                            //           children: [
                            //             Container(
                            //               decoration: const BoxDecoration(
                            //                 color: Color(0xFF2a86c9),
                            //                 borderRadius: BorderRadius.only(
                            //                   topLeft: Radius.circular(40),
                            //                   bottomLeft: Radius.circular(40),
                            //                 ),
                            //               ),
                            //               width: 10,
                            //               height: 50,
                            //             ),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //             const Icon(
                            //               Icons.arrow_right,
                            //               color: Colors.grey,
                            //             ),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       counterText: "",
                            //       hintText: "Address",
                            //       isDense: true,
                            //       border: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: Colors.purple.shade100),
                            //           borderRadius: BorderRadius.circular(10))),
                            // ),
                            // const SizedBox(height: 10),
                            // SizedBox(
                            //   height: 30,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount:
                            //         commonDetails!.data!.callResponse!.length,
                            //     itemBuilder: (context, i) {
                            //       return Padding(
                            //         padding:
                            //             const EdgeInsets.only(left: 5, right: 10),
                            //         child: InkWell(
                            //           onTap: () {
                            //             setState(() {
                            //               remarks.text = commonDetails!
                            //                   .data!.callResponse![i]
                            //                   .toString();
                            //             });
                            //           },
                            //           child: Container(
                            //             height: 30,
                            //             decoration: BoxDecoration(
                            //                 border: Border.all(
                            //                     color: Colors.grey, width: 0),
                            //                 color: Colors.white,
                            //                 borderRadius: const BorderRadius.all(
                            //                     Radius.circular(6))),
                            //             child: Center(
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 children: [
                            //                   Padding(
                            //                     padding:
                            //                         const EdgeInsets.all(8.0),
                            //                     child: Text(
                            //                       commonDetails!
                            //                           .data!.callResponse![i]
                            //                           .toString(),
                            //                       style: const TextStyle(
                            //                         color: Color(0xFF717171),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            // const SizedBox(height: 10),
                            // TextFormField(
                            //   maxLines: 2,
                            //   controller: remarks,
                            //   style: const TextStyle(
                            //     color: Colors.black,
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) return "remarks";
                            //     return null;
                            //   },
                            //   keyboardType: TextInputType.name,
                            //   decoration: InputDecoration(
                            //       filled: true,
                            //       //<-- SEE HERE
                            //       fillColor: Colors.white,
                            //       prefixIcon: FittedBox(
                            //         fit: BoxFit.fill,
                            //         child: Row(
                            //           children: [
                            //             Container(
                            //               decoration: const BoxDecoration(
                            //                 color: Color(0xFF2a86c9),
                            //                 borderRadius: BorderRadius.only(
                            //                   topLeft: Radius.circular(40),
                            //                   bottomLeft: Radius.circular(40),
                            //                 ),
                            //               ),
                            //               width: 10,
                            //               height: 70,
                            //             ),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //             const Icon(
                            //               Icons.arrow_right,
                            //               color: Colors.grey,
                            //             ),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       counterText: "",
                            //       hintText: "Remark",
                            //       isDense: true,
                            //       border: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: Colors.purple.shade100),
                            //           borderRadius: BorderRadius.circular(10))),
                            // ),
                            // const SizedBox(
                            //   height: 25,
                            // ),
                            InkWell(
                              onTap: () async {
                                final connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult ==
                                        ConnectivityResult.mobile ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {
                                  if (callResultId == '') {
                                    Common.toastMessaage(
                                        'Choose any Status', Colors.red);
                                  } else if (callResultId == '2' &&
                                      nextFollowupDate1.text.isEmpty) {
                                    Common.toastMessaage(
                                        'Choose next followup date',
                                        Colors.red);
                                  } else {
                                    if (context.mounted) {
                                      Common.showProgressDialog(
                                          context, "Loading..");
                                    }
                                    AddLeadFollowupModel object1 =
                                        await HttpService.addLeadsFollowup(
                                            widget.token,
                                            callResultId,
                                            nextFollowupDate1.text,
                                            cost.text,
                                            address.text,
                                            leadTypeId,
                                            leadSubTypeId,
                                            remarks.text,
                                            widget.callMasterId,
                                            calledDate1.text,
                                            callHistoryId,
                                            priorityId,checked,timeBefore.text,addClient);
                                    if (object1.status == true) {
                                      Common.toastMessaage(
                                          object1.message, Colors.green);
                                      if (context.mounted) {
                                        if(object1.data!='' && commonDetails!.data!.customerAddPermission==true && commonDetails!.data
                                        !.customerAddInvoicePermission==true)
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => AddInvoice(widget.token!,object1.data!)),
                                            );
                                          }
                                        else{
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
                                                )),
                                          );
                                        }

                                      }
                                    } else {
                                      Common.toastMessaage(
                                          object1.message, Colors.red);
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
                                            'No Network Found..Try Again Later..'),
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
                                  child: Text('Submit',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                child: Lottie.asset('assets/main/loading.json',
                    fit: BoxFit.fill),
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
                  const SizedBox(
                    height: 15,
                  ),
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
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
