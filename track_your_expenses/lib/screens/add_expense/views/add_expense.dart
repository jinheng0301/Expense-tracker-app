import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:track_your_expenses/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:track_your_expenses/src/models/categories.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();

  List<String> categoriesIcon = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel',
  ];

  late Color categoryColor = Colors.white;
  String iconSelected = '';

  @override
  void initState() {
    // TODO: implement initState
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

  IconButton iconCategory(BuildContext context, double width, double height) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) {
            TextEditingController categoryNameController =
                TextEditingController();
            TextEditingController categoryIconController =
                TextEditingController();
            TextEditingController categoryColorController =
                TextEditingController();
            bool isExpanded = false;
            bool isLoading = false;

            return BlocProvider.value(
              value: context.read<CreateCategoryBloc>(),
              child: BlocListener<CreateCategoryBloc, CreateCategoryState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is CreateCategorySuccess) {
                    Navigator.of(context).pop();
                  } else if (state is CreateCategoryLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text('Create a Category'),
                      content: SizedBox(
                        width: width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: categoryNameController,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                hintText: 'Name',
                                fillColor: Colors.grey.shade300,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: categoryIconController,
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                hintText: 'Icon',
                                fillColor: Colors.grey.shade300,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    size: 20,
                                    FontAwesomeIcons.caretDown,
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            isExpanded
                                ? iconContainer(width, setState)
                                : Container(),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: categoryColorController,
                              onTap: () {
                                colorPickerDialog(context, height);
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                hintText: 'Color',
                                fillColor: categoryColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: height * 0.05,
                              child: isLoading == true
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        print(categoryColor);
                                        // create category object and pop
                                        Category category = Category(
                                          categoryId: Uuid().v1(),
                                          name: categoryNameController.text,
                                          totalExpenses: 0,
                                          icon: iconSelected,
                                          color: categoryColor.toString(),
                                        );
                                        context.read<CreateCategoryBloc>().add(
                                            CreateCategory(category as String));
                                        Navigator.of(context).pop();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      icon: Icon(
        size: 20,
        FontAwesomeIcons.caretDown,
        color: Colors.black,
      ),
    );
  }

  Container iconContainer(double width, StateSetter setState) {
    return Container(
      width: width,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: categoriesIcon.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(
                () {
                  iconSelected = categoriesIcon[index];
                },
              );
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconSelected == categoriesIcon[index]
                    ? Colors.blue
                    : Colors.white,
                border: Border.all(
                  width: 5,
                  color: Colors.grey.shade300,
                ),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/${categoriesIcon[index]}.png',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> colorPickerDialog(BuildContext context, double height) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ColorPicker(
                  pickerColor: Colors.blue,
                  onColorChanged: (value) {
                    categoryColor = value;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.05,
                  child: TextButton(
                    onPressed: () {
                      print(categoryColor);
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text('Add Expense'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add Expense',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: TextFormField(
                  controller: expenseController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    prefixIcon: Icon(
                      size: 20,
                      FontAwesomeIcons.dollarSign,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: width * 0.8,
                child: TextFormField(
                  readOnly: true,
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    fillColor: Colors.grey.shade300,
                    prefixIcon: Icon(
                      size: 20,
                      FontAwesomeIcons.list,
                      color: Colors.black,
                    ),
                    suffixIcon: iconCategory(context, width, height),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: width * 0.8,
                child: TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        Duration(days: 365),
                      ),
                    );

                    if (newDate != null) {
                      dateController.text =
                          DateFormat('dd/MM/yyyy').format(newDate);
                      selectDate = newDate;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Date',
                    fillColor: Colors.grey.shade300,
                    prefixIcon: Icon(
                      size: 20,
                      FontAwesomeIcons.timeline,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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
