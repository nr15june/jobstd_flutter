import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobstd_flutter/page/webstd.dart';
import 'package:jobstd_flutter/page/updatestd.dart';
import 'package:jobstd_flutter/controllers/post_controllers.dart';
import 'package:jobstd_flutter/providers/user_provider.dart';
import 'package:jobstd_flutter/models/student_model.dart';
import 'package:jobstd_flutter/models/post_model.dart';

class ProfilestdPage extends StatefulWidget {
  const ProfilestdPage({super.key});

  @override
  State<ProfilestdPage> createState() => _ProfilestdPageState();
}

class _ProfilestdPageState extends State<ProfilestdPage> {
  final PostService _postService = PostService();
  List<PostModel> poststd = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final postList = await _postService
          .fetchPosts(userProvider); 
      setState(() {
        poststd = postList;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching posts: $e')));
    }
  }

  void _toUpdatePost(PostModel postModel) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdatestdPage(post: postModel),
      ),
    );
    if (result == true) {
      _fetchPosts();
    }
  }

Future<void> _deletePost(PostModel postModel) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm deletion'),
          content: Text(
              'Are you sure you want to delete ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await _postService.deletePost(postModel.id, userProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product deleted successfully!')),
        );
        _fetchPosts(); // อัปเดตข้อมูล
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting product: $e')),
        );
      }
    }
  }
  void _logout() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.onlogout();

    if (!userProvider.isAuthentication()) {
      print('logout successful');
    }

    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WebstdPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: _logout,
              ),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // ชื่อที่ด้านบน
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${userProvider.stu.name}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // เบอร์โทร
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เบอร์โทร ${userProvider.stu.phone}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // อีเมล
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'อีเมล ${userProvider.stu.email}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // คณะ
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'คณะ ${userProvider.stu.faculty}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // สาขา
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'สาขา ${userProvider.stu.program}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                //ชั้นปี
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชั้นปี ${userProvider.stu.yearofstudy}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: poststd.length,
                    itemBuilder: (context, index) {
                      final post = poststd[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${userProvider.stu.name}'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('ทักษะ  : ${post.stskill ?? 'ไม่ระบุ'}'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('ความสามารถ : ${post.stability}'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('เวลา  : ${post.stworktime}'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () => _toUpdatePost(post),
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    tooltip: 'Edit Product',
                                  ),
                                  IconButton(
                                    onPressed: () => _deletePost(post),
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Delete Product',
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
