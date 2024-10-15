import 'package:flutter/material.dart';
import 'package:jobstd_flutter/controllers/post_controllers.dart';
import 'package:jobstd_flutter/models/post_model.dart';
import 'package:jobstd_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PoststdPage extends StatefulWidget {
  const PoststdPage({super.key});

  @override
  State<PoststdPage> createState() => _PoststdPageState();
}

class _PoststdPageState extends State<PoststdPage> {
  final _formKey = GlobalKey<FormState>();
  final PostService _postService = PostService();

  String _stskill = '';
  String _stability = '';
  String _stworktime = '';


  void _AddPost() async {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final NewPost = PostModel(
          stskill: _stskill,
          stability: _stability,
          stworktime: _stworktime,
          id: ''  // อย่าลืมตั้งค่า id ให้ถูกต้องเมื่อมี
          );
      try {
        await _postService.addPost(NewPost, userProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post added successfully!')),
        );
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding post: $e')),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 40.0), // เพิ่ม padding
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade50,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Form(
              key: _formKey, // ผูกฟอร์มกับ GlobalKey
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'CREATE POST',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ทักษะ',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                            _stskill = value;
                          },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกทักษะ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ความสามารถ',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                            _stability = value;
                          },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกความสามารถ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'เวลา',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                            _stworktime = value;
                          },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกเวลา';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // กลับไปยังหน้าเข้าสู่ระบบ
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade100,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        child: Text('Back'),
                      ),
                      ElevatedButton(
                         onPressed: _AddPost,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade100,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        child: Text('Confirm'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
