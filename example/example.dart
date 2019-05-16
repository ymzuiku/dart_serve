import 'package:serral/main.dart';

void main() {
  final app = Serral();
  app.serve(port: 5100);

  app.before((SerralCtx ctx) {
    app.middlewareOfOrigin(ctx, '*');
  });

  app.before((SerralCtx ctx) {
    print(ctx.request.uri.toString());
    ctx.context['dog'] = 100;
  });

  app.after((SerralCtx sr) {
    print('end');
  });

  app.GET('/', getHome);
  app.POST('/dog', postDog);
}

void getHome(SerralCtx ctx) async {
  // read ctx.context, check app.before;
  print(ctx.context['dog']);
  ctx.send(200, 'hello: ${ctx.context['dog']}');
}

void postDog(SerralCtx ctx) async {
  print(ctx.body);
  // use Futrue, check app.after;
  await Future.delayed(Duration(milliseconds: 300));
  ctx.send(200, 'order');
}
