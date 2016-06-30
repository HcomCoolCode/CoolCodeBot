defmodule MsgSplitHandlerTest do
	use ExUnit.Case
	alias FinBot.Handlers.MsgSplitHandler

	@more_messages %{"object" => "page", "entry" => [
											%{
												"id" => 1,
												"time" => 1457764198246,
												"messaging" => [
													%{
														"sender" => %{
															"id" => "USER_ID"
																		},
														"recipient" => %{
															"id" => "PAGE_ID"
														},
														"timestamp" => 1457764197627,
														"message" => %{
															"mid" => "mid.1457764197618:41d102a3e1ae206a38",
															"seq" => 73,
															"text" => "hello, world!"
														}
											},
													%{"message" => %{}}
												]
									},
											%{"messaging" => [%{"message" => %{}},
																			%{"message" => %{}}]}
										]
									}
	
	# define a stub GenEvent handler
	defmodule Forwarder do
		use GenEvent

		# handle all events, first parameter is the event, second if the state
		def handle_event(event, test_pid) do
			# send the event to `test_pid`
			send(test_pid, event)

			# respond `:ok` and keep the same state (the test's pid)
			{:ok, test_pid}
		end
	end

	# create all the processes we need in the setup
	# ExUnit automatically terminates child processes after each test completes
	setup do
		# create a GenEvent process
		{:ok, events} = GenEvent.start

		# add the Forwarder as a handler, pass the current pid (self) as the state
		GenEvent.add_handler(events, MsgSplitHandler, %{manager: events})
		GenEvent.add_handler(events, Forwarder, self)
		# return test state
		{:ok, %{events: events}}
	end
	
	
	test "can split a message" do
			a_message = %{"object" => "page", "entry" => [
			%{
				"id" => 1,
				"time" => 1457764198246,
				"messaging" => [
					%{
						"sender" => %{
							"id" => "USER_ID"
							      },
						"recipient" => %{
							"id" => "PAGE_ID"
						},
						"timestamp" => 1457764197627,
						"message" => %{
							"mid" => "mid.1457764197618:41d102a3e1ae206a38",
							"seq" => 73,
							"text" => "hello, world!"
						}
					}
				]
			}
		]
		}

		res = MsgSplitHandler.split(a_message)
		assert is_list(res)
		assert 1 == length(res)
		assert res == [%{"sender" => %{
											 "id" => "USER_ID"
														},
										"recipient" => %{
											"id" => "PAGE_ID"
										},
										"timestamp" => 1457764197627,
										"message" => %{
											"mid" => "mid.1457764197618:41d102a3e1ae206a38",
											"seq" => 73,
											"text" => "hello, world!"
										}
									 }]
	end

	test "more entries and messaging sections" do

		splits = MsgSplitHandler.split(@more_messages)
		assert is_list(splits)
		assert 4 == length(splits)
	end

	test "split msgs are events too", %{events: events} do
		event1 = {:messages, %{"object" => "page",
													 "entry" => [
														 %{
															 "id" => 1,
															 "time" => 1457764198246,
															 "messaging" => [%{"message" => "two"}]
												 }
													 ]
													}}
		GenEvent.notify(events, event1)
		assert_receive event1
		assert_receive {:message, %{"message" => "two"}}
	end

	test "real messages from FB" do
		splits = MsgSplitHandler.split(%{"entry" => [%{"id" => "572617346244802", "messaging" => [%{"message" => %{"mid" => "mid.1467248522580:01b92863b848ecab44", "seq" => 9263, "text" => "whoa"}, "recipient" => %{"id" => "572617346244802"}, "sender" => %{"id" => "1344190288931480"}, "timestamp" => 1467248522589}], "time" => 1467248522694}], "object" => "page"})
		assert is_list(splits)
	end
end
