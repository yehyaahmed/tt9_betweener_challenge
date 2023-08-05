import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/add_link.dart';

import '../constants.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? _user;
  late Future<Follow> follow;

  @override
  void initState() {
    follow = getFollow(context);
    super.initState();
    _loadCounter();

  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('user')) {
      setState(() {
        _user = userFromJson(prefs.getString('user') ?? '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _user == null
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Center(
                      child: Text(
                    'Profile',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 36,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  "https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg"),
                            ),
                            SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _user!.user!.name!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  _user!.user!.email!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  _user!.user!.email!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    FutureBuilder(
                                      future: follow,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: kSecondaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Text(
                                              'followers ${snapshot.data?.followersCount}',
                                              style: TextStyle(
                                                fontSize: 8,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          );
                                        }else{
                                          return Text('loading');
                                        }
                                      },
                                    ),
                                    SizedBox(width: 5),

                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Add_Link.id);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: kPrimaryColor,
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 48),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
      ),
    );
  }
}
