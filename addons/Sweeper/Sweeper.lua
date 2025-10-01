--[[
Copyright © 2025, Key
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Sweeper nor the names of its contributors may be
	  used to endorse or promote products derived from this software without
	  specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Key BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name    = 'Boombox\'s Bomb Sweeper'
_addon.author  = 'Key (Keylesta@Valefor)'
_addon.version = '1.0 BETA-1'
_addon.commands = {'sweeper',}

texts = require('texts')

--------------------------------------------------------------------------------
-- CONFIG
--------------------------------------------------------------------------------
CFG = {
	cell_size   = 36,
	gap         = 2,
	origin_x    = 300,
	origin_y    = 150,
	font        = { name = 'Consolas', size = 14 },
	color       = {
		cell_hidden        = {220, 60, 60, 80},
		cell_revealed      = {220, 180, 180, 200},
		cell_zero          = {220, 160, 200, 160},
		cell_flag          = {220, 200, 160, 60},
		new_game_btn       = {220, 60, 120, 160},
		splash_panel       = {240, 30, 30, 30},
		splash_btn         = {230, 90, 160, 60},
		bomb_red           = {255, 220, 40, 40},
		win_green          = {255, 50, 200, 120},
		overlay_trans      = {220, 10, 10, 10},
	},
}

-- Predefined sizes/bombs
PRESET_SIZES = {
	{ size = 8,  bombs = 10, label = 'Easy'  },
	{ size = 12, bombs = 24, label = 'Normal' },
	{ size = 16, bombs = 50, label = 'Difficult' },
}

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
state = {
	splash = true,
	game_over = false,
	win = false,
	first_click_done = false,
	grid_shown = false,
	current_grid_size = 10,
	current_bombs = 20,
	pressed = {
		splash_idx = nil,
		new = false,
		startscreen = false,
	},
}

board = {}        -- board[r][c] = { bomb, adj, revealed, flagged, prim, txt }
prim_names = {}   -- track prims we create so we can delete
text_objs = {}    -- track text objects to hide/delete
ui = {}           -- references to UI prim names / texts

--------------------------------------------------------------------------------
-- UTIL HELPERS
--------------------------------------------------------------------------------
function rgba(t) return t[1], t[2], t[3], t[4] end

function create_prim(name, x, y, w, h, color)
	windower.prim.create(name)
	windower.prim.set_position(name, x, y)
	windower.prim.set_size(name, w, h)
	windower.prim.set_color(name, rgba(color))
	windower.prim.set_visibility(name, true)
	prim_names[name] = true
	return name
end

function set_prim_color(name, color)
	if name and prim_names[name] then pcall(windower.prim.set_color, name, rgba(color)) end
end

function destroy_prim(name)
	if name and prim_names[name] then
		pcall(windower.prim.delete, name)
		prim_names[name] = nil
	end
end

-- Create consistent text objects that won't capture mouse or be draggable
function new_text(initial, opts)
	local posx = opts and opts.x or 0
	local posy = opts and opts.y or 0
	local size = opts and opts.size or CFG.font.size
	local t = texts.new(initial or '', {
		pos  = { x = posx, y = posy },
		text = {
			size = size,
			font = CFG.font.name,
			alpha = 255,
			stroke = { width = 1, alpha = 160 },
		},
		flags = { right = false, bold = false, italic = false, draggable = false },
		bg = { visible = false },
		color = { alpha = 255, red = 255, green = 255, blue = 255 },
	})
	t:show()
	table.insert(text_objs, t)
	return t
end

function hide_text(t)
	if t then pcall(t.hide, t) end
end

function destroy_all()
	for name,_ in pairs(prim_names) do pcall(windower.prim.delete, name) end
	prim_names = {}
	for _,t in ipairs(text_objs) do pcall(t.hide, t) end
	text_objs = {}
end

function point_in_rect(px, py, rx, ry, rw, rh)
	return px >= rx and px <= rx + rw and py >= ry and py <= ry + rh
end

function name_cell_prim(r, c)
	return string.format('gbs_cell_%02d_%02d', r, c)
end

--------------------------------------------------------------------------------
-- BOARD / ADJACENCY
--------------------------------------------------------------------------------
function init_empty_board(size)
	board = {}
	for r = 1, size do
		board[r] = {}
		for c = 1, size do
			board[r][c] = {
				bomb = false,
				adj = 0,
				revealed = false,
				flagged = false,
				prim = nil,
				txt = nil,
			}
		end
	end
end

function shuffle_bombs(exclude_r, exclude_c, size, bombs)
	-- place bombs avoiding the first clicked cell
	local cells = {}
	for r = 1, size do
		for c = 1, size do
			if not (r == exclude_r and c == exclude_c) then
				table.insert(cells, { r = r, c = c })
			end
		end
	end
	for i = #cells, 2, -1 do
		local j = math.random(i)
		cells[i], cells[j] = cells[j], cells[i]
	end
	bombs = math.min(bombs, #cells)
	for i = 1, bombs do
		local rc = cells[i]
		board[rc.r][rc.c].bomb = true
	end
end

function neighbors(size, r, c, fn)
	for dr = -1, 1 do
		for dc = -1, 1 do
			if not (dr == 0 and dc == 0) then
				local rr, cc = r + dr, c + dc
				if rr >= 1 and rr <= size and cc >= 1 and cc <= size then
					fn(rr, cc, board[rr][cc])
				end
			end
		end
	end
end

function compute_adjacency(size)
	for r = 1, size do
		for c = 1, size do
			local cell = board[r][c]
			if not cell.bomb then
				local cnt = 0
				neighbors(size, r, c, function(_, _, n) if n.bomb then cnt = cnt + 1 end end)
				cell.adj = cnt
			end
		end
	end
end

--------------------------------------------------------------------------------
-- VISUALS
--------------------------------------------------------------------------------
function cell_screen_rect(r, c)
	local x = CFG.origin_x + (c - 1) * (CFG.cell_size + CFG.gap)
	local y = CFG.origin_y + (r - 1) * (CFG.cell_size + CFG.gap)
	return x, y, CFG.cell_size, CFG.cell_size
end

function build_grid_prims(size)
	for r = 1, size do
		for c = 1, size do
			local cell = board[r][c]
			local name = name_cell_prim(r, c)
			local x, y = cell_screen_rect(r, c)
			create_prim(name, x, y, CFG.cell_size, CFG.cell_size, CFG.color.cell_hidden)
			cell.prim = name
			-- center text for number/flag/bomb
			local t = new_text('', { x = x + math.floor(CFG.cell_size / 2) - 8, y = y + math.floor(CFG.cell_size / 2) - 10, size = 16 })
			t:hide()
			cell.txt = t
		end
	end
	state.grid_shown = true
end

function destroy_grid_prims(size)
	if not state.grid_shown then return end
	for r = 1, size do
		for c = 1, size do
			local cell = board[r][c]
			if cell and cell.prim then destroy_prim(cell.prim) cell.prim = nil end
			if cell and cell.txt then hide_text(cell.txt) cell.txt = nil end
		end
	end
	state.grid_shown = false
end

function set_cell_visual(r, c)
	local cell = board[r][c]
	if not cell or not cell.prim then return end
	if cell.revealed then
		if cell.bomb then
			set_prim_color(cell.prim, CFG.color.bomb_red)
			if cell.txt then cell.txt:text('●'); cell.txt:show() end --💣
		else
			local col = (cell.adj == 0) and CFG.color.cell_zero or CFG.color.cell_revealed
			set_prim_color(cell.prim, col)
			if cell.adj > 0 then
				local colors = {
					[1] = { r = 80, g = 180, b = 255 }, [2] = { r = 120, g = 220, b = 120 }, [3] = { r = 255, g = 110, b = 110 },
					[4] = { r = 140, g = 100, b = 220 }, [5] = { r = 220, g = 80, b = 80 },  [6] = { r = 80, g = 200, b = 200 },
					[7] = { r = 50, g = 50, b = 50 },   [8] = { r = 200, g = 200, b = 200 },
				}
				local coln = colors[cell.adj] or { r = 255, g = 255, b = 255 }
				if cell.txt then
					cell.txt:color(coln.r, coln.g, coln.b)
					cell.txt:text(tostring(cell.adj))
					cell.txt:show()
				end
			else
				if cell.txt then cell.txt:text(''); cell.txt:hide() end
			end
		end
	else
		if cell.flagged then
			set_prim_color(cell.prim, CFG.color.cell_flag)
			if cell.txt then cell.txt:text('►'); cell.txt:show() end --⚑
		else
			set_prim_color(cell.prim, CFG.color.cell_hidden)
			if cell.txt then cell.txt:text(''); cell.txt:hide() end
		end
	end
end

function update_all_cells_visual(size)
	for r = 1, size do
		for c = 1, size do
			set_cell_visual(r, c)
		end
	end
end

--------------------------------------------------------------------------------
-- GAME LOGIC
--------------------------------------------------------------------------------
function reveal_flood(size, r, c)
	local cell = board[r][c]
	if cell.revealed or cell.flagged then return end
	cell.revealed = true
	if cell.adj == 0 and not cell.bomb then
		neighbors(size, r, c, function(rr, cc, ncell)
			if not ncell.revealed and not ncell.bomb then
				reveal_flood(size, rr, cc)
			end
		end)
	end
end

function check_win(size)
	for r = 1, size do
		for c = 1, size do
			local cell = board[r][c]
			if not cell.bomb and not cell.revealed then
				return false
			end
		end
	end
	return true
end

function reveal_all_bombs(size)
	for r = 1, size do
		for c = 1, size do
			if board[r][c].bomb then
				board[r][c].revealed = true
			end
		end
	end
end

function count_flags(size)
	local f = 0
	for r = 1, size do
		for c = 1, size do
			if board[r][c].flagged then f = f + 1 end
		end
	end
	return f
end

--------------------------------------------------------------------------------
-- HUD / SPLASH
--------------------------------------------------------------------------------
SPLASH_ASCII = [[
                   ____                        _               _   
                  | __ )  ___   ___  _ __ ___ | |__   _____  _( )___
                  |  _ \\ / _ \\ / _ \\| '_ ` _ \\| '_ \\ / _ \\ \\/ /// __|
                  | |_) | (_) | (_) | | | | | | |_) | (_) >  <  \\__ \\
 ____       ,--.!,|____/_\\___/ \\___/|_|_|_| |_|_.__/ \\___/_/\\_\\ |___/
| __ )   __/  _-*- ___ | |__   / ___|_      _____  ___ _ __   ___ _ __
|  _ \\ ,d08b.| '_ ` _ \\| '_ \\  \\___ \\ \\ /\\ / / _ \\/ _ \\ '_ \\ / _ \\ '__|
| |_) |0088MM| | | | | | |_) |  ___) \\ V  V /  __/  __/ |_) |  __/ |
|____/ `9MMP'|_| |_| |_|_.__/  |____/ \\_/\\_/ \\___|\\___| .__/ \\___|_|
                                                      |_|
                Can you clear Boombox's bomb field?
]]

function build_splash()
	-- panel
	create_prim('gbs_splash_panel', 80, 160, 650, 290, CFG.color.splash_panel)
	ui.splash_panel = 'gbs_splash_panel'
	ui.splash_text = new_text(SPLASH_ASCII, { x = 110, y = 170, size = 11 })

	ui.splash_buttons = {}
	local start_x = 180
	local gap_x = 160
	local by = 390
	for i, p in ipairs(PRESET_SIZES) do
		local name = 'gbs_splash_btn_' .. i
		local bx = start_x + (i - 1) * gap_x
		create_prim(name, bx, by, 120, 32, CFG.color.splash_btn)
		local txt = new_text(p.label, { x = bx + 8, y = by + 6, size = 12 })
		ui.splash_buttons[i] = { prim = name, txt = txt, x = bx, y = by, w = 120, h = 32, size = p.size, bombs = p.bombs }
	end
end

function hide_splash()
	if ui.splash_text then hide_text(ui.splash_text); ui.splash_text = nil end
	if ui.splash_buttons then
		for _, b in ipairs(ui.splash_buttons) do
			destroy_prim(b.prim)
			if b.txt then hide_text(b.txt) end
		end
		ui.splash_buttons = nil
	end
	destroy_prim(ui.splash_panel); ui.splash_panel = nil
end

function build_game_ui(size)
	local grid_width = size * CFG.cell_size + (size - 1) * CFG.gap

	-- Bombs label ABOVE the grid
	local center_x = CFG.origin_x + math.floor(grid_width / 2) - 110
	local bombs_y = CFG.origin_y - 28
	ui.bombs_text = new_text('', { x = center_x, y = bombs_y, size = 14 })

	-- Buttons below grid
	local base_y = CFG.origin_y + size * (CFG.cell_size + CFG.gap) + 16

	-- New Game button
	create_prim('gbs_new_btn', CFG.origin_x, base_y, 120, 24, CFG.color.new_game_btn)
	ui.new_btn = 'gbs_new_btn'
	ui.new_btn_text = new_text('New Game', { x = CFG.origin_x + 10, y = base_y, size = 14 })

	-- Start Screen button
	create_prim('gbs_startscreen_btn', CFG.origin_x + 140, base_y, 150, 24, CFG.color.new_game_btn)
	ui.startscreen_btn = 'gbs_startscreen_btn'
	ui.startscreen_btn_text = new_text('Start Screen', { x = CFG.origin_x + 150, y = base_y, size = 14 })

	-- Status / instructions below
	ui.status_text = new_text('Left-click: reveal | Right-click: flag', { x = CFG.origin_x, y = base_y + 36, size = 14 })
end

function hide_game_ui()
	if ui.new_btn then destroy_prim(ui.new_btn); ui.new_btn = nil end
	if ui.new_btn_text then hide_text(ui.new_btn_text); ui.new_btn_text = nil end
	if ui.startscreen_btn then destroy_prim(ui.startscreen_btn); ui.startscreen_btn = nil end
	if ui.startscreen_btn_text then hide_text(ui.startscreen_btn_text); ui.startscreen_btn_text = nil end
	if ui.bombs_text then hide_text(ui.bombs_text); ui.bombs_text = nil end
	if ui.status_text then hide_text(ui.status_text); ui.status_text = nil end
end

function update_bombs_label()
	if not ui.bombs_text then return end
	local flags = 0
	if state.grid_shown then
		for r = 1, state.current_grid_size do
			for c = 1, state.current_grid_size do
				if board[r][c].flagged then flags = flags + 1 end
			end
		end
	end
	ui.bombs_text:text(string.format('Bombs labeled: %d / %d', flags, state.current_bombs))
end

--------------------------------------------------------------------------------
-- GAME START / RESET
--------------------------------------------------------------------------------
function start_new_game_with(size, bombs)
	-- tear down existing grid + UI if present
	if state.grid_shown then
		destroy_grid_prims(state.current_grid_size)
		hide_game_ui()
	end

	state.current_grid_size = size
	state.current_bombs = bombs
	state.game_over = false
	state.win = false
	state.first_click_done = false

	init_empty_board(size)
	build_grid_prims(size)
	build_game_ui(size)
	update_all_cells_visual(size)
	update_bombs_label()
end

--------------------------------------------------------------------------------
-- INPUT HANDLING (down/up tracking)
--------------------------------------------------------------------------------
-- Mouse mapping (typical Windower mapping):
MOUSE_LEFT_DOWN  = 1
MOUSE_LEFT_UP    = 2
MOUSE_RIGHT_DOWN = 4
MOUSE_RIGHT_UP   = 5

-- Helper: return r,c if under a cell, otherwise nil
function coords_to_cell(mx, my)
	if not state.grid_shown then return nil, nil end
	for r = 1, state.current_grid_size do
		for c = 1, state.current_grid_size do
			local x, y = cell_screen_rect(r, c)
			if point_in_rect(mx, my, x, y, CFG.cell_size, CFG.cell_size) then
				return r, c
			end
		end
	end
	return nil, nil
end

-- left-click reveal logic
function handle_cell_left_click(r, c)
	if state.game_over or state.win then return end
	local cell = board[r][c]
	if not state.first_click_done then
		shuffle_bombs(r, c, state.current_grid_size, state.current_bombs)
		compute_adjacency(state.current_grid_size)
		state.first_click_done = true
	end
	if cell.flagged or cell.revealed then return end
	if cell.bomb then
		state.game_over = true
		reveal_all_bombs(state.current_grid_size)
	else
		reveal_flood(state.current_grid_size, r, c)
		if check_win(state.current_grid_size) then state.win = true end
	end
	update_all_cells_visual(state.current_grid_size)
	update_bombs_label()
	if ui.status_text then
		if state.win then ui.status_text:text('You win - All safe tiles uncovered!')
		elseif state.game_over then ui.status_text:text('BOOM! You hit bomb. Boombox win!') end
	end
end

-- right-click flag toggle
function handle_cell_right_click(r, c)
	if state.game_over or state.win then return end
	local cell = board[r][c]
	if cell.revealed then return end
	cell.flagged = not cell.flagged
	set_cell_visual(r, c)
	update_bombs_label()
end

-- main mouse event
windower.register_event('mouse', function(type, x, y, delta, blocked)
	-- MOUSE DOWN: record presses for buttons so we can act on UP and consume both
	if type == MOUSE_LEFT_DOWN or type == MOUSE_RIGHT_DOWN then
		if state.splash and ui.splash_buttons then
			for i, b in ipairs(ui.splash_buttons) do
				if point_in_rect(x, y, b.x, b.y, b.w, b.h) then
					state.pressed.splash_idx = i
					return true -- consume button-down
				end
			end
		elseif not state.splash then
			-- check game UI buttons (they are below grid)
			local grid_bottom = CFG.origin_y + state.current_grid_size * (CFG.cell_size + CFG.gap)
			local base_y = grid_bottom + 16
			if ui.new_btn and point_in_rect(x, y, CFG.origin_x, base_y, 120, 24) then
			-- if ui.new_btn and point_in_rect(x, y, CFG.origin_x + 120, base_y, 120, 24) then
				state.pressed.new = true
				return true
			elseif ui.startscreen_btn and point_in_rect(x, y, CFG.origin_x + 140, base_y, 150, 24) then
				state.pressed.startscreen = true
				return true
			end

			local r, c = coords_to_cell(x, y)
			if r and c then
				return true
			end
		end

	end

	-- MOUSE UP: act on prior pressed button or process grid click
	if type == MOUSE_LEFT_UP or type == MOUSE_RIGHT_UP then
		-- Splash button up handling
		if state.splash and ui.splash_buttons then
			local idx = state.pressed.splash_idx
			if idx then
				local b = ui.splash_buttons[idx]
				if b and point_in_rect(x, y, b.x, b.y, b.w, b.h) then
					-- start game with chosen size/bombs
					state.splash = false
					hide_splash()
					start_new_game_with(b.size, b.bombs)
					-- clear pressed
					state.pressed.splash_idx = nil
					return true
				else
					-- pressed a splash button down but released elsewhere -> clear and consume
					state.pressed.splash_idx = nil
					return true
				end
			end
		end

		-- In-game button handling (consume if down/up started on them)
		if not state.splash then
			local grid_bottom = CFG.origin_y + state.current_grid_size * (CFG.cell_size + CFG.gap)
			local base_y = grid_bottom + 16

			if state.pressed.new then
				if point_in_rect(x, y, CFG.origin_x, base_y, 120, 24) then
				-- if point_in_rect(x, y, CFG.origin_x + 120, base_y, 120, 24) then
					start_new_game_with(state.current_grid_size, state.current_bombs)
				end
				state.pressed.new = false
				return true
			end
			if state.pressed.startscreen then
				if point_in_rect(x, y, CFG.origin_x + 140, base_y, 120, 24) then
					-- go back to splash: destroy grid + game UI then build splash
					if state.grid_shown then destroy_grid_prims(state.current_grid_size) end
					hide_game_ui()
					ui = {} -- wipe UI refs
					state.splash = true
					build_splash()
				end
				state.pressed.startscreen = false
				return true
			end

			-- If none of the UI button presses were active, handle grid clicks on UP
			local r, c = coords_to_cell(x, y)
			if r and c then
				if type == MOUSE_LEFT_UP then
					handle_cell_left_click(r, c)
					return true
				elseif type == MOUSE_RIGHT_UP then
					handle_cell_right_click(r, c)
					return true
				end
			end
		end
	end

end)

--------------------------------------------------------------------------------
-- COMMANDS, INIT & CLEANUP
--------------------------------------------------------------------------------
windower.register_event('addon command', function(cmd, ...)
	cmd = (cmd or ''):lower()
	if cmd == 'start' then
		-- default 10x10 start if user requests
		state.splash = false
		hide_splash()
		start_new_game_with(10, 20)
	elseif cmd == 'reset' then
		if state.grid_shown then start_new_game_with(state.current_grid_size, state.current_bombs)
		else windower.add_to_chat(207, '[GBS] No game running.') end
	else
		windower.add_to_chat(207, '[GBS] Commands: //gbs start | //gbs reset')
	end
end)

windower.register_event('load', function()
	math.randomseed(os.time() + (os.clock() * 1000))
	build_splash()
end)

windower.register_event('unload', function()
	destroy_all()
	ui = {}
end)
