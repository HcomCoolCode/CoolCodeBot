defmodule MsgSplitHandlerTest do
	use ExUnit.Case
	alias FinBot.Handlers.MsgSplitHandler

	@a_message %{"object": "page", "entry": [
			%{
				"id": 1,
				"time": 1457764198246,
				"messaging": [
					%{
						"sender": %{
							"id": "USER_ID"
							      },
						"recipient": %{
							"id": "PAGE_ID"
						},
						"timestamp": 1457764197627,
						"message": %{
							"mid": "mid.1457764197618:41d102a3e1ae206a38",
							"seq": 73,
							"text": "hello, world!"
						}
					}
				]
			}
		]
		}

	test "can split a message" do
		res = MsgSplitHandler.split(@a_message)
		assert is_list(res)
		assert res == [%{"sender": %{
											 "id": "USER_ID"
														},
										"recipient": %{
											"id": "PAGE_ID"
										},
										"timestamp": 1457764197627,
										"message": %{
											"mid": "mid.1457764197618:41d102a3e1ae206a38",
											"seq": 73,
											"text": "hello, world!"
										}
									 }]
	end
end
