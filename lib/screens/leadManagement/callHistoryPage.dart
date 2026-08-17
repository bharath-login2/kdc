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

  CallHistoryPage(
    this.token,
    this.name,
    this.userId,
    this.accessCallRecord, {
    super.key,
  });

  @override
  State<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends State<CallHistoryPage> {
  CallHistoryModel? callHistory;
  var fromdate = DateTime.now();
  var todate = DateTime.now();
  String assignStaff = 'Assign Staff';
  String assignStaffId = '';
  String direction = 'Direction';
  String directionValue = '';
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
      widget.token,
      assignStaffId,
      fromdate,
      todate,
      directionValue,
    );
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Dashboard(widget.token),
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
                                'Call History',
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
                body: callHistory != null && isSearch == false
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'From Date',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF406dbe),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            DateTimePicker(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.grey.shade50,
                                                prefixIcon: const Icon(
                                                  Icons.date_range,
                                                  color: Color(0xFF406dbe),
                                                  size: 20,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 0,
                                                    ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .grey
                                                            .shade300,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                              ),
                                              initialValue: fromdate.toString(),
                                              type: DateTimePickerType.date,
                                              firstDate: DateTime(1995),
                                              lastDate: DateTime.now().add(
                                                const Duration(days: 365),
                                              ),
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  setState(() {
                                                    fromdate = DateTime.parse(
                                                      value,
                                                    );
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'To Date',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF406dbe),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            DateTimePicker(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.grey.shade50,
                                                prefixIcon: const Icon(
                                                  Icons.date_range,
                                                  color: Color(0xFF406dbe),
                                                  size: 20,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 0,
                                                    ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .grey
                                                            .shade300,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                              ),
                                              initialValue: todate.toString(),
                                              type: DateTimePickerType.date,
                                              firstDate: DateTime(1995),
                                              lastDate: DateTime.now().add(
                                                const Duration(days: 365),
                                              ),
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  setState(() {
                                                    todate = DateTime.parse(
                                                      value,
                                                    );
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                  ),
                                                  title: const Text(
                                                    'Select Staff',
                                                  ),
                                                  content: SizedBox(
                                                    width: double.maxFinite,
                                                    child: ListView.separated(
                                                      shrinkWrap: true,
                                                      itemCount: callHistory!
                                                          .data!
                                                          .staffList!
                                                          .length,
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              const Divider(),
                                                      itemBuilder: (context, ind) {
                                                        return ListTile(
                                                          title: Text(
                                                            callHistory!
                                                                .data!
                                                                .staffList![ind]
                                                                .staffName
                                                                .toString(),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              assignStaff =
                                                                  callHistory!
                                                                      .data!
                                                                      .staffList![ind]
                                                                      .staffName
                                                                      .toString();
                                                              assignStaffId =
                                                                  callHistory!
                                                                      .data!
                                                                      .staffList![ind]
                                                                      .userId
                                                                      .toString();
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            });
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.shade50,
                                            hintText: assignStaff,
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: Color(0xFF406dbe),
                                              size: 20,
                                            ),
                                            suffixIcon: const Icon(
                                              Icons.keyboard_arrow_down,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 0,
                                                ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormField(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                  ),
                                                  title: const Text(
                                                    'Direction',
                                                  ),
                                                  content: SizedBox(
                                                    width: double.maxFinite,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ListTile(
                                                          title: const Text(
                                                            'Incoming',
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              direction =
                                                                  'Incoming';
                                                              directionValue =
                                                                  'Inbound';
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            });
                                                          },
                                                        ),
                                                        const Divider(),
                                                        ListTile(
                                                          title: const Text(
                                                            'Outgoing',
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              direction =
                                                                  'Outgoing';
                                                              directionValue =
                                                                  'Outbound';
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.shade50,
                                            hintText: direction,
                                            prefixIcon: const Icon(
                                              Icons.swap_calls,
                                              color: Color(0xFF406dbe),
                                              size: 20,
                                            ),
                                            suffixIcon: const Icon(
                                              Icons.keyboard_arrow_down,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 0,
                                                ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        search = true;
                                        isSearch = true;
                                        getData();
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF2a86c9),
                                            Color(0xFF406dbe),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(
                                              0xFF406dbe,
                                            ).withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Search',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                1,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  callHistory!
                                                      .data!
                                                      .callHistory![i]
                                                      .date
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
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
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .direction
                                                    .toString(),
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .time
                                                    .toString(),
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .isAttended!,
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .calledTime
                                                    .toString(),
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .status
                                                    .toString(),
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .resourceURL
                                                    .toString(),
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .callDurationHr
                                                    .toString(),
                                                widget.accessCallRecord,
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .clientName
                                                    .toString(),
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .leadCategory
                                                    .toString(),
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
                                                callHistory!.data!.updateLead,
                                                callHistory!.data!.deleteLead,
                                                callHistory!.data!.cloudCall,
                                                callHistory!
                                                    .data!
                                                    .callHistory![i]
                                                    .history![ind]
                                                    .callMasterId
                                                    .toString(),
                                                widget.token,
                                                widget.name,
                                                widget.userId,
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
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
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Whoops... this information is \n not available for a moment',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        const SizedBox(height: 25),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(
                                              context,
                                            ).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Dashboard(widget.token),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
                                          },
                                          child: Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.4,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Go Back',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
