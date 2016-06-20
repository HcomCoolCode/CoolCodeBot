defmodule FinBot.Handlers.LoggerHandler do
	use GenEvent

	def init(_args) do
		IO.inspect "LoggerHandler started|"
		{:ok, []}
	end
	
	def handle_event({:messages, messages}, all_messages) do
		IO.inspect(messages)
		{:ok, [messages|all_messages]}
	end
	
end
