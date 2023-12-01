import 'package:latihan/formAdd.dart';
import 'package:latihan/repository.dart';
import 'package:latihan/tambah.dart';
import 'package:flutter/material.dart';
import 'package:latihan/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => MyHomePage(),
        '/add-blog': (context) => const AddBlog(),
        '/tambah': (context) => const tambahBlog(),
      },
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Blog> listBlog = [];
  Repository repository = Repository();

  getData() async {
    listBlog = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).popAndPushNamed('/tambah'),
          )
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).popAndPushNamed('/add-blog',arguments: [
                        listBlog[index].id,
                        listBlog[index].nama,
                        listBlog[index].kota,
                      ] ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listBlog[index].nama),
                        Text(listBlog[index].kota),
                      ],
                    ),
                  ),
                ),
                IconButton(onPressed: () async {
                  bool response = await repository.deleteData(listBlog[index].id);
                  if (response){
                    print('Delete data sukses');
                  }else{
                    print('Delete data gagal');
                  }
                  getData();
                }, icon: Icon(Icons.delete))
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: listBlog.length),
    );
  }
}