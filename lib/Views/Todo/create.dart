import 'package:flutter/material.dart';
import 'package:todonew/Const/const.dart';
import 'package:todonew/Controllers/todo_controller.dart';
import 'package:todonew/Models/todo.dart';
import 'package:todonew/Views/Partials/input.dart';

import 'Widgets/attach_list.dart';
import 'Widgets/custom_app_bar.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key, this.todo});
  final ToDoModel? todo;

  @override
  State<CreatePage> createState() => _CreateState();
}

class _CreateState extends State<CreatePage> {
  ToDoModel todo = ToDoModel();
  final controller = ToDoController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      todo = widget.todo!;
    }
  }

  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return ColoredBox(
      color: whiteColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Column(
            children: [
              const CustomAppBar(),
              Flexible(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AttachList(size: size),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                            child: Column(
                              children: [
                                CustomInput(
                                  hintText: "Title",
                                  onChanged: (value) {
                                    todo.title = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Title cannot be empty";
                                    }
                                    return null;
                                  },
                                  initialValue: widget.todo?.title,
                                ),
                                const SizedBox(height: 10),
                                CustomInput(
                                  hintText: "Content",
                                  maxLines: 10,
                                  onChanged: (value) {
                                    todo.content = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Content cannot be empty";
                                    }
                                    return null;
                                  },
                                  initialValue: widget.todo?.content,
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      if (widget.todo == null) {
                                        todo.status = Status.pending.name;
                                        todo.id = DateTime.now().microsecondsSinceEpoch.toString();
                                        todo.createdAt = DateTime.now().toString();
                                      }

                                      todo.updatedAt = DateTime.now().toString();

                                      bool status = false;

                                      if (widget.todo == null) {
                                        status = await controller.create(todo);
                                      } else {
                                        status = await controller.update(todo);
                                      }

                                      if (status) {
                                        Navigator.pop(context);
                                      } else {
                                        print("HATA");
                                      }
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.save_outlined,
                                          color: whiteColor,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Save",
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
