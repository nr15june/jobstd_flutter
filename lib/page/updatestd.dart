import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobstd_flutter/models/post_model.dart';
import 'package:jobstd_flutter/controllers/post_controllers.dart';
import 'package:jobstd_flutter/providers/user_provider.dart';
class UpdatestdPage extends StatefulWidget {
  final PostModel post; // เพิ่มการประกาศ post ที่นี่

  const UpdatestdPage({super.key, required this.post}); // เก็บ post

  @override
  State<UpdatestdPage> createState() => _UpdatestdPageState();
}

class _UpdatestdPageState extends State<UpdatestdPage> {
  final _formKey = GlobalKey<FormState>();
  final PostService _postService = PostService();
  
  late String _stskill ;
  late String _stability ;
  late String _stworktime ;
  
  @override
  void initState(){
    super.initState();
    _stskill = widget.post.stskill;
    _stability = widget.post.stability;
    _stworktime = widget.post.stworktime;
  }

  void _UpdatePost() async {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final updatePost = PostModel(
          stskill: widget.post.stskill,
          stability: widget.post.stability,
          stworktime: widget.post.stworktime,
          id: widget.post.id);

      try {
        await _postService.updatePost(updatePost, userProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post updated successfully!')),
        );
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating post: $e')),
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
                    initialValue: _stskill,
                    decoration: InputDecoration(
                      labelText: 'ทักษะ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกทักษะ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: _stability,
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
                    initialValue: _stworktime,
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
                          Navigator.pop(context); 
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
                         onPressed: _UpdatePost,
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