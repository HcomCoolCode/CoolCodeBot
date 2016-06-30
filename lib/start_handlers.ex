defmodule FinBot.Handlers.StartHandlers do
	use GenServer

	alias FinBot.Handlers.{LoggerHandler, EchoSendHandler, TShirtSender,MsgSplitHandler, HelpHandler, SumHandler, MyFirstHandler}
	alias FinBot.Handlers.HotelWordHandler
	
	def start_link(args) do
		GenServer.start_link(__MODULE__, args)
	end

	#

	def init([%{manager: manager}]) do
		GenEvent.add_handler(manager, LoggerHandler, [])
#		GenEvent.add_handler(manager, EchoSendHandler, [])
		GenEvent.add_handler(manager, MsgSplitHandler, %{manager: manager})
		GenEvent.add_handler(manager, HelpHandler, [])
		GenEvent.add_handler(manager, SumHandler, [])
		GenEvent.add_handler(manager, MyFirstHandler, [])
		GenEvent.add_handler(manager, HotelWordHandler, [])
		# need a handler to save all messages from FB
		{:ok, %{}}
	end
end
