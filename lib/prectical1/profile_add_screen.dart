import 'package:flutter/material.dart';
import 'package:prectical/main.dart';
import 'package:prectical/prectical1/profile_model.dart';
import 'package:prectical/prectical1/sql_database.dart';

class ProfileAddScreen extends StatefulWidget {
  final bool isEdit;
  ProfileModel? data;
  List<String> day;

  ProfileAddScreen(
      {super.key, this.isEdit = false, this.data, required this.day});

  @override
  State<ProfileAddScreen> createState() => _ProfileAddScreenState();
}

class _ProfileAddScreenState extends State<ProfileAddScreen> {
  late final TextEditingController txtName;
  late final TextEditingController txtEmail;
  late final TextEditingController txtMobile;
  late final TextEditingController txtDay;
  String txtDate = '';
  String nameValidation = '';
  String emailValidation = '';
  String mobileValidation = '';
  String dateValidation = '';
  String dayValidation = '';

  editData() {
    if (widget.isEdit) {
      txtName = TextEditingController(text: widget.data!.name);
      txtEmail = TextEditingController(text: widget.data!.email);
      txtMobile = TextEditingController(text: widget.data!.mobileNo);
      txtDay = TextEditingController(text: widget.data!.day);
      txtDate = widget.data!.date;
    } else {
      txtName = TextEditingController();
      txtEmail = TextEditingController();
      txtMobile = TextEditingController();
      txtDay = TextEditingController();
      txtDate = '';
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtName.dispose();
    txtMobile.dispose();
    txtEmail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: width / 16,
              color: Colors.black,
            ),
          ),
          title: Text('Registration',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: width / 17)),
          centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              textField('Name', 'Enter Name', Icons.person_2_outlined, false,
                  txtName, nameValidation, (value) {
                if (txtName.text.isEmpty) {
                  nameValidation = snackBar('Enter name');
                } else {
                  nameValidation = '';
                }
                setState(() {});
              }),
              textField('Email', 'Enter Email', Icons.email_outlined, false,
                  txtEmail, emailValidation, (value) {
                if (txtEmail.text.isEmpty ||
                    txtEmail.text.contains('@gmail.com') == false) {
                  emailValidation = snackBar('Enter Valid Email');
                } else {
                  emailValidation = '';
                }
              }),
              textField('Mobile No.', 'Enter Mobile', Icons.call_outlined, true,
                  txtMobile, mobileValidation, (value) {
                if (txtMobile.text.isEmpty || txtMobile.text.length != 10) {
                  mobileValidation = snackBar('Enter valid mobile');
                } else {
                  mobileValidation = '';
                }
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: textStyle(
                        textColor: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? selectDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030));
                        txtDate =
                            '${selectDate!.day}/${selectDate.month}/${selectDate.year}';
                        if (txtDate.isEmpty) {
                          dateValidation = snackBar('Enter valid mobile');
                        } else {
                          dateValidation = '';
                        }
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: height / 17,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: dateValidation.isNotEmpty
                                ? Border.all(color: Colors.red, width: 1)
                                : Border.all(color: Colors.black, width: 0.3)),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              txtDate,
                              style: textStyle(textColor: Colors.black),
                            ),
                            Icon(Icons.calendar_month_outlined,
                                color: Colors.black, size: width / 18)
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: dateValidation.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          dateValidation,
                          style: textStyle(textColor: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Day',
                      style: textStyle(textColor: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    /*Container(
                      height: height / 17,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: dayValidation.isNotEmpty
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.black, width: 0.3)),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          // underline: const SizedBox(),
                          dropdownColor: Colors.white,
                          alignment: Alignment.centerLeft,
                          hint: Text(
                            txtDay,
                            style: textStyle(
                              textColor: Colors.black,
                            ),
                          ),
                          onChanged: (value) {},
                          items: widget.day
                              .map(
                                (e) =>
                                    menuItem(label: e, value: e.toLowerCase()),
                              )
                              .toList()),
                    ),*/
                    widget.day.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: SizedBox(
                              height: height / 17,
                              child: TextField(
                                  onSubmitted: (value) {
                                    if (txtDay.text.isEmpty) {
                                      dayValidation = snackBar('Enter day');
                                    } else {
                                      dayValidation = '';
                                    }
                                  },
                                  controller: txtDay,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Enter Day',
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: dayValidation.isNotEmpty
                                              ? const BorderSide(
                                                  color: Colors.red, width: 1)
                                              : const BorderSide(
                                                  color: Colors.black,
                                                  width: 0.3)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 1)))),
                            ),
                          )
                        : SizedBox(
                            height: height / 17,
                            child: DropdownMenu(
                                expandedInsets:
                                    const EdgeInsets.symmetric(vertical: 8),
                                enableFilter: true,
                                requestFocusOnTap: true,
                                dropdownMenuEntries: widget.day
                                    .map((e) => DropdownMenuEntry(
                                        value: e.toLowerCase(), label: e))
                                    .toList(),
                                controller: txtDay,
                                onSelected: (value) {
                                  txtDay.text = value!;
                                  if (txtDay.text.isEmpty) {
                                    dayValidation = snackBar('Enter day');
                                  } else {
                                    dayValidation = '';
                                  }
                                  setState(() {});
                                },
                                enabled: true,
                                menuStyle: MenuStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                inputDecorationTheme: InputDecorationTheme(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: dayValidation.isNotEmpty
                                            ? const BorderSide(
                                                color: Colors.red, width: 1)
                                            : const BorderSide(
                                                color: Colors.black,
                                                width: 0.3)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 1)))),
                          ),
                    Visibility(
                      visible: dayValidation.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          dayValidation,
                          style: textStyle(textColor: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  bool isSubmit = true;
                  if (txtName.text.isEmpty) {
                    nameValidation = snackBar('Enter name');
                    isSubmit = false;
                  } else {
                    nameValidation = '';
                  }
                  if (txtEmail.text.isEmpty ||
                      txtEmail.text.contains('@gmail.com') == false) {
                    emailValidation = snackBar('Enter Valid Email');
                    isSubmit = false;
                  } else {
                    emailValidation = '';
                  }
                  if (txtMobile.text.isEmpty || txtMobile.text.length != 10) {
                    mobileValidation = snackBar('Enter valid mobile');
                    isSubmit = false;
                  } else {
                    mobileValidation = '';
                  }
                  if (txtDate.isEmpty) {
                    dateValidation = snackBar('Enter date');
                    isSubmit = false;
                  } else {
                    dateValidation = '';
                  }
                  if (txtDay.text.isEmpty) {
                    dayValidation = snackBar('Enter day');
                    isSubmit = false;
                  } else {
                    dayValidation = '';
                  }

                  if (isSubmit) {
                    loader(context);
                    if (widget.isEdit) {
                      SqlDataBase.sqlDataBase.update(ProfileModel(
                          email: txtEmail.text,
                          name: txtName.text,
                          day: txtDay.text,
                          date: txtDate,
                          mobileNo: txtMobile.text,
                          profileId: widget.data!.profileId));
                    } else {
                      SqlDataBase.sqlDataBase.insertProfile(ProfileModel(
                          email: txtEmail.text,
                          name: txtName.text,
                          day: txtDay.text,
                          date: txtDate,
                          mobileNo: txtMobile.text));
                    }
                    nameValidation = '';
                    mobileValidation = '';
                    emailValidation = '';
                    dateValidation = '';
                    dayValidation = '';
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // snackBar('Insert successfully');
                  }
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: height / 17,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Add Detail',
                    style: textStyle(textColor: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  snackBar(String msg) {
    return msg;
  }

  Widget textField(
      String label,
      String hintText,
      IconData icon,
      bool isNUmber,
      TextEditingController controller,
      String validationTxt,
      void Function(String) onSubmit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textStyle(textColor: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: SizedBox(
              height: height / 17,
              child: TextField(
                  onSubmitted: onSubmit,
                  controller: controller,
                  keyboardType: !isNUmber ? null : TextInputType.phone,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: hintText,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: validationTxt.isNotEmpty
                              ? const BorderSide(color: Colors.red, width: 1)
                              : const BorderSide(
                                  color: Colors.black, width: 0.3)),
                      prefixIcon:
                          Icon(icon, color: Colors.black, size: width / 18),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 1)))),
            ),
          ),
          Visibility(
            visible: validationTxt.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                validationTxt,
                style: textStyle(textColor: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle textStyle({Color? textColor}) {
    return TextStyle(
        color: textColor ?? Colors.black,
        fontSize: width / 25,
        fontWeight: FontWeight.w400);
  }
}

loader(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      ));
    },
  );
}
