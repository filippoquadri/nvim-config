local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
	s("cocotb_tb", {
		t({
			"import cocotb",
			"from cocotb.clock import Clock",
			"from cocotb.triggers import ClockCycles, FallingEdge, RisingEdge",
			"",
			"",
		}),
		t({ "", "async def reset(dut):" }),
		t({ "", "    await RisingEdge(dut.clk_i)" }),
		t({ "", "    dut.rst_n_i.value = 1" }),
		t({ "", "    await RisingEdge(dut.clk_i)" }),
		t({ "", "    dut.rst_n_i.value = 0" }),
		t({ "", "" }),
		t({ "", "    # Reset all the signal of the dut" }),
		t({ "", "" }),
		t({ "", "    await ClockCycles(dut.clk_i, 5)" }),
		t({ "", "    dut.rst_n_i.value = 1" }),
		t({ "", "    await ClockCycles(dut.clk_i, 5)" }),
		t({ "", "" }),
		t({ "", "" }),
		t({ "", "" }),
		t("@cocotb.test()"),
		t({ "", "async def test_" }),
		f(function()
			local name = vim.fn.expand("%:t:r")
			name = name:gsub("_test$", "")
			return name
		end),
		t("(dut):"),
		t({ "", '    """' }),
		i(1, "Test the DUT"),
		t({ '"""', "" }),
		t({ "", "    # Start clock" }),
		t({ "", '    clock = Clock(dut.clk_i, 10, units="ns")' }),
		t({ "", "    cocotb.start_soon(clock.start())" }),
		t({ "", "" }),
		t({ "", "" }),
		t({ "    # Reset", "" }),
		t({ "    await reset(dut)", "" }),
		t({ "", "" }),
		t({ "    # Stimuli", "" }),
		t({ "", "" }),
		t({ "    # Stop on FallingEdge to avoid resolution problems", "    await FallingEdge(dut.clk_i)" }),
	}),
}
