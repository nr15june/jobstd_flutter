import 'package:flutter/material.dart';
import 'package:jobstd_flutter/controllers/student_controllers.dart';
import 'package:jobstd_flutter/page/loginstd.dart';
// import 'package:jobstd_flutter/page/webstd.dart';

class RegisterstdPage extends StatefulWidget {
  const RegisterstdPage({super.key});

  @override
  State<RegisterstdPage> createState() => _RegisterstdPageState();
}

class _RegisterstdPageState extends State<RegisterstdPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _programController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _yearofstudyController = TextEditingController();

  final _studentService = StudentService();

  Future<void> _register() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _facultyController.text.isEmpty ||
        _programController.text.isEmpty ||
        _sexController.text.isEmpty ||
        _yearofstudyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      print('Name:${_nameController.text}');
      print('Email:${_emailController.text}');
      print('Username:${_usernameController.text}');
      print('Password:${_passwordController.text}');
      print('Phone:${_phoneController.text}');
      print('Faculty:${_facultyController.text}');
      print('Program:${_programController.text}');
      print('Sex:${_sexController.text}');
      int? yearOfStudy = int.tryParse(_yearofstudyController.text);
    }

    try {
      final stud = StudentService().register(
          _nameController.text,
          _emailController.text,
          _usernameController.text,
          _passwordController.text,
          _facultyController.text,
          _facultyController.text,
          _programController.text,
          _sexController.text,
          int.tryParse(_yearofstudyController.text) ?? 0);
      if (stud != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginstdPage()),
        );
      } else {
        // ถ้าการลงทะเบียนล้มเหลว
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed')),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 30.0), // Padding from screen edges
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
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white, // Slightly transparent white
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Minimize size of the Column
                  children: [
                    Text(
                      'CREATE ACCOUNT !',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อ-นามสกุล',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อ-นามสกุล';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'email@tsu.ac.th',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกอีเมล';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                            .hasMatch(value)) {
                          return 'กรุณากรอกอีเมลให้ถูกต้อง';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อผู้ใช้',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อผู้ใช้';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'รหัสผ่าน',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'เบอร์โทรศัพท์',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกเบอร์โทรศัพท์';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _facultyController,
                      decoration: InputDecoration(
                        labelText: 'คณะ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกคณะ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _programController,
                      decoration: InputDecoration(
                        labelText: 'สาขา',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกสาขา';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _sexController,
                      decoration: InputDecoration(
                        labelText: 'เพศ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกเพศ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _yearofstudyController,
                      decoration: InputDecoration(
                        labelText: 'ชั้นปี',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชั้นปี';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Distribute space between buttons
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
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          child: Text('Back'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _register();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade100,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text('Send'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
