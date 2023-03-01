local ls = require("luasnip")

local s = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local i = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

ls.config.set_config({
	history = true,
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 200,
	-- allows you to have dynamic snippets that update as you type
	updateevents = "TextChanged,TextChangedI",
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = false,
	store_selection_keys = "<C-b>",
})

ls.add_snippets(nil, {
	sh = {
		s("shebang", {
			text({ "#!/bin/sh", "" }),
			i(0),
		}),
	},

	typescript = {
		s("l", fmt("console.log({})", { i(1) })),
		s("e", fmt("console.error({})", { i(1) })),
		s("if", fmt("if ({}) {{\n  {}\n}}", { i(1), i(2) })),
		s("inf", fmt("interface {} {{\n  {}\n}}", { i(1), i(2) })),
		s("throw", fmt("throw new Error({})", { i(1) })),
		s("fn", fmt("const {} = ({}) => ", { i(1), i(2) })),
		s("func", fmt("function {}({}) {{\n  {}\n}}", { i(1), i(2), i(3) })),
		s("afunc", fmt("async function {}({}) {{\n  {}\n}}", { i(1), i(2), i(3) })),
		s("try", fmt("try {{\n  {}\n}} catch(e: any) {{\n  {}\n}}", { i(1), i(2) })),
		s("effect", fmt("useEffect(() => {{\n  {}\n}}, [{}]);", { i(1), i(2) })),
		s(
			"uitest",
			fmt(
				"test('{}', async () => {{\n  mockUser({{ permissions: [{}] }});\n  ratXAppTestRender({{ initialHistoryEntries: ['{}'] }});\n  await expectPendingPromises();\n  {}\n}});",
				{ i(1), i(2), i(3), i(4) }
			)
		),
	},
})

ls.filetype_extend("typescriptreact", { "typescript" })
