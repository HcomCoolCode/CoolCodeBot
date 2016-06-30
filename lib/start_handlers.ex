defmodule FinBot.Handlers.StartHandlers do
	use GenServer
	alias FinBot.Handlers.{LoggerHandler, EchoSendHandler, TShirtSender,MsgSplitHandler, HelpHandler,MyFirstHandler}
	
	def start_link(args) do
		GenServer.start_link(__MODULE__, args)
	end

	#

	def init([%{manager: manager}]) do
		GenEvent.add_handler(manager, LoggerHandler, [])
#		GenEvent.add_handler(manager, EchoSendHandler, [])
		GenEvent.add_handler(manager, MsgSplitHandler, %{manager: manager})
		GenEvent.add_handler(manager, HelpHandler, [])
		GenEvent.add_handler(manager, MyFirstHandler, [])
		# need a handler to save all messages from FB
		{:ok, %{}}
	end
end
