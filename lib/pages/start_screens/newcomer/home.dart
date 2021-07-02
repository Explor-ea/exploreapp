import 'package:exploreapp/pages/start_screens/newcomer/consent_stepper.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text(
              "Explor'ea",
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            Container(height: 32.0),
            Text(
              "Fugiat consectetur commodo pariatur cupidatat exercitation ullamco ut pariatur amet eiusmod consequat minim eiusmod. Consectetur aute magna enim irure ex et dolor enim. Excepteur consequat reprehenderit et cillum eiusmod consequat dolore aliqua esse ad sint et eiusmod.",
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            Container(height: 32.0),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (BuildContext context) => ConsentStepper())),
                child: Text("C'est parti !"))
          ],
        ),
      )),
    );
  }
}
