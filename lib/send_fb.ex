defmodule FinBot.SendFb do
	def post(senderId, text) do
		url = "https://graph.facebook.com/v2.6/me/messages?access_token=" <> System.get_env("FB_PAGE_ACCESS_TOKEN")
		body = Poison.encode!(%{"recipient": %{"id": senderId}, "message": %{"text": text}})
		IO.inspect(url)
		IO.inspect(body)
		HTTPotion.post url, [body: body, headers: ["Content-Type": "application/json"]]
	end
end
