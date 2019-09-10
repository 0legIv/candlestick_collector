# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Distillery.Releases.Config,
    # This sets the default release built by `mix distillery.release`
    default_release: :default,
    # This sets the default environment used by `mix distillery.release`
    default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :";9v0coZ;wLWEQ~<.Bh]GvHM$SM}P$5H1hgdS;AD5[wtdwp:/^L5IH.$tr:|%P4)a"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"c:ZQH<{HGSV{rcMgctsY/H$S:*e:$)M3u@$@1Q9V9[qDKb*X[kWyRS2?p9p@tpjo"
  set vm_args: "rel/vm.args"
end

release :candlestick_collector do
  set version: current_version(:candlestick_collector)
  set applications: [
    :runtime_tools
  ]
end

