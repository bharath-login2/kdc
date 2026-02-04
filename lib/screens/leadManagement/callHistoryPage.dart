import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kdc_chitty_mainnew/screens/leadManagement/playWidget.dart';
import 'package:lottie/lottie.dart';
import '../../models/lead_management/callHistoryModel.dart';
import '../../screens/leadManagement/dashboard.dart';
import '../../service/service.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CallHistoryPage extends StatefulWidget {
  String token;
  String name;
  String userId;
  bool accessCallRecord;

  CallHistoryPage(this.token, this.name, this.userId, this.accessCallRecord,
      {super.key});

  @override
  State<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends State<CallHistoryPage> {
  CallHistoryModel? callHistory;
  var fromdate = DateTime.now();
  var todate = DateTime.now();
  String assignStaff = 'Assign Staff';
  String assignStaffId = '';
  bool? result = true;
  bool? result1 = true;
  bool search = false;
  bool isSearch = true;
  //final GlobalKey<AudioItemsState> _keyChild1 = GlobalKey();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override




  getData() async {
    if (search == false) {
      assignStaff = widget.name;
      assignStaffId = widget.userId;
    }
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
    callHistory = await HttpService.callHistory(
        widget.token, assignStaffId, fromdate, todate);
    if (callHistory != null) {
      setState(() {
        isSearch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        if (mounted) {
          Navigator.pop(context);
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          getData();
          return;
        },
        child: result1 == true
            ? Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      MediaQuery.of(context).size.height * 0.08),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Dashboard(widget.token)),
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
                                'Call History',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: callHistory != null && isSearch == false
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('From Date',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Center(
                                          child: DateTimePicker(
                                            decoration: InputDecoration(
                                                filled: true,
                                                //<-- SEE HERE
                                                fillColor: Colors.white,
                                                prefixIcon: const Icon(
                                                  Icons.arrow_right,
                                                  color: Colors.grey,
                                                ),
                                                counterText: "",
                                                hintText: 'From Date',
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .purple.shade100),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            initialValue: fromdate.toString(),
                                            type: DateTimePickerType.date,

                                            //controller: fromDate,
                                            firstDate: DateTime(1995),
                                            lastDate: DateTime.now()
                                                .add(const Duration(days: 365)),
                                            // This will add one year from current date
                                            validator: (value) {
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                setState(() {
                                                  fromdate =
                                                      DateTime.parse(value);
                                                });
                                              }
                                            },
                                            // We can also use onSaved
                                            onSaved: (value) {
                                              if (value!.isNotEmpty) {
                                                fromdate =
                                                    DateTime.parse(value);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('To Date',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Center(
                                          child: DateTimePicker(
                                            decoration: InputDecoration(
                                                filled: true,
                                                //<-- SEE HERE
                                                fillColor: Colors.white,
                                                prefixIcon: const Icon(
                                                  Icons.arrow_right,
                                                  color: Colors.grey,
                                                ),
                                                counterText: "",
                                                hintText: 'From Date',
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .purple.shade100),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            initialValue: todate.toString(),
                                            type: DateTimePickerType.date,

                                            //controller: fromDate,
                                            firstDate: DateTime(1995),
                                            lastDate: DateTime.now()
                                                .add(const Duration(days: 365)),
                                            // This will add one year from current date
                                            validator: (value) {
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                setState(() {
                                                  todate =
                                                      DateTime.parse(value);
                                                });
                                              }
                                            },
                                            // We can also use onSaved
                                            onSaved: (value) {
                                              if (value!.isNotEmpty) {
                                                todate = DateTime.parse(value);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: TextFormField(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  scrollable: true,
                                                  title: const Text('Staffs'),
                                                  content: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: callHistory!
                                                        .data!
                                                        .staffList!
                                                        .length,
                                                    itemBuilder:
                                                        (context, ind) {
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            assignStaff =
                                                                callHistory!
                                                                    .data!
                                                                    .staffList![
                                                                        ind]
                                                                    .staffName
                                                                    .toString();
                                                            assignStaffId =
                                                                callHistory!
                                                                    .data!
                                                                    .staffList![
                                                                        ind]
                                                                    .userId
                                                                    .toString();
                                                            Navigator.pop(
                                                                context, true);
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: Text(
                                                            callHistory!
                                                                .data!
                                                                .staffList![ind]
                                                                .staffName
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
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
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            filled: true,
                                            //<-- SEE HERE
                                            fillColor: Colors.white,
                                            suffixIcon: const Icon(
                                              Icons.arrow_drop_down_circle,
                                              color: Colors.grey,
                                            ),
                                            counterText: "",
                                            hintText: assignStaff,
                                            isDense: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.purple.shade100),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        search = true;
                                        isSearch = true;
                                        getData();
                                      });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Text('Search',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            callHistory!.data!.callHistory!.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        callHistory!.data!.callHistory!.length,
                                    itemBuilder: (context, i) {
                                      return Column(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Center(
                                                    child: Text(
                                                  callHistory!.data!
                                                      .callHistory![i].date
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              )),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: callHistory!
                                                  .data!
                                                  .callHistory![i]
                                                  .history!
                                                  .length,
                                              itemBuilder: (context, ind) {
                                                return AudioItems(
                                                    callHistory!.data!.callHistory![i].history![ind].direction.toString(),
                                                    callHistory!.data!.callHistory![i].history![ind].time.toString(),
                                                    callHistory!.data!.callHistory![i].history![ind].isAttended!,
                                                    callHistory!.data!.callHistory![i].history![ind].calledTime.toString(),
                                                    callHistory!.data!.callHistory![i].history![ind].status.toString(),
                                                    callHistory!.data!.callHistory![i].history![ind].resourceURL.toString(),
                                                    callHistory!.data!.callHistory![i].history![ind].callDurationHr.toString(),
                                                    widget.accessCallRecord,
                                                    callHistory!.data!.callHistory![i].history![ind].clientName.toString(),
                                                    callHistory!.data!.callHistory![i].history![ind].leadCategory.toString(),
                                                    callHistory!
                                                        .data!
                                                        .callHistory![i]
                                                        .history![ind]
                                                        .callResult
                                                        .toString(),
                                                    callHistory!
                                                        .data!
                                                        .callHistory![i]
                                                        .history![ind]
                                                        .callHistoryImage
                                                        .toString(),
                                                    fromdate.toString(),
                                                    todate.toString(),
                                                    callHistory!
                                                        .data!.updateLead,
                                                    callHistory!
                                                        .data!.deleteLead,
                                                    callHistory!
                                                        .data!.cloudCall,
                                                    callHistory!
                                                        .data!
                                                        .callHistory![i]
                                                        .history![ind]
                                                        .callMasterId
                                                        .toString(),
                                                    widget.token,
                                                    widget.name,
                                                    widget.userId,);
                                              }),
                                        ],
                                      );
                                    })
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.55,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Image.asset(
                                            "assets/icons/nodatafound.png",
                                          ),
                                        ),
                                        const Text(
                                          'Result Not Found',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Whoops... this information is \n not available for a moment',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Dashboard(
                                                                widget.token)),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text('Go Back',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      )
                    : Center(
                  child: Lottie.asset('assets/main/loading.json',
                      fit: BoxFit.fill),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                )),
      ),
    );
  }
}

// ignore: must_be_immutable


