import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UpiPaymentScreen extends StatefulWidget {
  @override
  _UpiPaymentScreenState createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  String payeeName = '';
  String upiId = '';
  double amount = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'qeventz UPI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 2, 108, 57),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/green1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: _buildInfoBox("Payee Name", payeeName, Icons.person, (value) {
                    setState(() {
                      payeeName = value;
                    });
                  }),
                ),
                SizedBox(height: 20),
                FadeTransition(
                  opacity: _animation,
                  child: _buildInfoBox("Enter UPI ID", upiId, Icons.payment, (value) {
                    setState(() {
                      upiId = value;
                    });
                  }),
                ),
                SizedBox(height: 20),
                FadeTransition(
                  opacity: _animation,
                  child: _buildInfoBox("Amount", amount.toString(), null, (value) {
                    setState(() {
                      amount = double.tryParse(value) ?? 0.0;
                    });
                  }),
                ),
                SizedBox(height: 30),
                ScaleTransition(
                  scale: _animation,
                  child: ElevatedButton(
                    onPressed: () {
                      _showDynamicQRCode(upiId, amount);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: Color.fromARGB(255, 2, 108, 57),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      child: Text(
                        'Generate QR Code',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String title, String value, IconData? icon, Function(String) onChanged) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 2, 108, 57)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: Colors.black,
            ),
            SizedBox(width: 8),
          ] else ...[
            Text(
              '₹',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 8),
          ],
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Color.fromARGB(255, 2, 108, 57)),
              decoration: InputDecoration(
                labelText: title,
                labelStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  void _showDynamicQRCode(String upiId, double amount) {
    String transactionNote = 'Wedding Gift';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Generated QR Code',
            style: TextStyle(color: Colors.black),
          ),
          content: Container(
            width: 200,
            height: 200,
            child: QrImageView(
              data: 'upi://pay?pn=$payeeName&pa=$upiId&tn=$transactionNote&am=$amount',
              version: QrVersions.auto,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}