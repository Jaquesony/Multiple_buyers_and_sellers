import 'package:flutter/material.dart';
import 'package:multiple_vendor/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AttributeTabScreen extends StatefulWidget {
  @override
  State<AttributeTabScreen> createState() => _AttributeTabScreenState();
}

class _AttributeTabScreenState extends State<AttributeTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  bool _entered = false;
  bool _enterd = false;
  List<String> _sizeList = [];
  List<String> _colorList = [];

  bool _isSave = false;
   bool _isSav = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Brand Name';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                _productProvider.getFromData(brandName: value);
              },
              decoration: InputDecoration(labelText: 'Brand'),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Container(
                    width: 100,
                    child: TextFormField(
                      controller: _sizeController,
                      onChanged: (value) {
                        setState(() {
                          _entered = true;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Size'),
                    ),
                  ),
                ),
                _entered == true
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow.shade900,
                        ),
                        onPressed: () {
                          setState(() {
                            _sizeList.add(_sizeController.text);
                            _sizeController.clear();
                          });
                        },
                        child: Text('Add'),
                      )
                    : Text(''),
              ],
            ),
            if (_sizeList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _sizeList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _sizeList.removeAt(index);
                                _productProvider.getFromData(
                                    sizeList: _sizeList);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade800,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _sizeList[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            if (_sizeList.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  _productProvider.getFromData(sizeList: _sizeList);
                  setState(() {
                    _isSave = true;
                  });
                },
                child: Text(
                  _isSave ? 'Saved' : 'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              onChanged: (value) {
                _productProvider.getFromData(model: value);
              },
              decoration: InputDecoration(
                labelText: 'Model',
              ),
            ),
            TextFormField(
              onChanged: (value) {
                _productProvider.getFromData(ram: value);
              },
              decoration: InputDecoration(
                labelText: 'Ram',
              ),
            ),
            TextFormField(
              onChanged: (value) {
                _productProvider.getFromData(hardDrive: value);
              },
              decoration: InputDecoration(
                labelText: 'Hard Drive',
              ),
            ),
            TextFormField(
              onChanged: (value) {
                _productProvider.getFromData(year: value);
              },
              decoration: InputDecoration(
                labelText: 'Year',
              ),
            ),
            TextFormField(
              onChanged: (value) {
                _productProvider.getFromData(cpu: value);
              },
              decoration: InputDecoration(
                labelText: 'CPU',
              ),
            ),
            TextFormField(
              onChanged: (value) {
                _productProvider.getFromData(screenSize: value);
              },
              decoration: InputDecoration(
                labelText: 'Screen Size',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Container(
                    width: 100,
                    child: TextFormField(
                      controller: _colorController,
                      onChanged: (value) {
                        setState(() {
                          _enterd = true;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Rangi'),
                    ),
                  ),
                ),
                _enterd == true
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow.shade900,
                        ),
                        onPressed: () {
                          setState(() {
                            _colorList.add(_colorController.text);
                            _colorController.clear();
                          });
                        },
                        child: Text('Add'),
                      )
                    : Text(''),
              ],
            ),
            if (_colorList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _colorList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _colorList.removeAt(index);
                                _productProvider.getFromData(
                                    colorList: _colorList);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade800,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _colorList[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            if (_colorList.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  _productProvider.getFromData(colorList: _colorList);
                  setState(() {
                    _isSav = true;
                  });
                },
                child: Text(
                  _isSav ? 'Saved' : 'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
              SizedBox(height: 200,),
          ],
        ),
      ),
    );
  }
}
