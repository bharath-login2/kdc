import 'package:kdc_chitty_mainnew/models/userManagement/viewStaffModel.dart';
import 'package:kdc_chitty_mainnew/service/service.dart';
import '../../core/common.dart';
import '../../screens/homePage.dart';
import '../../screens/leadManagement/addLeads.dart';
import '../../screens/leadManagement/callHistoryPage.dart';
import '../../screens/userManagement/viewUsers.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  String token;
  bool? whatsappConfigaure;

  BottomNavigation(this.token, this.whatsappConfigaure, {super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  ViewStaffModel? viewStaff;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getStaffData();
  }

  getStaffData() async {
    setState(() {
      isLoading = true;
    });
    try {
      ViewStaffModel? staffData = await HttpService.viewStaffs(widget.token);
      setState(() {
        viewStaff = staffData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading staff: $e');
    }
  }

  void _permissionDialogue(BuildContext context, title) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Alert !!!'),
          content: const Text(
            'You have no permission to access the feature please contact the support team',
          ),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 55,
      //bottom navigation bar on scaffold
      color: const Color(0xFF406dbe),
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      //shape of notch

      //notche margin between floating button and bottom appbar
      child: Row(
        //children inside bottom appbar
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(widget.token),
                  ),
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.175,
                child: const Icon(Icons.home, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddLeads(widget.token, page: 'NavigationBar'),
                  ),
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.175,
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: InkWell(
              onTap: () async {
                String name = await Common.getSharedPref("name") ?? "";
                String userId = await Common.getSharedPref("userId") ?? "";
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CallHistoryPage(widget.token, name, userId, true),
                    ),
                  );
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.175,
                child: const Icon(Icons.call, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: InkWell(
              onTap: () {
                viewStaff!.data!.staffManagementPermission == true
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewUsers(widget.token),
                        ),
                      )
                    : _permissionDialogue(context, 'Designation List');
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.175,
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
