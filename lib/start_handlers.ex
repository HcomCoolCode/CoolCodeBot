defmodule FinBot.Handlers.StartHandlers do
	use GenServer
	alias FinBot.Handlers.{LoggerHandler, EchoSendHandler, TShirtSender}
	
	def start_link(args) do
		GenServer.start_link(__MODULE__, args)
	end

	#

	def init([%{manager: manager}]) do
		GenEvent.add_handler(manager, LoggerHandler, [])
		GenEvent.add_handler(manager, EchoSendHandler, [])
		GenEvent.add_handler(manager, MsgSplitHandler, %{manager: manager})
		# need a handler to save all messages from FB
		{:ok, %{}}
	end
end
