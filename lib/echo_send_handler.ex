defmodule FinBot.Handlers.EchoSendHandler do
	use GenEvent
	alias FinBot.SendFb
	
	def init(_args) do
		IO.inspect "Echo Send Handler started"
		{:ok, []}
	end

	def handle_event({:messages, messages}, all_messages) do
		entry = hd(messages["entry"])
		message = hd(entry["messaging"])
		text = message["message"]["text"]
		senderId = message["sender"]["id"]

		SendFb.post(senderId, text)
		
		{:ok, [messages|all_messages]}
	end
end
