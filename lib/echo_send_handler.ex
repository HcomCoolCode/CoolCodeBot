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

		IO.inspect( System.get_env("FB_PAGE_ACCESS_TOKEN"))

		url = "https://graph.facebook.com/v2.6/me/messages?access_token=" <> System.get_env("FB_PAGE_ACCESS_TOKEN")
		body = %{"recipient": %{"id": senderId}, "message": %{"text": text}}
		HTTPotion.post url, [body: body, headers: ["Content-Type", "application/json"]]
		
		{:ok, [messages|all_messages]}
	end
end
