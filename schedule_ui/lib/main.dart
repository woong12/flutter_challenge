import 'package:flutter/material.dart';

void main() {
  runApp(const Schedule());
}

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Colors.grey.shade900,
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 17,
                  right: 17,
                  top: 60,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      foregroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1466112928291-0903b80a9466?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1746&q=80",
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 17,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "MONDAY 16",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "TODAY",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 44,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 244, 54, 149),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Date(date: "17"),
                                SizedBox(width: 20),
                                Date(date: "18"),
                                SizedBox(width: 20),
                                Date(date: "19"),
                                SizedBox(width: 20),
                                Date(date: "20"),
                                SizedBox(width: 20),
                                Date(date: "21"),
                                SizedBox(width: 20),
                                Date(date: "22"),
                                SizedBox(width: 20),
                                Date(date: "23"),
                                SizedBox(width: 20),
                                Date(date: "24"),
                                SizedBox(width: 20),
                                Date(date: "25"),
                                SizedBox(width: 20),
                                Date(date: "26"),
                                SizedBox(width: 20),
                                Date(date: "27"),
                                SizedBox(width: 20),
                                Date(date: "28"),
                                SizedBox(width: 20),
                                Date(date: "29"),
                                SizedBox(width: 20),
                                Date(date: "30"),
                                SizedBox(width: 20),
                                Date(date: "31"),
                                SizedBox(width: 20),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      WorkCard(
                        startHour: "11",
                        endHour: "12",
                        startMinutes: "30",
                        endMinutes: "20",
                        firstWorkTag: "DESIGN",
                        lastWorkTag: "MEETING",
                        coworker1: "ALEX",
                        coworker2: "HELENA",
                        coworker3: "NANA",
                        moreCoworker: "",
                        bgColor: Color.fromARGB(255, 247, 252, 91),
                      ),
                      SizedBox(height: 8),
                      WorkCard(
                        startHour: "12",
                        endHour: "14",
                        startMinutes: "35",
                        endMinutes: "10",
                        firstWorkTag: "DAILY",
                        lastWorkTag: "PROJECT",
                        coworker1: "ME",
                        coworker2: "RICHARD",
                        coworker3: "CIRY",
                        moreCoworker: "+4",
                        bgColor: Color.fromARGB(255, 164, 118, 208),
                      ),
                      SizedBox(height: 8),
                      WorkCard(
                        startHour: "15",
                        endHour: "16",
                        startMinutes: "00",
                        endMinutes: "30",
                        firstWorkTag: "WEEKLY",
                        lastWorkTag: "PLANNING",
                        coworker1: "DEN",
                        coworker2: "NANA",
                        coworker3: "MARK",
                        moreCoworker: "",
                        bgColor: Color.fromARGB(255, 198, 239, 87),
                      ),
                      SizedBox(height: 8),
                      WorkCard(
                        startHour: "11",
                        endHour: "12",
                        startMinutes: "30",
                        endMinutes: "20",
                        firstWorkTag: "DESIGN",
                        lastWorkTag: "MEETING",
                        coworker1: "ALEX",
                        coworker2: "HELENA",
                        coworker3: "NANA",
                        moreCoworker: "",
                        bgColor: Color.fromARGB(255, 247, 252, 91),
                      ),
                      SizedBox(height: 8),
                      WorkCard(
                        startHour: "12",
                        endHour: "14",
                        startMinutes: "35",
                        endMinutes: "10",
                        firstWorkTag: "DAILY",
                        lastWorkTag: "PROJECT",
                        coworker1: "ME",
                        coworker2: "RICHARD",
                        coworker3: "CIRY",
                        moreCoworker: "+4",
                        bgColor: Color.fromARGB(255, 164, 118, 208),
                      ),
                      SizedBox(height: 8),
                      WorkCard(
                        startHour: "15",
                        endHour: "16",
                        startMinutes: "00",
                        endMinutes: "30",
                        firstWorkTag: "WEEKLY",
                        lastWorkTag: "PLANNING",
                        coworker1: "DEN",
                        coworker2: "NANA",
                        coworker3: "MARK",
                        moreCoworker: "",
                        bgColor: Color.fromARGB(255, 198, 239, 87),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Date extends StatelessWidget {
  final String date;
  const Date({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      date,
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        fontSize: 44,
      ),
    );
  }
}

class WorkCard extends StatelessWidget {
  final String startHour;
  final String endHour;
  final String startMinutes;
  final String endMinutes;
  final String firstWorkTag;
  final String lastWorkTag;
  final String coworker1;
  final String coworker2;
  final String coworker3;
  final String moreCoworker;
  final Color bgColor;

  const WorkCard({
    super.key,
    required this.startHour,
    required this.endHour,
    required this.startMinutes,
    required this.endMinutes,
    required this.firstWorkTag,
    required this.lastWorkTag,
    required this.coworker1,
    required this.coworker2,
    required this.coworker3,
    required this.moreCoworker,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 215,
      padding: const EdgeInsets.only(
        top: 32,
        left: 16,
        right: 16,
        bottom: 18,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                startHour,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                startMinutes,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                height: 25,
                width: 0.5,
                color: Colors.black,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                endHour,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                endMinutes,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topLeft,
              children: [
                Positioned(
                  top: -10,
                  child: Text(
                    firstWorkTag,
                    style: const TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Positioned(
                  top: 43,
                  child: Text(
                    lastWorkTag,
                    style: const TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Row(
                    children: [
                      Text(
                        coworker1,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        coworker2,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        coworker3,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        moreCoworker,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
