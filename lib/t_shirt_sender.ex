defmodule FinBot.Handlers.TShirtSender do
	use GenEvent

	def init(_args) do
		IO.inspect "T Shirt Sender"
		{:ok, []}
	end

	def handle_event({:messages, messages}, _state) do
		entry = hd(messages["entry"])
		message = hd(entry["messaging"])
		senderId = message["sender"]["id"]
		post senderId
		{:ok, []}
	end

	def post(senderId) do
		url = "https://graph.facebook.com/v2.6/me/messages?access_token=" <> System.get_env("FB_PAGE_ACCESS_TOKEN")
		request_body = %{
			"recipient": %{
				"id": "1358602087490476"
								 },
			"message": %{
				"attachment": %{
					"type": "template",
					"payload": %{
						"template_type": "generic",
						"elements": [
							%{
								"title": "Classic White T-Shirt",
								"image_url": "http://petersapparel.parseapp.com/img/item100-thumb.png",
								"subtitle": "Soft white cotton t-shirt is back in style",
								"buttons": [
									%{
										"type": "web_url",
										"url": "https://petersapparel.parseapp.com/view_item?item_id=100",
										"title": "View Item"
									},
									%{
										"type": "web_url",
										"url": "https://petersapparel.parseapp.com/buy_item?item_id=100",
										"title": "Buy Item"
									},
									%{
										"type": "postback",
										"title": "Bookmark Item",
										"payload": "USER_DEFINED_PAYLOAD_FOR_ITEM100"
									}
								]
							},
							%{
								"title": "Classic Grey T-Shirt",
								"image_url": "http://petersapparel.parseapp.com/img/item101-thumb.png",
								"subtitle": "Soft gray cotton t-shirt is back in style",
								"buttons": [
									%{
										"type": "web_url",
										"url": "https://petersapparel.parseapp.com/view_item?item_id=101",
										"title": "View Item"
									},
									%{
										"type": "web_url",
										"url": "https://petersapparel.parseapp.com/buy_item?item_id=101",
										"title": "Buy Item"
									},
									%{
										"type": "postback",
										"title": "Bookmark Item",
										"payload": "USER_DEFINED_PAYLOAD_FOR_ITEM101"
									}
								]
							}
						]
					}
										}
			}
			}
		body = Poison.encode!(request_body)
		# sometimes the token goes bad, like when I changed my password, returned a 400
		HTTPotion.post url, [body: body, headers: ["Content-Type": "application/json"]]
	end
end
