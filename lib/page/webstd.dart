import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jobstd_flutter/controllers/post_controllers.dart';
import 'package:jobstd_flutter/models/post_model.dart';
import 'package:jobstd_flutter/page/poststd.dart'; // นำเข้าหน้า PoststdPage
import 'package:jobstd_flutter/page/profilestd.dart'; // นำเข้าหน้า ProfilestdPage
import 'package:provider/provider.dart';
import 'package:jobstd_flutter/providers/user_provider.dart';

class WebstdPage extends StatefulWidget {
  const WebstdPage({super.key});

  @override
  State<WebstdPage> createState() => _WebstdPageState();
}

class _WebstdPageState extends State<WebstdPage> {
  final PostService _postService = PostService();
  List<PostModel> poststd = [];

  Future<void> _fetchPosts() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final postList = await _postService
          .fetchPosts(userProvider); // เปลี่ยนจาก productList เป็น postList
      setState(() {
        poststd = postList;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching posts: $e')));
    }
  }

  void _toAddPost() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PoststdPage(),
      ),
    );
    if (result == true) {
      _fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              width: 250,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilestdPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _toAddPost,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Row(
                  // ใช้ Row เพื่อจัดตำแหน่ง
                  children: [
                    Padding(
                      // เพิ่ม Padding รอบๆ ข้อความ
                      padding: const EdgeInsets.only(
                          left: 8.0), // ระยะห่างทางด้านซ้าย
                      child: Text(
                        'โพสต์....', // ข้อความในกล่อง
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
