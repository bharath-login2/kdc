import 'package:accordion/accordion.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/common.dart';
import '../../models/clients/deleteMainClientModel.dart';
import '../../models/clients/mainClientDetailsModel.dart';
import '../../service/service.dart';
import '../leadManagement/dashboard.dart';
import 'addInvoice.dart';
import 'addReceipt.dart';
import 'clientList.dart';
import 'editClient.dart';

class ClientDetails extends StatefulWidget {
  String token;
  String clientId;

  ClientDetails(this.token, this.clientId, {Key? key}) : super(key: key);

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  int selectedIndex = 0;
  MainClientDetailsModel? mainClientDetail;
  bool result = true;

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
    mainClientDetail =
        await HttpService.mainClientDetails(widget.token, widget.clientId);
    if (mainClientDetail != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return result==true?Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                                builder: (context) => ClientList(widget.token)),
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
                        'Client Details',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: mainClientDetail != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 10),
                      child: InkWell(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2.0, 2.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 10, left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //     'F. NUMBER  : ${_callLogEntries.elementAt(indexStaff).formattedNumber}'),
                                        // Text(
                                        //     'C.M. NUMBER: ${_callLogEntries.elementAt(indexStaff).cachedMatchedNumber}'),
                                        Row(
                                          children: [
                                            Container(
                                              constraints: const BoxConstraints(
                                                maxHeight: 60,
                                              ),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 20,
                                                  minWidth: 20,
                                                  maxHeight: 50,
                                                  maxWidth: 50,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 0),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 5,
                                                        offset: Offset(1, 1)),
                                                  ],
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  image: const DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          'assets/main/avatar.png')),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  mainClientDetail!.data!.name
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  mainClientDetail!
                                                      .data!.contactNo
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.location_on_outlined),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.6,
                                              child: Text(
                                                mainClientDetail!.data!.address
                                                    .toString(),overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.arrow_right),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.6,
                                              child: Text(
                                                'GST:${mainClientDetail!.data!.gstNum}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.arrow_right),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.6,
                                              child: Text(
                                                'Pincode:${mainClientDetail!.data!.pincode}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditClients(widget.token,widget.clientId)),
                                        );
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.blue)),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 7,
                                                bottom: 7),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                              size: 18,
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                scrollable: true,
                                                title: const Text(
                                                    'Please Confirm'),
                                                content: const Text(
                                                    'Are you sure to Delete?'),
                                                actions: [
                                                  // The "Yes" button
                                                  TextButton(
                                                      onPressed: () async {
                                                        Common
                                                            .showProgressDialog(
                                                                context,
                                                                "Loading..");
                                                        DeleteMainClientModel
                                                            deleteClients =
                                                            await HttpService
                                                                .deleteMainClients(
                                                                    widget
                                                                        .token,
                                                                    widget
                                                                        .clientId);
                                                        if (deleteClients
                                                                .data ==
                                                            true) {
                                                          Common.toastMessaage(
                                                              deleteClients
                                                                  .message,
                                                              Colors.green);
                                                          if (context.mounted) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ClientDetails(
                                                                          widget
                                                                              .token,
                                                                          widget
                                                                              .clientId)),
                                                            );
                                                          }
                                                        } else {
                                                          Common.toastMessaage(
                                                              deleteClients
                                                                  .message,
                                                              Colors.red);
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        }
                                                      },
                                                      child: const Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('No'))
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.red)),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 7,
                                                bottom: 7),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddInvoice(widget.token,widget
                                                      .clientId)),
                                        );
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.green)),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 7,
                                                bottom: 7),
                                            child: Icon(
                                              Icons.payment,
                                              color: Colors.green,
                                              size: 18,
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * .35,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: selectedIndex == 0
                                            ? Colors.grey
                                            : Colors.white,
                                        width: 0),
                                    color: selectedIndex == 0
                                        ? const Color(0xFFd5f5f4)
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Projects',
                                        style: TextStyle(
                                          color: selectedIndex == 0
                                              ? const Color(0xFF3c9f9a)
                                              : const Color(0xFF717171),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * .35,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: selectedIndex == 1
                                            ? Colors.grey
                                            : Colors.white,
                                        width: 0),
                                    color: selectedIndex == 1
                                        ? const Color(0xFFd5f5f4)
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Invoice',
                                        style: TextStyle(
                                          color: selectedIndex == 1
                                              ? const Color(0xFF3c9f9a)
                                              : const Color(0xFF717171),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  selectedIndex = 2;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * .35,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: selectedIndex == 2
                                            ? Colors.grey
                                            : Colors.white,
                                        width: 0),
                                    color: selectedIndex == 2
                                        ? const Color(0xFFd5f5f4)
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Receipts',
                                        style: TextStyle(
                                          color: selectedIndex == 2
                                              ? const Color(0xFF3c9f9a)
                                              : const Color(0xFF717171),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    selectedIndex == 1
                        ? Container(
                          child: mainClientDetail!.data!.invoice!.isNotEmpty?
                          Accordion(
                              headerBorderColor: Colors.blueGrey,
                              headerBorderColorOpened: Colors.transparent,
                              // headerBorderWidth: 1,
                              headerBackgroundColorOpened: Colors.green,
                              contentBackgroundColor: Colors.white,
                              contentBorderColor: Colors.green,
                              contentBorderWidth: 3,
                              contentHorizontalPadding: 10,
                              scaleWhenAnimating: true,
                              openAndCloseAnimation: true,
                              disableScrolling: true,
                              headerPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              children: List.generate(
                                mainClientDetail!.data!.invoice!.length,
                                (i) => AccordionSection(
                                  isOpen: true,
                                  header: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${mainClientDetail!.data!.invoice![i].invoiceNumber}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                          'Invoice Date: ${mainClientDetail!.data!.invoice![i].invoiceDate}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                          'Status: ${mainClientDetail!.data!.invoice![i].status}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Total Amount : ₹ ${mainClientDetail!.data!.invoice![i].totalAmount}/-',
                                          style: const TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                      Text(
                                          'Paid Amount : ₹ ${mainClientDetail!.data!.invoice![i].paidAmount}/-',
                                          style: const TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                      Text(
                                          'Balance Amount : ₹ ${mainClientDetail!.data!.invoice![i].balanceAmount}/-',
                                          style: const TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                      Text(
                                          'Paid Method : ${mainClientDetail!.data!.invoice![i].paymentMethod}',
                                          style: const TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 7,
                                                    right: 7,
                                                    top: 7,
                                                    bottom: 7),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.edit,
                                                      color: Colors.blue,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('edit',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .normal))
                                                  ],
                                                ),
                                              )),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      scrollable: true,
                                                      title: const Text(
                                                          'Please Confirm'),
                                                      content: const Text(
                                                          'Are you sure to Delete?'),
                                                      actions: [
                                                        // The "Yes" button
                                                        TextButton(
                                                            onPressed: () async {
                                                              Common
                                                                  .showProgressDialog(
                                                                      context,
                                                                      "Loading..");
                                                              DeleteMainClientModel
                                                                  deleteClients =
                                                                  await HttpService
                                                                      .deleteMainClients(
                                                                          widget
                                                                              .token,
                                                                          mainClientDetail!
                                                                              .data!
                                                                              .id);
                                                              if (deleteClients
                                                                      .data ==
                                                                  true) {
                                                                Common.toastMessaage(
                                                                    deleteClients
                                                                        .message,
                                                                    Colors.green);
                                                                if (context
                                                                    .mounted) {
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            ClientList(
                                                                                widget.token)),
                                                                  );
                                                                }
                                                              } else {
                                                                Common.toastMessaage(
                                                                    deleteClients
                                                                        .message,
                                                                    Colors.red);
                                                                if (context
                                                                    .mounted) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Yes')),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                const Text('No'))
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    border: Border.all(
                                                        color: Colors.red)),
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 7,
                                                      right: 7,
                                                      top: 7,
                                                      bottom: 7),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                        size: 18,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text('Delete',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReceiptAdd(widget.token,widget.clientId,mainClientDetail!.data!.invoice![i].invid.toString())),
                                              );
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    border: Border.all(
                                                        color: Colors.green)),
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 7,
                                                      right: 7,
                                                      top: 7,
                                                      bottom: 7),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.payment,
                                                        color: Colors.green,
                                                        size: 18,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text('Payment',
                                                          style: TextStyle(
                                                              color: Colors.green,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ):
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:180,height: 180,
                                  child: Image.asset(
                                    "assets/icons/nodatafound.png",
                                  ),
                                ),
                                const Text('No Data Found',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ),
                        )
                        : const SizedBox(),
                    selectedIndex == 2
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              mainClientDetail!.data!.receipts!.isNotEmpty?ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      mainClientDetail!.data!.receipts!.length,
                                  itemBuilder: (context, ind) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Receipt No : ${mainClientDetail!.data!.receipts![ind].receiptNumber}',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        'Invoice No : ${mainClientDetail!.data!.receipts![ind].invoiceNumber}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        'Date : ${mainClientDetail!.data!.receipts![ind].receiptDate}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        'Collected By : ${mainClientDetail!.data!.receipts![ind].collectedBy}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors
                                                            .grey.shade300),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Column(
                                                        children: [
                                                          const Text('₹',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .green)),
                                                          Text(
                                                              '${mainClientDetail!.data!.receipts![ind].paidAmount}',
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .green)),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.blue)),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 7,
                                                                right: 7,
                                                                top: 7,
                                                                bottom: 7),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.blue,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text('edit',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal))
                                                          ],
                                                        ),
                                                      )),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              scrollable: true,
                                                              title: const Text(
                                                                  'Please Confirm'),
                                                              content: const Text(
                                                                  'Are you sure to Delete?'),
                                                              actions: [
                                                                // The "Yes" button
                                                                TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        'Yes')),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            'No'))
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .red)),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 7,
                                                                  right: 7,
                                                                  top: 7,
                                                                  bottom: 7),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                                size: 18,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text('Delete',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal))
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .amber)),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 7,
                                                                right: 7,
                                                                top: 7,
                                                                bottom: 7),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.print,
                                                              color:
                                                                  Colors.amber,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text('Print',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .amber,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal))
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }):
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:180,height: 180,
                                      child: Image.asset(
                                        "assets/icons/nodatafound.png",
                                      ),
                                    ),
                                    const Text('No Data Found',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
              )
            : Center(
                child:
                    Lottie.asset('assets/main/loading.json', fit: BoxFit.fill),
              )):
    Scaffold(
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
        ));
  }
}
