import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:kdc_chitty_mainnew/screens/clients/invoiceList.dart';
import 'package:kdc_chitty_mainnew/screens/clients/receiptList.dart';
import 'package:lottie/lottie.dart';

import '../../core/common.dart';
import '../../models/clients/receiptAddCommonDetailsModel.dart';
import '../../models/clients/receiptAddModel.dart';
import '../../service/service.dart';
import '../leadManagement/dashboard.dart';

class ReceiptAdd extends StatefulWidget {
  String token;
  String clientId;
  String invoiceId;
   ReceiptAdd(this.token,this.clientId,this.invoiceId,{Key? key}) : super(key: key);

  @override
  State<ReceiptAdd> createState() => _ReceiptAddState();
}

class _ReceiptAddState extends State<ReceiptAdd> {
  var fromdate = DateTime.now();
  ReceiptAddCommonDetailsModel? receiptDetails;
  bool result=true;
  dynamic collectedBy;
  dynamic paymentMethod;
  TextEditingController payAmount = TextEditingController();
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

    receiptDetails = await HttpService.receiptCommonDetails(widget.token,widget.clientId,widget.invoiceId);
    if (receiptDetails != null) {
      setState(() {});
    }

  }
  @override
  Widget build(BuildContext context) {
    return  result==true?
    WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InvoiceList(widget.token)),
        );
        return true;
      },
      child: Scaffold(
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
                                builder: (context) => InvoiceList(widget.token)),
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
                        'Receipt',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: receiptDetails!=null?
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        maxHeight: 60,
                        maxWidth: 60,
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
                        receiptDetails!.data!.name.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w500),
                      ),

                      Text(
                        'Receipt No: ${receiptDetails!.data!.displayRecNumber}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.w400),
                      ),
                      Text(
                        'Invoice No: ${receiptDetails!.data!.displayInvNumber}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text('Pay Date',
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
                          1,
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
              ),
              const SizedBox(height: 10,),
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
                        const Text('Collected By',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
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
                                      Text('Collected by'),
                                    ),
                                    value: collectedBy,
                                    items:receiptDetails!.data!.staff!.map((data) {
                                      return DropdownMenuItem(
                                        value: data.userId.toString(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Text(data.staffName.toString()),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged:
                                        (newValue1) {
                                      setState(() {
                                        collectedBy = newValue1;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
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
                        const Text('Payment Method',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
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
                                      Text('Payment Method'),
                                    ),
                                    value: paymentMethod,
                                    items:receiptDetails!.data!.paymentMethods!.map((data) {
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
                                        paymentMethod = newValue1;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    ),


                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(MediaQuery.of(context).size.width *
                        0.6), // Using 10%
                    1: FixedColumnWidth(MediaQuery.of(context).size.width *
                        0.4), // Using 30%

                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Color(0xFFece9fd),
                      ),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Particulars',
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Amount',
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(
                        MediaQuery.of(context).size.width *
                            0.6), // Using 10%
                    1: FixedColumnWidth(
                        MediaQuery.of(context).size.width *
                            0.4), // Using 30%

                  },
                  children: [
                    // Each TableRow represents a row in the Table
                    TableRow(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: const Color(0xFFF3F3F3),
                      ),
                      children:   [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            receiptDetails!.data!.particulars.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            receiptDetails!.data!.totalAmount.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(MediaQuery.of(context).size.width *
                        0.6), // Using 10%
                    1: FixedColumnWidth(MediaQuery.of(context).size.width *
                        0.4), // Using 30%

                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Color(0xFFece9fd),
                      ),
                      children:  [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Total Amount Due',
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(receiptDetails!.data!.amountDue.toString(),
                              style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(MediaQuery.of(context).size.width *
                        0.6), // Using 10%
                    1: FixedColumnWidth(MediaQuery.of(context).size.width *
                        0.4), // Using 30%

                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Color(0xFFece9fd),
                      ),
                      children:  [
                        const Padding(
                          padding: EdgeInsets.only(left: 8,right: 8,top: 15),
                          child: Text('Amount to Pay',
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width:
                            MediaQuery.of(context).size.width *
                                0.45,
                            child: TextFormField(
                              controller: payAmount,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10,top: 2,bottom: 2),
                                 // labelText: 'Amount',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Colors.grey)),
                            ),
                          ),
                        )

                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap: () async {

                  if(payAmount.text.isEmpty)
                  {
                    Common.toastMessaage(
                        'Type Valid pay amount',
                        Colors.red);
                  }
                  else if(int.parse(payAmount.text)>int.parse(receiptDetails!.data!.amountDue.toString()))
                    {
                      Common.toastMessaage(
                          'Maximum Amount to pay is ${receiptDetails!.data!.amountDue}',
                          Colors.red);
                    }
                  else{
                    if (context.mounted) {
                      Common.showProgressDialog(
                          context, "Loading..");
                    }
                    ReceiptAddModel object =
                        await HttpService.addReceipt(
                        widget.token,
                        widget.invoiceId,
                        widget.clientId,
                            receiptDetails!.data!.receiptNumber,
                        fromdate,
                        payAmount.text,
                        collectedBy,
                        paymentMethod);

                        if (object.data == true) {

                          Common.toastMessaage(
                              object.message, Colors.green);
                          {
                            if(mounted){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReceiptList(widget.token)),
                              );
                            }

                          }
                        }
                        else{
                          Common.toastMessaage(
                              object.message, Colors.red);
                        }
                  }
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
                    child: Text('Submit',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              const SizedBox(height: 30,),

            ],
          ),
        ):
        Center(
          child: Lottie.asset('assets/main/loading.json',
              fit: BoxFit.fill),
        ),

      ),
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
