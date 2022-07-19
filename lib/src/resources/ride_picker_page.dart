import 'package:flutter/material.dart';

class RidePickerPage extends StatefulWidget {
  const RidePickerPage({Key? key}) : super(key: key);

  @override
  State<RidePickerPage> createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  var _addRessController;

  @override
  void initState() {
    _addRessController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.black12,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 60,
                        child: Center(
                          child: Icon(Icons.location_on),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        width: 40,
                        height: 60,
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                _addRessController.text = '';
                              },
                              icon: Icon(Icons.close)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 50),
                        child: TextField(
                          controller: _addRessController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (str) {},
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
