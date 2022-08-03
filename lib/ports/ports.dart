import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatefulWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  _ExampleAppState createState() => _ExampleAppState();
}

extension IntToString on int {
  String toHex() => '0x${toRadixString(16)}';
  String toPadded([int width = 3]) => toString().padLeft(width, '0');
  String toTransport() {
    switch (this) {
      case SerialPortTransport.usb:
        return 'USB';
      case SerialPortTransport.bluetooth:
        return 'Bluetooth';
      case SerialPortTransport.native:
        return 'Native';
      default:
        return 'Unknown';
    }
  }
}

class _ExampleAppState extends State<ExampleApp> {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Serial Port List'),
        ),
        body: Scrollbar(
          child: ListView(
            children: [
              for (final address in availablePorts)
                Builder(builder: (context) {
                  final port = SerialPort(address);
                  return ExpansionTile(
                    title: Text(address),
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (port != null) {
                              //port.config.baudRate = 4800;
                              port.openReadWrite();
                              var config = SerialPortConfig();
                              config.baudRate = 4800;
                              port.config = config;
                              SerialPortReader(
                                port,
                              ).stream.listen((data) {
                                String str = String.fromCharCodes(data);
                                print('received: $data, str=$str');
                              }, onError: (error) {
                                print('hata olustu');
                                print(error);
                              }, onDone: () {
                                print('ondone');
                              });
                            }
                          },
                          child: const Text('Bağlan')),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (port != null) {
                              port.close();
                            } else {
                              print("Kapanamdı....");
                            }
                          },
                          child: const Text('Bağ. Sonlandır')),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (port != null) {
                              String sendData = "Merhaba";
                              port.write(
                                  Uint8List.fromList(sendData.codeUnits));
                            } else {
                              print("Veri gönderilemedi...");
                            }
                          },
                          child: const Text('Veri gönder')),
                      const SizedBox(
                        height: 5,
                      ),
                      // CardListTile('Description', port.description),
                      // CardListTile('Transport', port.transport.toTransport()),
                      // CardListTile('USB Bus', port.busNumber?.toPadded()),
                      // CardListTile('USB Device', port.deviceNumber?.toPadded()),
                      // CardListTile('Vendor ID', port.vendorId?.toHex()),
                      // CardListTile('Product ID', port.productId?.toHex()),
                      // CardListTile('Manufacturer', port.manufacturer),
                      // CardListTile('Product Name', port.productName),
                      // CardListTile('Serial Number', port.serialNumber),
                      // CardListTile('MAC Address', port.macAddress),
                    ],
                  );
                }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: initPorts,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}



class CardListTile extends StatelessWidget {
  final String name;
  final String? value;

  CardListTile(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(value ?? 'N/A'),
        subtitle: Text(name),
      ),
    );
  }
}



