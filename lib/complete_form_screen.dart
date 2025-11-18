import 'package:flutter/material.dart';

class CompleteFormScreen extends StatefulWidget {
  @override
  _CompleteFormScreenState createState() => _CompleteFormScreenState();
}

class _CompleteFormScreenState extends State<CompleteFormScreen> {
  // Controllers
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final age = TextEditingController();

  // Dropdown Values
  String? gender;
  String? country;

  // Date & Time
  DateTime? birthDate;
  TimeOfDay? preferredTime;

  // Sliders
  double satisfaction = 3.0;
  double progress = 50.0;
  RangeValues budget = RangeValues(20, 80);

  // Preferences
  bool subscribe = false;
  bool agree = false;

  // Reset Form
  void resetForm() {
    setState(() {
      fullName.clear();
      email.clear();
      password.clear();
      phone.clear();
      age.clear();
      gender = null;
      country = null;
      birthDate = null;
      preferredTime = null;
      satisfaction = 3.0;
      progress = 50.0;
      budget = RangeValues(20, 80);
      subscribe = false;
      agree = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Form Example"),
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------- PERSONAL INFO ----------------//
            Text(
              "Personal Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Full Name
            TextField(
              controller: fullName,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Full Name *",
                hintText: "Please enter your name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            // Email
            TextField(
              controller: email,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: "Email Address *",
                hintText: "Please enter your email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            // Password
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: "Password *",
                hintText: "Please enter a password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            // Phone
            TextField(
              controller: phone,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            // Age
            TextField(
              controller: age,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.cake),
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 25),

            //---------------- DEMOGRAPHICS ----------------//
            Text(
              "Demographics",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Gender
            DropdownButtonFormField(
              value: gender,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.transgender),
                labelText: "Select your gender",
              ),
              items: [
                "Male",
                "Female",
                "Other",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => gender = val),
            ),
            SizedBox(height: 15),

            // Country
            DropdownButtonFormField(
              value: country,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
                labelText: "Select your country",
              ),
              items: [
                "Yemen",
                "Saudi Arabia",
                "Egypt",
                "UAE",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => country = val),
            ),
            SizedBox(height: 25),

            //---------------- DATE & TIME ----------------//
            Text(
              "Date & Time",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      setState(() => birthDate = picked);
                    },
                    child: Text(
                      birthDate == null
                          ? "Birth Date"
                          : birthDate.toString().split(" ")[0],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() => preferredTime = picked);
                    },
                    child: Text(
                      preferredTime == null
                          ? "Preferred Time"
                          : preferredTime!.format(context),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            //---------------- RATINGS ----------------//
            Text(
              "Ratings & Preferences",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            Text("Satisfaction Rating: ${satisfaction.toStringAsFixed(1)}"),
            Slider(
              value: satisfaction,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (val) => setState(() => satisfaction = val),
            ),

            SizedBox(height: 10),
            Text("Progress Level: ${progress.toStringAsFixed(0)}%"),
            Slider(
              value: progress,
              min: 0,
              max: 100,
              onChanged: (val) => setState(() => progress = val),
            ),

            SizedBox(height: 10),
            Text(
              "Budget Range: \$${budget.start.toInt()} - \$${budget.end.toInt()}",
            ),
            RangeSlider(
              values: budget,
              min: 0,
              max: 200,
              onChanged: (val) => setState(() => budget = val),
            ),

            SizedBox(height: 25),

            //---------------- PREFERENCES ----------------//
            Text(
              "Preferences",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            SwitchListTile(
              title: Text("Subscribe to Newsletter"),
              subtitle: Text("Receive updates and promotions"),
              value: subscribe,
              onChanged: (val) => setState(() => subscribe = val),
            ),

            CheckboxListTile(
              title: Text("I agree to the Terms and Conditions"),
              subtitle: Text("You must agree to proceed"),
              value: agree,
              onChanged: (val) => setState(() => agree = val!),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (!agree) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You must agree to continue")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Form Submitted Successfully")),
                  );
                }
              },
              child: Text("Submit Form"),
            ),

            TextButton(onPressed: resetForm, child: Text("Reset Form")),
          ],
        ),
      ),
    );
  }
}
