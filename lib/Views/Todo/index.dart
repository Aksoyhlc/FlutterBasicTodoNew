import 'package:flutter/material.dart';
import 'package:todonew/Const/const.dart';
import 'package:todonew/Controllers/todo_controller.dart';
import 'package:todonew/Models/todo.dart';
import 'package:todonew/Views/Todo/Widgets/attach_list.dart';
import 'package:todonew/Views/Todo/create.dart';

class ToDos extends StatefulWidget {
  const ToDos({super.key});

  @override
  State<ToDos> createState() => _ToDosState();
}

class _ToDosState extends State<ToDos> {
  late Size size;
  final controller = ToDoController();
  List<ToDoModel> todos = [];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return ColoredBox(
      color: whiteColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,
          floatingActionButton: SizedBox(
            width: 75,
            height: 75,
            child: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePage(),
                  ),
                );
                setState(() {});
              },
              elevation: 10,
              backgroundColor: whiteColor,
              child: const Icon(
                Icons.add,
                size: 40,
                color: primaryColor,
              ),
            ),
          ),
          body: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: whiteColor.withOpacity(0.5),
                    offset: const Offset(0, 5),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        AttachList(size: size),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Builder(builder: (ctx) {
                            if (todos.isEmpty) {
                              return const Center(
                                child: Text(
                                  "Todos not found",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 25,
                                  ),
                                ),
                              );
                            }

                            return ListView.separated(
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 1,
                                  color: listDividerColor,
                                );
                              },
                              itemCount: todos.length,
                              itemBuilder: (context, index) {
                                var item = todos[index];
                                return InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CreatePage(todo: item),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: item.status == Status.success.name,
                                          onChanged: (value) async {
                                            await controller.changeStatus(item);
                                            setState(() {});
                                          },
                                        ),
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Text(
                                                item.title ?? "",
                                                style: TextStyle(
                                                  color: item.status == Status.pending.name
                                                      ? primaryColor
                                                      : primaryColor.withOpacity(.3),
                                                  fontSize: 15,
                                                ),
                                              ),
                                              if (item.status == Status.success.name)
                                                Positioned(
                                                  top: 0,
                                                  bottom: 0,
                                                  right: 0,
                                                  left: 0,
                                                  child: Center(
                                                    child: Container(
                                                      height: 1,
                                                      color: primaryColor.withOpacity(.2),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await controller.delete(item.id.toString());
                                            setState(() {});
                                          },
                                          child: const Icon(
                                            Icons.delete_forever_outlined,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  getData() async {
    todos = (await controller.getAll()).values.toList();
    todos = todos.reversed.toList();
    return true;
  }
}
