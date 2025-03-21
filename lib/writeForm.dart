import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class WriteForm extends StatelessWidget {
  const WriteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("할 일 추가"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _WriteForm(),
    );
  }
}

class _WriteForm extends StatefulWidget {
  const _WriteForm({super.key});

  @override
  State<_WriteForm> createState() => _WriteFormState();
}

class _WriteFormState extends State<_WriteForm> {
  //  상수
  static const String apiEndpoint = "http://54.180.89.36:18088/api/todos";

  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "할 일",
                  hintText: "할 일을 입력하세요",
                ),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  createTodo();
                },
                child: Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createTodo() async {
    try {
      // 요청
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      // POST 요청
      final response = await dio.post(
        apiEndpoint,
        data: {"title": _titleController.text, "completed": false},
      );

      //  응답
      if (response.statusCode == 201) {
        //CREATED
        //  목록 페이지로 돌아감
        Navigator.pop(context);
        // Navigator.pushNamed(context, "/");
      } else {
        throw Exception("할 일을 추가하지 못했습니다. ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("할 일을 추가하지 못했습니다.: $e");
    }
  }
}
