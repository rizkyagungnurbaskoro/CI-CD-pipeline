//RIZKY AGUNG NURBASKORO
//213925

// Main App
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'custom_gauge.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Factory App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Factory App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int _selectedFactory = 1; // Default to Factory 1

  // Data for Factory 1
  List<Employee> factory1Employees = [];
  Map<String, dynamic> factory1Data = {
    'steamPressure': 100,
    'steamFlow': 20,
    'waterLevel': 50,
    'powerFrequency': 60,
  };
  Map<String, dynamic> factory1Thresholds = {
    'steamPressure': 90,
    'steamFlow': 15,
    'waterLevel': 40,
    'powerFrequency': 55,
  };

  // Data for Factory 2
  List<Employee> factory2Employees = [];
  Map<String, dynamic> factory2Data = {
    'steamPressure': 120,
    'steamFlow': 25,
    'waterLevel': 60,
    'powerFrequency': 58,
  };
  Map<String, dynamic> factory2Thresholds = {
    'steamPressure': 110,
    'steamFlow': 20,
    'waterLevel': 50,
    'powerFrequency': 50,
  };

  // Function to add an employee
  void _addEmployee(int factoryId, String name, String phoneNumber) {
    if (factoryId == 1) {
      setState(() {
        factory1Employees.add(Employee(name: name, phoneNumber: phoneNumber));
        print('Factory 1 Employees: $factory1Employees');
      });
    } else if (factoryId == 2) {
      setState(() {
        factory2Employees.add(Employee(name: name, phoneNumber: phoneNumber));
        print('Factory 2 Employees: $factory2Employees');
      });
    }
  }

  // Function to switch between factories
  void _switchFactory(int factoryId) {
    setState(() {
      _selectedFactory = factoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ProfilePage(
            factoryId: _selectedFactory,
            employees: _selectedFactory == 1
                ? factory1Employees
                : factory2Employees,
            onAddEmployee: (name, phoneNumber) =>
                _addEmployee(_selectedFactory, name, phoneNumber),
            switchFactory: _switchFactory,
          ),
          HomePage(
            factoryId: _selectedFactory,
            data: _selectedFactory == 1
                ? factory1Data
                : factory2Data,
            thresholds: _selectedFactory == 1
                ? factory1Thresholds
                : factory2Thresholds,
            switchFactory: _switchFactory,
          ),
          SettingsPage(
            factoryId: _selectedFactory,
            data: _selectedFactory == 1
                ? factory1Thresholds
                : factory2Thresholds,
            onDataChanged: (key, value) {
              if (_selectedFactory == 1) {
                setState(() {
                  factory1Thresholds[key] = value;
                });
              } else if (_selectedFactory == 2) {
                setState(() {
                  factory2Thresholds[key] = value;
                });
              }
            },
            switchFactory: _switchFactory,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

// Employee Class
class Employee {
  final String name;
  final String phoneNumber;

  Employee({required this.name, required this.phoneNumber});
}


class FactoryButtonBar extends StatelessWidget {
  final Function(int) switchFactory;

  const FactoryButtonBar({Key? key, required this.switchFactory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              switchFactory(1);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.factory),
                SizedBox(width: 8.0),
                Text('Factory 1'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              switchFactory(2);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.factory),
                SizedBox(width: 8.0),
                Text('Factory 2'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final int factoryId;
  final List<Employee> employees;
  final Function(String, String) onAddEmployee;
  final Function(int) switchFactory;

  const ProfilePage({
    Key? key,
    required this.factoryId,
    required this.employees,
    required this.onAddEmployee,
    required this.switchFactory,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controller for Name TextField
  final _nameController = TextEditingController();

  // Controller for Phone Number TextField
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory ${widget.factoryId} Employees', key: Key('profileTitle')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Factory ${widget.factoryId} Employees',
              key: Key('profileHeaderText'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.employees.length,
                itemBuilder: (context, index) {
                  final employee = widget.employees[index];
                  return Container(
                    key: Key('employee${employee.name}'),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${employee.name}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Phone Number: ${employee.phoneNumber}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Add Employee'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            key: Key('nameField'),
                            controller: _nameController,
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            key: Key('phoneField'),
                            controller: _phoneNumberController,
                            decoration: InputDecoration(labelText: 'Phone Number'),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a phone number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          print('Dialog canceled');
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('Form validated');
                            widget.onAddEmployee(_nameController.text, _phoneNumberController.text);
                            Navigator.of(context).pop();
                            print('Employee added: ${_nameController.text}, ${_phoneNumberController.text}');
                            _nameController.clear();
                            _phoneNumberController.clear();
                          } else {
                            print('Form validation failed');
                          }
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
            FactoryButtonBar(switchFactory: widget.switchFactory),
          ],
        ),
      ),
    );
  }
}

// HomePage
class HomePage extends StatelessWidget {
  final int factoryId;
  final Map<String, dynamic> data;
  final Map<String, dynamic> thresholds;
  final Function(int) switchFactory;

  const HomePage({
    Key? key,
    required this.factoryId,
    required this.data,
    required this.thresholds,
    required this.switchFactory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory $factoryId Status', key: Key('homeTitle')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '1549.7kW',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomGauge(
                        title: 'Steam Pressure',
                        value: data['steamPressure'].toDouble(),
                        unit: 'bar',
                        maxValue: thresholds['steamPressure'].toDouble(),
                      ),
                      CustomGauge(
                        title: 'Steam Flow',
                        value: data['steamFlow'].toDouble(),
                        unit: 'T/H',
                        maxValue: thresholds['steamFlow'].toDouble(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomGauge(
                        title: 'Water Level',
                        value: data['waterLevel'].toDouble(),
                        unit: '%',
                        maxValue: thresholds['waterLevel'].toDouble(),
                      ),
                      CustomGauge(
                        title: 'Power Frequency',
                        value: data['powerFrequency'].toDouble(),
                        unit: 'Hz',
                        maxValue: thresholds['powerFrequency'].toDouble(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '2024-04-26 13:45:25',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            FactoryButtonBar(switchFactory: switchFactory),
          ],
        ),
      ),
    );
  }
}



// Settings Page
class SettingsPage extends StatefulWidget {
  final int factoryId;
  final Map<String, dynamic> data;
  final Function(String, dynamic) onDataChanged;
  final Function(int) switchFactory;

  const SettingsPage({
    Key? key,
    required this.factoryId,
    required this.data,
    required this.onDataChanged,
    required this.switchFactory,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Controllers for TextFields
  final _steamPressureController = TextEditingController();
  final _steamFlowController = TextEditingController();
  final _waterLevelController = TextEditingController();
  final _powerFrequencyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _steamPressureController.text = widget.data['steamPressure'].toString();
    _steamFlowController.text = widget.data['steamFlow'].toString();
    _waterLevelController.text = widget.data['waterLevel'].toString();
    _powerFrequencyController.text = widget.data['powerFrequency'].toString();
  }

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Factory ${widget.factoryId} Settings'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Factory ${widget.factoryId} Settings',
            key: Key('settingsTitle'),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0, // Adjust the spacing between tiles
                  mainAxisSpacing: 16.0,
                ),
                itemCount: 4, // 2x2 grid, so 4 tiles
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return _buildSettingTile(
                        'Steam Pressure',
                        _steamPressureController,
                        (value) => widget.onDataChanged('steamPressure', value),
                      );
                    case 1:
                      return _buildSettingTile(
                        'Steam Flow',
                        _steamFlowController,
                        (value) => widget.onDataChanged('steamFlow', value),
                      );
                    case 2:
                      return _buildSettingTile(
                        'Water Level',
                        _waterLevelController,
                        (value) => widget.onDataChanged('waterLevel', value),
                      );
                    case 3:
                      return _buildSettingTile(
                        'Power Frequency',
                        _powerFrequencyController,
                        (value) => widget.onDataChanged('powerFrequency', value),
                      );
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ),
          FactoryButtonBar(switchFactory: widget.switchFactory),
        ],
      ),
    ),
  );
}

 Widget _buildSettingTile(String title, TextEditingController controller, Function(dynamic) onChanged) {
  return Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white, // Set a background color to prevent it from appearing all white
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            onChanged(double.tryParse(value) ?? 0.0);
          },
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(), // Add border to the TextFormField
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Adjust content padding
          ),
        ),
      ],
    ),
  );
}

  @override
  void dispose() {
    _steamPressureController.dispose();
    _steamFlowController.dispose();
    _waterLevelController.dispose();
    _powerFrequencyController.dispose();
    super.dispose();
  }
}

