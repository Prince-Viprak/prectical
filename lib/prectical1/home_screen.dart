import 'package:flutter/material.dart';
import 'package:prectical/main.dart';
import 'package:prectical/prectical1/profile_add_screen.dart';
import 'package:prectical/prectical1/profile_model.dart';
import 'package:prectical/prectical1/sql_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProfileModel> profileList = [];
  List<String> dayList = [];
  String selectDay = '';

  Future<void> readData() async {
    selectDay = '';
    profileList.clear();
    profileList = await SqlDataBase.sqlDataBase.read();
    profileList.map((e) {
      if(dayList.where((element) => element.toLowerCase()==e.day.toLowerCase()).isEmpty)
        {
          dayList.add(e.day);
        }
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          title: Text('View Detail',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width / 17,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileAddScreen(day: dayList))).then(
                    (value) {
                      readData();
                    },
                  );
                },
                child: Icon(
                  Icons.add,
                  size: width / 15,
                  color: Colors.black,
                ),
              ),
            )
          ]),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    dayBox('sunday', 'S', selectDay == 'sunday'),
                    dayBox('monday', 'M', selectDay == 'monday'),
                    dayBox('tuesday', 'T', selectDay == 'tuesday'),
                    dayBox('wednesday', 'W', selectDay == 'wednesday'),
                    dayBox('thursday', 'T', selectDay == 'thursday'),
                    dayBox('friday', 'F', selectDay == 'friday'),
                    dayBox('saturday', 'S', selectDay == 'saturday'),
                  ]),
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${profileList[index].name}',
                              style: textStyle()),
                          const SizedBox(height: 8),
                          Text('Mobile No: ${profileList[index].mobileNo}',
                              style: textStyle()),
                          const SizedBox(height: 8),
                          Text('Email: ${profileList[index].email}',
                              style: textStyle()),
                          const SizedBox(height: 8),
                          Text('Date: ${profileList[index].date}',
                              style: textStyle()),
                          Row(
                            children: [
                              Text('Day: ${profileList[index].day}',
                                  style: textStyle()),
                              const Spacer(),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileAddScreen(day: dayList,
                                                  isEdit: true,
                                                  data: profileList[index]),
                                        )).then((value) {
                                      readData();
                                    });
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: width / 20,
                                      child: Icon(Icons.edit,
                                          color: Colors.white,
                                          size: width / 20))),
                              const SizedBox(width: 8),
                              InkWell(
                                  onTap: () {
                                    SqlDataBase.sqlDataBase.delete(
                                        profileList[index]
                                            .profileId
                                            .toString());
                                    readData();
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.pink,
                                      radius: width / 20,
                                      child: Icon(Icons.delete,
                                          color: Colors.white,
                                          size: width / 20))),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: profileList.length),
            ),
          ],
        ),
      )),
    );
  }

  Widget dayBox(String value, String tag, bool isSelect) {
    return InkWell(
      onTap: () async {
        profileList = await SqlDataBase.sqlDataBase.readFilter(value.toLowerCase());
        selectDay = value;
        setState(() {});
      },
      child: Container(
        height: width / 12,
        width: width / 12,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: !isSelect ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(2)),
        child: Text(tag,
            style: TextStyle(
                color: !isSelect ? Colors.black : Colors.white,
                fontSize: width / 28,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  TextStyle textStyle() {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.w400, fontSize: width / 25);
  }
}
