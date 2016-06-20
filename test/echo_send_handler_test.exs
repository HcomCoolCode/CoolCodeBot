defmodule EchoSendHandlerTest do
	use ExUnit.Case
	alias FinBot.Handlers.EchoSendHandler
	
	test "sending text to fb" do
		resp = EchoSendHandler.send_fb("1344190288931480", "unit test chat")
		assert 200 == resp.status_code
	end
end
