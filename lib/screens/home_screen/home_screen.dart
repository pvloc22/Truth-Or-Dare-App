import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truth_or_dare/constant.dart';
import 'package:truth_or_dare/models/question_models.dart';

import '../question_screen/list_item_question.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data> allData = [];
  final TextEditingController _titleTopic = TextEditingController();
  bool isLoading = true;

  bool isFileExists(String filePath) {
    File file = File(filePath);
    return file.existsSync();
  }

  Future<void> handlReadFilCustomer(bool isReset) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/dataCustomer.json';
    print(File(filePath).lengthSync().toString());
    if (!File('$filePath').existsSync() || File(filePath).lengthSync() == 1 || isReset) {
      readJsonFile('lib/assets/data.json')
          .then((_)=>{
        if(isReset || File(filePath).lengthSync() == 1){
          writeJsonFile()
        }
      });
    } else {
      readJsonFile('$filePath');
    }
  }

  Future<void> readJsonFile(String pathFile) async {
    try {
      final String response = await rootBundle.loadString(pathFile);
      final data = await json.decode(response);

      var list = data["Data"] as List<dynamic>;

      setState(() {
        allData.clear();
        allData = list.map((e) => Data.fromJson(e)).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error reading JSON file: $e");
    }
  }

  List<Map<String, dynamic>> dataListToJson(List<Data> dataList) {
    List<Map<String, dynamic>> jsonList = [];
    dataList.forEach((data) {
      jsonList.add(data.toJson());
    });
    return jsonList;
  }

  Future<void> writeJsonFile() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/dataCustomer.json';

      final file = File(filePath);
      List<Map<String, dynamic>> jsonDataList = dataListToJson(allData);
      final jsonData = jsonEncode({'Data': jsonDataList});
      await file.writeAsString(jsonData);
      print('Data written to file successfully');
    } catch (e) {
      print('Error writing to file: $e');
    }
  }

  Future<void> insertTopic() async {
    try {
      if (!_titleTopic.text.isEmpty) {
        Data dataNew = Data(
            id: allData.length,
            title: _titleTopic.text,
            dare: [], truth: []
        );
        int index = allData.length;
        setState(() {
          allData.insert(index, dataNew);
          _titleTopic.clear();
          writeJsonFile();
        });
      }
    } catch (e) {
      print("Error insert JSON file: $e");
    }
  }

  @override
  void initState() {
    isLoading = true;
    handlReadFilCustomer(false);
    super.initState();
  }

  Future<String> get _directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    print("directory path: " + directory.path);
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    showMessageDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: kPrimaryColor,
              title: const Text(
                'Thêm chủ đề mới',
                style: TextStyle(color: kTextWhiteColor),
              ),
              content: Container(
                padding: const EdgeInsets.only(
                    left: kDefaultPadding / 2, right: kDefaultPadding / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: kColorHidden.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _titleTopic,
                  scrollPadding: const EdgeInsets.all(kDefaultPadding / 2),
                  enabled: true,
                  cursorColor: kButtonColor,
                ),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kButtonColor,
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    onPressed: () {
                      insertTopic();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Thêm mới',
                      style: TextStyle(color: kTextWhiteColor),
                    ),
                  ),
                )
              ],
            ));

    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: kColorHidden.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: kButtonColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "Truth or Dare",
                  style: TextStyle(
                      color: kTextLightColor,
                      fontFamily: defaultFontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: kButtonColor,
                  ),
                  onPressed: () {
                    showMessageDialog(context);
                  },
                ),
              ],
            ),
          ),
          isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: allData.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.2,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ListItemQuestion(
                                            data: allData[index],
                                            writeJsonFile: writeJsonFile,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimaryColor,
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      allData[index].title!,
                                      style: const TextStyle(
                                        color: kTextWhiteColor,
                                        fontFamily: defaultFontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 3,
                            top: kDefaultPadding * 3),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kButtonColor,
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            onPressed: () {
                              setState(() {
                                handlReadFilCustomer(true);
                              });
                            },
                            child: const Center(
                              child: Text(
                                'Load lại dữ liệu ban đầu',
                                style: TextStyle(color: kTextWhiteColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
