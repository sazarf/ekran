import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ekran/widgets/xlog.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:ekran/ports/ports.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  String por = "Com1";
  String baund = "4800";
  List<String> logs = {"1", "2"}.toList();
  var availablePorts = [];


  @override
  void initState() {
    super.initState();
    initPorts();
  }

  void initPorts() {
    setState(() => availablePorts = SerialPort.availablePorts);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deneme Port COM"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // SETTING ...........................................................
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: const [
                      Text("Port"),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("Bound"),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      DropdownButton(
                          value: por,
                          items: <String>['Com1', 'Com2', 'Com3']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              por = value.toString();
                            });
                          }),
                      const SizedBox(
                        height: 5.0,
                      ),
                      DropdownButton(
                          value: baund,
                          items: <String>['4800', '9600', '115200']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              baund = value.toString();
                            });
                          }),
                      const SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Find Ports")),
                      const SizedBox(height: 5.0),
                      ElevatedButton(
                          onPressed: () {
                            // if (port != null) {
                            //   //port.config.baudRate = 4800;
                            //   port.openReadWrite();
                            //   var config = SerialPortConfig();
                            //   config.baudRate = 4800;
                            //   port.config = config;
                            //   SerialPortReader(
                            //     port,
                            //   ).stream.listen((data) {
                            //     String str = String.fromCharCodes(data);
                            //     print('received: $data, str=$str');
                            //   }, onError: (error) {
                            //     print('hata olustu');
                            //     print(error);
                            //   }, onDone: () {
                            //     print('ondone');
                            //   });
                            // }
                          },
                          child: const Text("Connect")),
                      const SizedBox(height: 5.0),
                      ElevatedButton(
                          onPressed: () {
                            // if (port != null) {
                            //   port.close();
                            // } else {
                            //   print("Kapanamdı....");
                            // }
                          },
                          child: const Text("Disconnect")),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // TX ...............................................................
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: const [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Type the data to be sent.',
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    width: 1.0,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // if (port != null) {
                            //   String sendData = "Merhaba";
                            //   port.write(
                            //       Uint8List.fromList(sendData.codeUnits));
                            // } else {
                            //   print("Veri gönderilemedi...");
                            // }
                            setState(() {
                              logs.add("Sended Data");
                            });
                          },
                          child: const Text("Send Data")),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ],
            ),
            // RX ...............................................................
            const Text("data2"),
            //LOG ...............................................................
            XLog(logs),
          ],
        ),
      ),
    );
  }
}






/*import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  String port = "4800";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deneme COM"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // SETTING ...........................................................
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: const [
                      Text("Port"),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("Bound"),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      DropdownButton(
                          value: port,
                          items: <String>['4800', '9600', '115200'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              port = value.toString();
                            });
                          }),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("data2"),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(onPressed: () {}, child: const Text("Find Ports")),
                      const SizedBox(height: 5.0),
                      ElevatedButton(onPressed: () {}, child: const Text("Connect")),
                      const SizedBox(height: 5.0),
                      ElevatedButton(onPressed: () {}, child: const Text("Disconnect")),
                    ],
                  ),
                )
              ],
            ),
            // TX ...............................................................
            Text("data3"),
            // RX ...............................................................
            Text("data3"),
            // LOG ...............................................................
            Text("data3"),
          ],
        ),
      ),
    );
  }
}
*/