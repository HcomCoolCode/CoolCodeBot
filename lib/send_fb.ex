defmodule FinBot.SendFb do
	def post(senderId, text) do
		url = "https://graph.facebook.com/v2.6/me/messages?access_token=" <> System.get_env("FB_PAGE_ACCESS_TOKEN")
		body = Poison.encode!(%{"recipient": %{"id": senderId}, "message": %{"text": text}})
		# sometimes the token goes bad, like when I changed my password, returned a 400
		HTTPotion.post url, [body: body, headers: ["Content-Type": "application/json"]]
	end
end
