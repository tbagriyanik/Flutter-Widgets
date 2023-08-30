import 'package:flutter/material.dart';

class Stepci extends StatefulWidget {
  @override
  _StepciState createState() => _StepciState();
}

class _StepciState extends State<Stepci> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('15- Stepper Widget'),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                controlsBuilder: (context, details) {
                  return Row(
                    children: <Widget>[
                      _currentStep == 0
                          ? ElevatedButton(
                              onPressed: continued,
                              child: const Text('Sonraki'),
                            )
                          : _currentStep == 1
                              ? Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: continued,
                                        child: const Text('Sonraki'),
                                      ),
                                      SizedBox(width: 20),
                                      ElevatedButton(
                                        onPressed: cancel,
                                        child: const Text('Geri'),
                                      ),
                                    ],
                                  ),
                                )
                              : _currentStep >= 2
                                  ? Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: continued,
                                            child: const Text('Kaydet'),
                                          ),
                                          SizedBox(width: 20),
                                          ElevatedButton(
                                            onPressed: cancel,
                                            child: const Text('Geri'),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: cancel,
                                      child: const Text('Geri'),
                                    ),
                    ],
                  );
                },
                steps: <Step>[
                  Step(
                    title: new Text('Hesap'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Email Adresi'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Parola'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Adres'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Ev Adresi'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Posta Kodu'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Mobil Numara'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Mobil Numara'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
