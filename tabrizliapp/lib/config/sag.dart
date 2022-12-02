// Container(
// padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
// child: Image.asset(
// 'assets/images/chashout.png',
// height: 100,
// ),
// ),
// Container(
// padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
// child: Text(
// ".مبلغ برداشت را مشخص کنید",
// textAlign: TextAlign.center,
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// )),
// Container(
// padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
// child: TextField(
// onChanged: (value) {
// amount = value;
// },
// keyboardType: TextInputType.number,
// textAlign: TextAlign.center,
// decoration: InputDecoration(
// fillColor: Color.fromRGBO(250, 236, 196, 10),
// filled: true,
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(25.0),
// ),
// hintText: "مبلغ(ریال)",
// ),
// ),
// ),
// Container(
// padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
// child: Text(
// ".شماره شبا خود را وارد کنید",
// textAlign: TextAlign.center,
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// )),
// Container(
// padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
// child: TextField(
// onChanged: (value) {
// amount = value;
// },
// keyboardType: TextInputType.number,
// textAlign: TextAlign.center,
// decoration: InputDecoration(
// fillColor: Color.fromRGBO(250, 236, 196, 10),
// filled: true,
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(25.0),
// ),
// hintText: "مبلغ(ریال)",
// ),
// ),
// ),
// Column(
// children: [
// Container(
// padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
// child: InkWell(
// onTap: _charge,
// child: Image.asset(
// "assets/images/success.png",
// height: 50,
// width: 50,
// ),
// )),
// Center(
// child: Text(
// "تایید",
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// ),
// ],
// ),