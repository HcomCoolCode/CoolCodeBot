defmodule FinBot.Handlers.StartHandlers do
	use GenServer
	alias FinBot.Handlers.{LoggerHandler, EchoSendHandler, TShirtSender}
	
	def start_link(args) do
		GenServer.start_link(__MODULE__, args)
	end

	#

	def init([arg]) do
		GenEvent.add_handler(arg.manager, LoggerHandler, [])
		GenEvent.add_handler(arg.manager, EchoSendHandler, [])
		# need a handler to save all messages from FB
		{:ok, %{}}
	end
end
