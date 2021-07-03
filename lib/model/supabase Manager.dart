import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://mbwbjnrmeityfyuvsucf.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNTMxNjMxOSwiZXhwIjoxOTQwODkyMzE5fQ.zTF6N0c0WKPl159aBxiitx4drAy2BsrtUGAMUfNGQ_g';

final client = SupabaseClient(supabaseUrl, supabaseKey);

class SupabaseManager {
  void signUpUser(String email, String password) async {
    await client.auth.signUp(email, password);
  }

  getData() async {
    var response = await client.from('datatable').select().execute();
    if (response.error == null) {
      print('response.data: ${response.data}');
    }
  }

  addData(String friendName) async {
    await client.from('datatable').insert([
      {'name': friendName}
    ]).execute();
  }
}
