import 'package:flutter/material.dart';

void main() {
  runApp(AdminDashboard());
}

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Dashboard(),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationPanel(),
        Expanded(
          child: Column(
            children: [
              Header(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      TaskCard(company: 'Google', status: 'In Progress', progress: 25, total: 50, priority: 'High'),
                      TaskCard(company: 'Slack', status: 'Completed', progress: 30, total: 30, priority: 'Medium'),
                      MyTasks(),
                      Calendar(),
                      Messages(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NavigationPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.orange[100],
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          ListTile(title: Text('Projects')),
          ListTile(title: Text('My Task')),
          ListTile(title: Text('Calendar')),
          ListTile(title: Text('Time Manage')),
          ListTile(title: Text('Reports')),
          ListTile(title: Text('Settings')),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.orange[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Admin Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          CircleAvatar(backgroundImage: NetworkImage('https://via.placeholder.com/150')),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String company;
  final String status;
  final int progress;
  final int total;
  final String priority;

  TaskCard({required this.company, required this.status, required this.progress, required this.total, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(company, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Status: $status', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            LinearProgressIndicator(value: progress / total),
            SizedBox(height: 10),
            Text('Progress: $progress/$total', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Priority: $priority', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class MyTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(child: TaskItem(title: 'Create wireframe', completed: false)),
            Expanded(child: TaskItem(title: 'Slack Logo Design', completed: true)),
            Expanded(child: TaskItem(title: 'Dashboard Design', completed: false)),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String title;
  final bool completed;

  TaskItem({required this.title, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(completed ? Icons.check_circle : Icons.circle, color: completed ? Colors.green : Colors.grey),
        SizedBox(width: 10),
        Text(title, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calendar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            // Placeholder for calendar
            Container(height: 100, color: Colors.grey[200]),
          ],
        ),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Messages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            MessageItem(name: 'John Doe', message: 'Hi Angelina! How are you?'),
            MessageItem(name: 'Charmie', message: 'Do you need that design?'),
            MessageItem(name: 'Jason Mandela', message: 'What is the price of hourly...'),
          ],
        ),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final String name;
  final String message;

  MessageItem({required this.name, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(message, style: TextStyle(fontSize: 14, color: Colors.grey)),
        Divider(),
      ],
    );
  }
}
