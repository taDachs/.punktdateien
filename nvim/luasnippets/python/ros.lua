local M = {}

function M.setup_snippets()
	local ls = require("luasnip")
	local s = ls.snippet
	local sn = ls.snippet_node
	local c = ls.choice_node
	local t = ls.text_node
	local i = ls.insert_node
	local f = ls.function_node
	local d = ls.dynamic_node
	local fmt = require("luasnip.extras.fmt").fmt
	local fmta = require("luasnip.extras.fmt").fmta
	local rep = require("luasnip.extras").rep
	local l = require("luasnip.extras").lambda
	local conds = require("luasnip.extras.expand_conditions")

	local function convert_ros_namespace_to_identifier(topic)
		topic = topic[1][1]
		print(vim.inspect(topic))
		topic = topic:gsub("~", "")
		topic = vim.split(topic, "/")
		topic = topic[#topic]
		return topic
	end

	return {
		s(
			{ trig = "rosp", dscr = "Gets a rosparm" },
			fmta(
				[[
    self.<> = rospy.get_param("<>"<>)
    ]],
				{
					f(convert_ros_namespace_to_identifier, { 1 }),
					i(1, "param_name"),
					c(2, {
						t(""), -- no default value
						{ t(", "), i(1, '"default_value"') },
					}),
				}
			)
		),
		s(
			{ trig = "rossrv", dscr = "Registers a ros service" },
			fmta(
				[[
      self.<>_srv = rospy.Service("<>", <>, self.<>_srv_callback)
      ]],
				{
					f(convert_ros_namespace_to_identifier, { 1 }),
					i(1, "service_name"),
					i(2, "message_type"),
					f(convert_ros_namespace_to_identifier, { 1 }),
				}
			)
		),
		s(
			{ trig = "rossub", dscr = "Registers a ros subscriber" },
			fmta(
				[[
      self.<>_sub = rospy.Subscriber("<>", <>, self.<>_sub_callback, queue_size=<>)
      ]],
				{
					f(convert_ros_namespace_to_identifier, { 1 }),
					i(1, "topic_name"),
					i(2, "message_type"),
					f(convert_ros_namespace_to_identifier, { 1 }),
					i(3, "10"),
				}
			)
		),
		s(
			{ trig = "msg_to_cv", dscr = "converts a ros Image msg to a cv image" },
			fmta(
				[[
        try:
            <> = self.cv_bridge.imgmsg_to_cv2(<>, <>)
        except CvBridgeError as e:
            <>
      ]],
				{
					i(2, "img"),
					i(1, "msg"),
					i(3, "\"passthrough\""),
					i(4, "print(e)"),
				}
			)
		),
		s(
			{ trig = "cv_to_msg", dscr = "converts a ros Image msg to a cv image" },
			fmta(
				[[
        try:
            <> = self.cv_bridge.cv2_to_imgmsg(<>, <>)
        except CvBridgeError as e:
            <>
      ]],
				{
					i(2, "msg"),
					i(1, "img"),
					i(3, "\"rgb8\""),
					i(4, "print(e)"),
				}
			)
		),
		s(
			{ trig = "rosboiler", dscr = "writes the boilerplate code for a ros node" },
			fmta(
				[[
      #!/usr/bin/env python3

      import rospy

      class <>Node:
          def __init__(self):
              # implement your stuff here
              <>


      if __name__ == "__main__":
          rospy.init_node("<>")
          rospy.loginfo("started node")
          rospy.spin()
        ]],
				{ i(1, "NodeName"), i(0, "pass"), i(2, "node_name") }
			)
		),
	}
end

return M.setup_snippets()
