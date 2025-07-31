import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(RobotArmApp());

class RobotArmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot Arm Control',
      home: RobotArmControlPage(),
    );
  }
}

class RobotArmControlPage extends StatefulWidget {
  @override
  _RobotArmControlPageState createState() => _RobotArmControlPageState();
}

class _RobotArmControlPageState extends State<RobotArmControlPage> {
  double motor1 = 90;
  double motor2 = 90;
  double motor3 = 90;
  double motor4 = 90;

  List<Map<String, dynamic>> savedPoses = [];

  void savePose() async {
    final uri = Uri.parse('http://127.0.0.1/robot_arm/save_pose.php');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'motor1': motor1.toInt().toString(),
          'motor2': motor2.toInt().toString(),
          'motor3': motor3.toInt().toString(),
          'motor4': motor4.toInt().toString(),
          'status': '1',
        },
      );

      print('RESPONSE: ${response.body}');
      setState(() {
        savedPoses.add({
          'motor1': motor1.toInt(),
          'motor2': motor2.toInt(),
          'motor3': motor3.toInt(),
          'motor4': motor4.toInt(),
          'status': 1,
        });
      });
    } catch (e) {
      print('ERROR: $e');
    }
  }

  void updateStatus(int poseId) {
    http.get(
      Uri.parse('http://127.0.0.1/robot_arm/update_status.php?id=$poseId'),
    );
  }

  void resetMotors() {
    setState(() {
      motor1 = 90;
      motor2 = 90;
      motor3 = 90;
      motor4 = 90;
    });
  }

  Widget _buildSlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toInt()}'),
        Slider(
          min: 0,
          max: 180,
          divisions: 180,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Robot Arm Control Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSlider('Motor 1', motor1, (v) => setState(() => motor1 = v)),
            _buildSlider('Motor 2', motor2, (v) => setState(() => motor2 = v)),
            _buildSlider('Motor 3', motor3, (v) => setState(() => motor3 = v)),
            _buildSlider('Motor 4', motor4, (v) => setState(() => motor4 = v)),
            Row(
              children: [
                ElevatedButton(
                  onPressed: savePose,
                  child: Text('Save Pose'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetMotors,
                  child: Text('Reset'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // لتنفيذ الوضعيات لاحقًا
                  },
                  child: Text('Run'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Saved Poses:'),
            Expanded(
              child: ListView.builder(
                itemCount: savedPoses.length,
                itemBuilder: (context, index) {
                  final pose = savedPoses[index];
                  return ListTile(
                    title: Text(
                        'Pose ${index + 1}: ${pose['motor1']}, ${pose['motor2']}, ${pose['motor3']}, ${pose['motor4']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            // لتشغيل الوضعية
                            },
                        ),
                        IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: () {
                            updateStatus(index + 1);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}