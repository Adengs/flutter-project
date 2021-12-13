// FutureBuilder<DocumentSnapshot<Object?>>(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             Map<String, dynamic> data =
//                 snapshot.data!.data() as Map<String, dynamic>;
//             namaController.text = data['nama'];
//             nikController.text = data['nik'];
//             desaController.text = data['desa'];
//           }else {}
//           return Center(child: CircularProgressIndicator());
//         });