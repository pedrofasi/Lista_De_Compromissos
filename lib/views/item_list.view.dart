import 'package:flutter/material.dart';
import 'package:mvc_app/controllers/item.controller.dart';
import 'package:mvc_app/models/item.model.dart';

class ItemListView extends StatefulWidget {
  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {

  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  var _itemController2 = TextEditingController();
  var _list = List<Item>();
  var _controller = ItemController();

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAll().then((data) {
        setState(() {
          _list = _controller.list;
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Lista de Compromissos'),
          centerTitle: true
      ),
      body: Scrollbar(
        child: ListView(
          children: [

            for (int i = 0; i < _list.length; i++)
              ListTile(

                  title: CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: _list[i].concluido?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(_list[i].nome , style: TextStyle(fontSize: 20.0 ,decoration: TextDecoration.lineThrough, color: Colors.green),),
                        Text(_list[i].data , style: TextStyle(fontSize: 10.0 ,decoration: TextDecoration.lineThrough, color: Colors.green),),
                      ],
                    ):
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(_list[i].nome , style: TextStyle(fontSize: 20.0 ,color: Colors.red),),
                        Text(_list[i].data , style: TextStyle(fontSize: 10.0 ,color: Colors.grey),),
                      ],
                    ),

                    value: _list[i].concluido,
                    secondary: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 25.0,
                        color: Colors.red[900],
                      ),
                      onPressed: () {
                        _controller.delete(i).then((data) {
                          setState(() {
                            _list = _controller.list;
                          });
                        });
                      },
                    ),
                    onChanged: (c){
                      _list[i].concluido = c;
                      _controller.updateList(_list).then((data) {
                        setState(() {
                          _list = _controller.list;
                        });
                      });
                    },
                  )),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context),
      ),
    );
  }

  _displayDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _itemController,
                    validator: (s) {
                      if (s.isEmpty)
                        return "Digite o compromisso.";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Compromisso"),
                  ),

                  TextFormField(
                    controller: _itemController2,
                    validator: (s) {
                      if (s.isEmpty)
                        return "Digite a data e hora.";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(labelText: "Data/Hora"),
                  ),

                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('SALVAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {

                    _controller.create(Item(nome:_itemController.text, data: _itemController2.text, concluido: false)).then((data) {
                      setState(() {
                        _list = _controller.list;
                        _itemController.text = "";
                        _itemController2.text = "";
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
