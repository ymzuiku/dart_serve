# serral

Dart 轻巧的 Web 框架, Like Koa

## API

[API Documentation](https://pub.dev/documentation/serral/latest/serral/serral-library.html)

## Getting Started

### Create dart project

Create dir and create pubspec.yaml

```sh
$ mkdir your_project && cd your_project
$ touch pubspec.yaml
```

pubspec.yaml

```
name: your_project
version: 0.0.1
environment:
  sdk: '>=2.3.0 <3.0.0'

dependencies:
  serral: any

dev_dependencies:
  # build_runner: ^1.3
  # build_test: ^0.10.2

```

Install dependencies:

```
$ pub get
```

## Coding

```sh
$ mkdir lib
$ touch lib/main.dart
```

Edit lib/main.dart:

```dart
import 'package:serral/main.dart';

void main() {
  final app = Serral();
  app.serve(port: 5100);

  app.before((SerralCtx req) {
    app.middlewareOfOrigin(req, '*');
  });

  app.before((SerralCtx sr) {
    print(sr.request.uri.toString());
    sr.context['dog'] = 100;
  });

  app.after((SerralCtx sr) {
    print('end');
  });

  app.GET('/', getHome);
  app.POST('/dog', postDog);
}

void getHome(SerralCtx ctx) async {
  ctx.send(200, 'hello: ${ctx.context['dog']}');
}

void postDog(SerralCtx ctx) async {
  print(ctx.body);
  // 模拟异步, 等待 300 ms, 测试 before middleware 是否执行
  await Future.delayed(Duration(milliseconds: 300));
  ctx.send(200, 'order');
}
```

### Start server

```sh
$ dart lib/main.dart
```

Ok, server is running:

```
serral runing: http://127.0.0.1:5100
```
