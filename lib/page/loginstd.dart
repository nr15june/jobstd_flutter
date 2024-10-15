import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobstd_flutter/controllers/student_controllers.dart';
import 'package:jobstd_flutter/providers/user_provider.dart';
import 'package:jobstd_flutter/models/student_model.dart';
import 'package:jobstd_flutter/page/webstd.dart';
import 'package:jobstd_flutter/page/registerstd.dart';

class LoginstdPage extends StatefulWidget {
  const LoginstdPage({super.key});

  @override
  State<LoginstdPage> createState() => _LoginstdPageState();
}

class _LoginstdPageState extends State<LoginstdPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // สร้าง GlobalKey สำหรับ Form
  final _studentService = StudentService(); // เปลี่ยนเป็น StudentService

  void _login(BuildContext context) async {
  if (_formKey.currentState!.validate()) {
    final studentModel = await _studentService.login(
        _usernameController.text, _passwordController.text);

    if (studentModel != null) { 
      Provider.of<UserProvider>(context, listen: false).onlogin(studentModel);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WebstdPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ths.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white
                  .withOpacity(0.6), // ปรับค่าความโปร่งใสที่นี่ (0.0-1.0)
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Form(
              key: _formKey, // ใส่ key สำหรับ Form
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'L O G I N',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _usernameController, // เพิ่ม controller
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อผู้ใช้';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _passwordController, // เพิ่ม controller
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterstdPage()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _login(context); // เรียกใช้ฟังก์ชัน _login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade100,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Login'),
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
