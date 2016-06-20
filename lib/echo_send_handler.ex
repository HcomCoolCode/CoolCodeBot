defmodule FinBot.Handlers.EchoSendHandler do
	use GenEvent

	def init(_args) do
		IO.inspect "Echo Send Handler started"
		{:ok, []}
	end

	def handle_event({:messages, messages}, all_messages) do
		entry = hd(messages["entry"])
		message = hd(entry["messaging"])
		text = message["message"]["text"]
		IO.inspect(text)
		senderId = message["sender"]["id"]
		IO.inspect(senderId)
		{:ok, [messages|all_messages]}
	end
end
