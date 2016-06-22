Code.require_file("lib/echo_controller.exs")
Code.require_file("lib/router.exs")
Plug.Adapters.Cowboy.http Router, [], [dispatch: Router.dispatch_table]
