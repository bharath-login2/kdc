
import 'package:accordion/accordion.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:kdc_chitty_mainnew/screens/clients/receiptList.dart';
import 'package:lottie/lottie.dart';
import '../../core/common.dart';
import '../../models/clients/customerListModel.dart';
import '../../models/clients/deleteInvoiceModel.dart';
import '../../models/clients/invoiceListModel.dart';
import '../../service/service.dart';
import '../homePage.dart';
import '../leadManagement/dashboard.dart';
import 'addInvoice.dart';
import 'addReceipt.dart';
import 'editInvoice.dart';

class InvoiceList extends StatefulWidget {
  String token;
   InvoiceList(this.token,{Key? key}) : super(key: key);
   @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  var fromdate = DateTime.now();
  var todate = DateTime.now();
  dynamic client;
  String? newClient;
  InvoiceListModel? invoiceList;
  CustomerListModel? customerList;
  bool result=true;
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

    invoiceList = await HttpService.invoiceList(widget.token,fromdate.toString(),todate.toString(),client);
    if (invoiceList != null) {
      customerList=await HttpService.customerList(widget.token);
      setState(() {});
    }

  }
  @override
  Widget build(BuildContext context) {
    return result==true?
    Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: const BoxDecoration(
            gradient:
            LinearGradient(colors: [Color(0xFF2a86c9), Color(0xFF406dbe)]),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 10.0, bottom: 10.0),
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
                              builder: (context) => HomePage(widget.token)),
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
                      'Invoice List',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
      body: invoiceList!=null && customerList!=null?
      SingleChildScrollView(

        child: Column(
          children: [
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ReceiptList(widget.token!)),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 40,
                      decoration:  BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border:Border.all(color: Colors.green.shade900,width: 2)),
                      child:  const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.list),
                          SizedBox(width: 10,),
                          Text('Receipt List',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      showGeneralDialog(
                        barrierLabel: "showGeneralDialog",
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.6),
                        transitionDuration:
                        const Duration(milliseconds: 400),
                        context: context,
                        pageBuilder: (context, _, __) {
                          return StatefulBuilder(
                              builder: (context, setState) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: SingleChildScrollView(
                                    child: AlertDialog(
                                      content: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Client  Details',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .grey.shade900,
                                                    width:
                                                    0),
                                                color: Colors
                                                    .white,
                                                borderRadius: const BorderRadius
                                                    .all(
                                                    Radius.circular(5))),
                                            child:
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton<
                                                  String>(
                                                isExpanded:
                                                true,
                                                hint:
                                                const Padding(
                                                  padding:
                                                  EdgeInsets.only(left: 20),
                                                  child:
                                                  Text('Client'),
                                                ),
                                                value: newClient,
                                                items:customerList!.data!.map((data) {
                                                  return DropdownMenuItem(
                                                    value: data.id.toString(),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 20),
                                                      child: Text(data.name.toString()),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged:
                                                    (newValue1) {
                                                  setState(() {
                                                    newClient = newValue1;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (newClient==null) {
                                                Common.toastMessaage(
                                                    'Choose Client',
                                                    Colors.red);
                                              }
                                              else
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => AddInvoice(widget.token,newClient!)),
                                                );
                                              }


                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                    Colors.green,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        5)),
                                                child: const Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      left: 25,
                                                      right: 25),
                                                  child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        transitionBuilder:
                            (_, animation1, __, child) {
                          return SlideTransition(
                            position: Tween(
                              begin: const Offset(0, 1),
                              end: const Offset(0, 0),
                            ).animate(animation1),
                            child: child,
                          );
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 40,
                      decoration:  BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border:Border.all(color: Colors.green.shade900,width: 2)),
                      child:  const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_outline),
                          SizedBox(width: 10,),
                          Text('Add Invoice',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
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
                                contentPadding: const EdgeInsets.all(3),
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
                                contentPadding: const EdgeInsets.all(3),
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
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.45,
                    child: FormField<
                        String>(
                      builder: (FormFieldState<
                          String>
                      state) {
                        return Container(
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.43,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors
                                      .grey.shade900,
                                  width:
                                  0),
                              color: Colors
                                  .white,
                              borderRadius: const BorderRadius
                                  .all(
                                  Radius.circular(5))),
                          child:
                          DropdownButtonHideUnderline(
                            child: DropdownButton<
                                String>(
                              isExpanded:
                              true,
                              hint:
                              const Padding(
                                padding:
                                EdgeInsets.only(left: 20),
                                child:
                                Text('Client'),
                              ),
                              value: client,
                              items:customerList!.data!.map((data) {
                                return DropdownMenuItem(
                                  value: data.id.toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(data.name.toString()),
                                  ),
                                );
                              }).toList(),
                              onChanged:
                                  (newValue1) {
                                setState(() {
                                  client = newValue1;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // search = true;
                        // isSearch = false;
                        // Common.showProgressDialog(
                        //     context, "Loading..");
                        getData();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.45,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text('Search',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            invoiceList!.data!.isNotEmpty?
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

              headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              children:
              List.generate(
                invoiceList!.data!.length,
                    (i) =>
                    AccordionSection(
                      isOpen: true,
                      header:    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(invoiceList!.data![i].customerName.toString(),style: const TextStyle(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 3,),
                          Text(invoiceList!.data![i].invoiceNumber.toString(),style: const TextStyle(
                              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 3,),
                          Text('Invoice Date: ${invoiceList!.data![i].invoiceDate}',style: const TextStyle(
                              color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal)),
                          const SizedBox(height: 3,),
                          Text('Status:  ${invoiceList!.data![i].status}',style: const TextStyle(
                              color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal)),

                        ],
                      ),
                      content:   Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('Total Amount : ₹  ${invoiceList!.data![i].totalAmount}/-', style: const TextStyle(
                              color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal)),
                           Text('Paid Amount : ₹ ${invoiceList!.data![i].totalPaid}/-', style: const TextStyle(
                              color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal)),
                           Text('Balance Amount : ₹ ${invoiceList!.data![i].balance}/-', style: const TextStyle(
                              color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal)),
                           Text('Paid Method : ${invoiceList!.data![i].paymentMode}', style: const TextStyle(
                              color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal)),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditInvoice(widget.token,invoiceList!.data![i].id.toString(),invoiceList!.data![i].clientId.toString())),
                                  );
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(5),
                                        border: Border.all(
                                            color: Colors.blue)),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 7,right: 7,top: 7,bottom: 7),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                            size: 18,
                                          ),
                                          SizedBox(width: 5,),
                                          Text('edit',style: TextStyle(
                                              color: Colors.blue, fontSize: 14, fontWeight: FontWeight.normal))
                                        ],
                                      ),
                                    )),
                              ),
                              InkWell(
                                onTap: (){
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
                                                  Common.showProgressDialog(
                                                      context, "Loading..");
                                                  DeleteInvoiceModel deleteInvoice=await HttpService.deleteInvoice(widget.token,invoiceList!.data![i].id);
                                                  if (deleteInvoice.data ==
                                                      true) {
                                                    Common.toastMessaage(
                                                        deleteInvoice
                                                            .message,
                                                        Colors.green);
                                                    if (context
                                                        .mounted) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                InvoiceList(
                                                                    widget.token)),
                                                      );
                                                    }
                                                  }
                                                  else {
                                                    Common.toastMessaage(
                                                        deleteInvoice
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
                                        BorderRadius
                                            .circular(5),
                                        border: Border.all(
                                            color: Colors.red)),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 7,right: 7,top: 7,bottom: 7),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                          SizedBox(width: 5,),
                                          Text('Delete',style: TextStyle(
                                              color: Colors.red, fontSize: 14, fontWeight: FontWeight.normal))

                                        ],
                                      ),
                                    )),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReceiptAdd(widget.token,invoiceList!.data![i].clientId.toString(),invoiceList!.data![i].id.toString())),
                                  );
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(5),
                                        border: Border.all(
                                            color: Colors.green)),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 7,right: 7,top: 7,bottom: 7),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.payment,
                                            color: Colors.green,
                                            size: 18,
                                          ),
                                          SizedBox(width: 5,),
                                          Text('Payment',style: TextStyle(
                                              color: Colors.green, fontSize: 14, fontWeight: FontWeight.normal))

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
          ],
        ),
      ): Center(
        child: Lottie.asset('assets/main/loading.json',
            fit: BoxFit.fill),
      )
    ):

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
