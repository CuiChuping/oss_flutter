library oss_flutter.test.impl_test;

import 'dart:io';
import "package:test/test.dart";
import 'package:oss_flutter/src/utils.dart';
import 'package:oss_flutter/oss.dart';

void main() {
  HttpRequest req = new HttpRequest(
          'https://messenger.miaomi.co',
          'GET',
          {'versions':'xx', 'link':'yy'},
          {'x-oss-content-type':'application/json', 'x-oss-content-md5': 'adasdasdasdasdasdadasd'});
        Auth auth = new Auth('asdad', 'a3ffwefefew', 'asdadasdas');

  group('Utils', (){
    test('httpDate', (){
      final ds = httpDateNow();
      print(ds);
      expect(true, equals(true));
    });
    test('Auth-_get_subresource_string',(){
      final param = auth.get_subresource_string(req.param);
      print('param->${param}');
      expect(true, equals(param == '?link=yy&versions=xx'));
    });
    test('Auth-get_headers_string', (){
      final headerStr = auth.get_headers_string(req);
      print('headers->\n${headerStr}');
      final eqResult = "x-oss-content-md5:adasdasdasdasdasdadasd\nx-oss-content-type:application/json\n";
      expect(true, equals(eqResult == headerStr));
    });
    test('Auth-get_resource_string', (){
      final resource = auth.get_resource_string(req, "atk-tmp", '');
      print('res: ${resource}');
      final eqStr = '/atk-tmp/?link=yy&versions=xx';
      expect(true, equals(resource == eqStr));
    });
    test('Auth-get_string_to_sign', (){
      final signRaw = auth.get_string_to_sign(req, "atk-tmp", '');
      print("raw:\n${signRaw}");
      expect(true, equals(true));
    });

    test('Client-checkExpire', (){
        final client = Client('', '', (url) async{});
        final yes = client.checkExpire('2019-06-23T00:53:26Z');
        print('rs:${yes}');
        expect(true, equals(yes));
    });
    test('Client-Auth', () async{
      final client = Client('', '', (url) async{
          return {
            "AccessKeyId": "STS.NK8DkLweZY6juxjTaXSDtEhFT", 
            "AccessKeySecret": "DmZryEAFYijzndptHoukoYXPTY9NeinBZrLrQKMGaLHt", 
            "Expiration": "2019-06-23T00:53:26Z", 
            "SecurityToken": "CAIS9gF1q6Ft5B2yfSjIr4iND9H4mrp77vSBd17bsGENX8tYqq3ttjz2IH9OeHhqB+kWsPkyn2FW7fwalrh+W4NIX0rNaY5t9ZlN9wqkbtJqfW9TPflW5qe+EE2/VjTZvqaLEcibIfrZfvCyESOm8gZ43br9cxi7QlWhKufnoJV7b9MRLGLaBHg8c7UwHAZ5r9IAPnb8LOukNgWQ4lDdF011oAFx+wgdgOadupDGtUOC0QCilrZM99yre8WeApMybMcvYbCcx/drc6fN6ilU5iVR+b1+5K4+omid4oDHXQABvUjbaLuKqYc3NmF+fbMzEKVUczQjVFHbfI0agAGLEH6WkWif+jfTBZ2OEGaPNw+2HPhdnqtfP7gawuDvN72xeN2KtJZKH0vAi3cTGId0rlb0drO0KvYVUGtyyvkYDLDEzJC1gDYl/ewuknqnJYJyxegCc/J3YDiFpCCbQ2kK9464A+os5Y7TGa+RUKF+6kbkuwu+hMRL+aJWJZUjGA==", 
            "StatusCode": 200
          };
        });
        Auth auth = await client.getAuth();
        expect(true, equals(client.checkAuthed()));
    });
    test('Client-listBucket', () async{
      final client = Client('', 'oss-cn-hongkong.aliyuncs.com', (url) async{
          return {
            "AccessKeyId": "STS.NJsbinQRbvWCRRkzsY9FmWw7n", 
            "AccessKeySecret": "9T9RFLeR3F3QEW5v9SYzB6aLpTze2vUhMCTrsri3gfGf", 
            "Expiration": "2019-06-23T13:15:55Z", 
            "SecurityToken": "CAIS9gF1q6Ft5B2yfSjIr4nGKdPavI1DwZWoUHTannMMNclBuLKcjDz2IH9OeHhqB+kWsPkyn2FW7fwalrh+W4NIX0rNaY5t9ZlN9wqkbtIiZ05+PflW5qe+EE2/VjTZvqaLEcibIfrZfvCyESOm8gZ43br9cxi7QlWhKufnoJV7b9MRLGLaBHg8c7UwHAZ5r9IAPnb8LOukNgWQ4lDdF011oAFx+wgdgOadupDGtUOC0QCilrZM99yre8WeApMybMcvYbCcx/drc6fN6ilU5iVR+b1+5K4+omid4oDHXQABvUjbaLuKqYc3NmF+fbMzEKVUczQjVFHbfI0agAF0gGYMO8mcvs6u8QEhzwBXNCb4PDbigfxwno+wskaIrE5lOvPUtW7EhxijQZjphOK71+59/R4dciJFoFXVAqutyUnLlNsrkKGPB0HQBwbRX3oPmiJ8NriH4es0qfV6i9Om1e+i6Vbj7WBaUMuMru9q9NOp9q8oYON09K2QdOlRdA==", 
            "StatusCode": 200
          };
        });
        Auth auth = await client.getAuth();
        final request = client.list_buckets();
        print(request.asCurl());
        expect(true, equals(true));
    });

    test('Client-md5file', () async{
      File f = new File('/Users/alex/Pictures/1.jpg');
      final bytes = await f.readAsBytes();
      final hashValue = md5File(bytes);
      final checkValue = '8d90a8c48d0e8427335787903f52e1c9';
      print('hash:${hashValue}   to  ${checkValue}');
      expect(true, equals(hashValue == checkValue));
    });
    test('Client-putObject', () async{
      final path = '/Users/alex/Pictures/1.jpg';
      File f = new File(path);
      final bytes = await f.readAsBytes();
      final client = Client('', 'oss-cn-hongkong.aliyuncs.com', (url) async{
          return {
            "AccessKeyId": "STS.NJzu9RfSjTQPrKPYtkXDC663z", 
            "AccessKeySecret": "CkW8KPu31Eo511GsHr8WwpoGDmKAPfYQoXzFmwwq8yYg", 
            "Expiration": "2019-06-23T14:59:11Z", 
            "SecurityToken": "CAIS9gF1q6Ft5B2yfSjIr4nPPoPmi4xL45O7cG3hvXQ+VMtv2fOYmDz2IH9OeHhqB+kWsPkyn2FW7fwalrh+W4NIX0rNaY5t9ZlN9wqkbtJhGkB7PflW5qe+EE2/VjTZvqaLEcibIfrZfvCyESOm8gZ43br9cxi7QlWhKufnoJV7b9MRLGLaBHg8c7UwHAZ5r9IAPnb8LOukNgWQ4lDdF011oAFx+wgdgOadupDGtUOC0QCilrZM99yre8WeApMybMcvYbCcx/drc6fN6ilU5iVR+b1+5K4+omid4oDHXQABvUjbaLuKqYc3NmF+fbMzEKVUczQjVFHbfI0agAGwKqAkU2WbB+Twr09nJMG5DCXqv+gzml2WjEt6n6cfE/Mrjjx7vcpidag0Yx/86hURyTSBbPTJ3ew5TWVzUp1A6YHijRBcrZkk9ZOAdytWkkn6dZ0FJqPsAVQnnDho+IbtYjNV7WmyKvyXHQfS/lqKThdKg6vdJQRowsyQcWotmQ==", 
            "StatusCode": 200
          };
        });
      Auth auth = await client.getAuth();
      HttpRequest req = client.putObject(bytes, 'messenger', '1.jpg');
      print(req.asCurl(file_path: path));
      expect(true, equals(true));      
    });
    test('Client-deleteObject', () async{
      final client = Client('', 'oss-cn-hongkong.aliyuncs.com', (url) async{
          return {
            "AccessKeyId": "STS.NJzu9RfSjTQPrKPYtkXDC663z", 
            "AccessKeySecret": "CkW8KPu31Eo511GsHr8WwpoGDmKAPfYQoXzFmwwq8yYg", 
            "Expiration": "2019-06-23T14:59:11Z", 
            "SecurityToken": "CAIS9gF1q6Ft5B2yfSjIr4nPPoPmi4xL45O7cG3hvXQ+VMtv2fOYmDz2IH9OeHhqB+kWsPkyn2FW7fwalrh+W4NIX0rNaY5t9ZlN9wqkbtJhGkB7PflW5qe+EE2/VjTZvqaLEcibIfrZfvCyESOm8gZ43br9cxi7QlWhKufnoJV7b9MRLGLaBHg8c7UwHAZ5r9IAPnb8LOukNgWQ4lDdF011oAFx+wgdgOadupDGtUOC0QCilrZM99yre8WeApMybMcvYbCcx/drc6fN6ilU5iVR+b1+5K4+omid4oDHXQABvUjbaLuKqYc3NmF+fbMzEKVUczQjVFHbfI0agAGwKqAkU2WbB+Twr09nJMG5DCXqv+gzml2WjEt6n6cfE/Mrjjx7vcpidag0Yx/86hURyTSBbPTJ3ew5TWVzUp1A6YHijRBcrZkk9ZOAdytWkkn6dZ0FJqPsAVQnnDho+IbtYjNV7WmyKvyXHQfS/lqKThdKg6vdJQRowsyQcWotmQ==", 
            "StatusCode": 200
          };
      });
      await client.getAuth();
      HttpRequest req = client.deleteObject('messenger', '1.jpg');
      
      print(req.asCurl());
      expect(true, equals(true)); 
    });

  });

}