use Mix.Config

config :maru, FinBot.API,
http: [port: {:system, "PORT"}]
