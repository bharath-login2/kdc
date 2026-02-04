import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:kdc_chitty_mainnew/models/clients/deleteMainClientModel.dart';
import 'package:kdc_chitty_mainnew/screens/clients/addInvoice.dart';
import 'package:kdc_chitty_mainnew/screens/clients/clientDetails.dart';
import 'package:kdc_chitty_mainnew/screens/homePage.dart';
import 'package:kdc_chitty_mainnew/screens/userManagement/viewUsers.dart';
import 'package:lottie/lottie.dart';

import '../../core/common.dart';
import '../../models/clients/mainClientListModel.dart';
import '../../service/service.dart';
import '../leadManagement/dashboard.dart';
import 'addClients.dart';
import 'editClient.dart';

class ClientList extends StatefulWidget {
  String token;
  ClientList(this.token,{Key? key}) : super(key: key);

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  MainClientListModel? mainClients;
  bool result=true;
  TextEditingController searchkey =  TextEditingController();
  bool  isSearch=false;
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

    mainClients = await HttpService.mainClients(widget.token,searchkey.text);
    if (mainClients != null) {
      setState(() {
        isSearch=false;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return result==true?
    WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(widget.token)),
        );
        return true;
      },
      child: Scaffold(
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
                        'Client List',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddClients(widget.token)),
                      );
                    },
                    elevation: 1.0,
                    fillColor: Colors.white,
                    shape: const CircleBorder(),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: mainClients!=null && isSearch==false?
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10,),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 40,
                    decoration: BoxDecoration(
                        boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),],
                        borderRadius: BorderRadius.circular(5), color: Colors.white),
                    child: TextField(
                        style:
                        const TextStyle(color: Colors.black),
                        controller: searchkey,
                        autofocus: true,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Search',
                            filled: true,
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search, color: Colors.black),
                            suffixIcon:  IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                searchkey.clear();
                              },
                            ))),
                  ),
                  const SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isSearch=true;
                        getData();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.23,
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
              const SizedBox(height: 15,),
              mainClients!.data!.isNotEmpty ?
              ListView.builder(
                  shrinkWrap: true,
                  itemCount:mainClients!.data!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClientDetails(widget.token,mainClients!.data![index].id.toString())),
                        );
                      },

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
                                                   mainClients!.data![index].clientName.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    mainClients!.data![index].phoneNumber.toString(),
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
                                              const Icon(Icons.location_on_outlined),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                mainClients!.data![index].location.toString(),
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
                                     const SizedBox(height: 10,),
                                     InkWell(
                                       onTap: (){
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                               builder: (context) => EditClients(widget.token,mainClients!.data![index].id.toString())),
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
                                             child: Icon(
                                               Icons.edit,
                                               color: Colors.blue,
                                               size: 18,
                                             ),
                                           )),
                                     ),
                                     const SizedBox(height: 5,),
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
                                                         DeleteMainClientModel deleteClients=await HttpService.deleteMainClients(widget.token,mainClients!.data![index].id.toString());
                                                         if (deleteClients.data ==
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
                                                                   builder:
                                                                       (context) =>
                                                                       ClientList(
                                                                           widget.token)),
                                                             );
                                                           }
                                                         }
                                                         else {
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
                                               BorderRadius
                                                   .circular(5),
                                               border: Border.all(
                                                   color: Colors.red)),
                                           child: const Padding(
                                             padding: EdgeInsets.only(left: 7,right: 7,top: 7,bottom: 7),
                                             child: Icon(
                                               Icons.delete,
                                               color: Colors.red,
                                               size: 18,
                                             ),
                                           )),
                                     ),
                                     const SizedBox(height: 5,),
                                     InkWell(
                                       onTap: (){
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                               builder: (context) => AddInvoice(widget.token,mainClients!.data![index].id.toString())),
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
                                             child: Icon(
                                               Icons.payment,
                                               color: Colors.green,
                                               size: 18,
                                             ),
                                           )),
                                     ),
                                     const SizedBox(height: 5,),
                                   ],
                                                               ),
                                )
                              ],
                            ),
                          ),
                        ));
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
          ),
        )
            :Center(
          child: Lottie.asset('assets/main/loading.json',
              fit: BoxFit.fill),
        )
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
