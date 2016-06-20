defmodule FinBot.Handlers.StartHandlers do
	use GenServer
	alias FinBot.Handlers.{LoggerHandler}
	
	def start_link(args) do
		GenServer.start_link(__MODULE__, args)
	end

	#

	def init([arg]) do
		IO.inspect arg
		IO.inspect "handlers starting"
		GenEvent.add_handler(arg.manager, LoggerHandler, [])
		{:ok, %{}}
	end
end
