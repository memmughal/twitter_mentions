# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :extwitter, :oauth,
  consumer_key: "OQwQbSuyY3LKs0RcICVMhHg35",
  consumer_secret: "ZwRwXjCr9fCP3GteeBLI92zdCzw41wXKo9jhWxp6T4D6vTWZB6",
  access_token: "2265168632-CdyrBa5Lghx9jZ7jytpVMz42SEZAnqYqOz7iD3r",
  access_token_secret: "ZUqiqRcG8kXWJ4GhCVFjfbzbzx8WQ2gffLoIrZ8HKO790"

config :twitter_mentions, screen_name: "@josevalim"
# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :twitter_mentions, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:twitter_mentions, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"
