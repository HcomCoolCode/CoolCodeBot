defmodule EchoSendHandlerTest do
	use ExUnit.Case
	alias FinBot.SendFb
	
	test "sending text to fb" do
		resp = SendFb.post("1344190288931480", "unit test chat")
#		assert 200 == resp.status_code
	end
end
