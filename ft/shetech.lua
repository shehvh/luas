--github.com/shehvh
local player = entities.get_entity(engine.get_local_player())
local Find = gui.get_config_item
local Checkbox = gui.add_checkbox
local Slider = gui.add_slider
local Combo = gui.add_combo
local MultiCombo = gui.add_multi_combo
local AddKeybind = gui.add_keybind
local CPicker = gui.add_colorpicker
local AddButton = gui.add_button
local playerstate = 0;
local ConditionalStates = { }
local configs = {}
local j = { anim_list = {} }
local find = gui.get_config_item
local yawAdd = find("rage>anti-aim>angles>add")
local checkbox = gui.add_checkbox
local slider = gui.add_slider
j.math_clamp = function(k, j, s) return math.min(s, math.max(j, k)) end
j.math_lerp = function(k, s, c)
    local N = j.math_clamp(.02, 0, 1)
    if type(k) == 'userdata' then
        r, g, b, k = k.r, k.g, k.b, k.a
        e_r, e_g, e_b, e_a = s.r, s.g, s.b, s.a
        r = j.math_lerp(r, e_r, N)
        g = j.math_lerp(g, e_g, N)
        b = j.math_lerp(b, e_b, N)
        k = j.math_lerp(k, e_a, N)
        return color(r, g, b, k)
    end
    local m = s - k
    m = m * N
    m = m + k
    if s == 0 and (m < .01 and m > -0.01) then
        m = 0
    elseif s == 1 and (m < 1.01 and m > .99) then
        m = 1
    end
    return m
end
local v1 = {anim_list={}};
v1.math_clamp = function(v0, v2, v3)
	return math.min(v3, math.max(v2, v0));
end;
v1.math_lerp = function(v0, v2, v3)
	local v148 = v1.math_clamp(0.08, 0, 1);
	if (type(v0) == "userdata") then
		r, g, b, v0 = v0.r, v0.g, v0.b, v0.a;
		e_r, e_g, e_b, e_a = v2.r, v2.g, v2.b, v2.a;
		r = v1.math_lerp(r, e_r, v148);
		g = v1.math_lerp(g, e_g, v148);
		b = v1.math_lerp(b, e_b, v148);
		v0 = v1.math_lerp(v0, e_a, v148);
		return color(r, g, b, v0);
	end
	local v149 = v2 - v0;
	v149 = v149 * v148;
	v149 = v149 + v0;
	if ((v2 == 0) and (v149 < 0.01) and (v149 > -0.01)) then
		v149 = 0;
	elseif ((v2 == 1) and (v149 < 1.01) and (v149 > 0.99)) then
		v149 = 1;
	end
	return v149;
end;
v1.vector_lerp = function(v0, v2, v3)
	return v0 + ((v2 - v0) * v3);
end;
local MN3 = gui.add_listbox(" ", "lua>tab b", 1, false, {"AA Helper"})
local MN2 = gui.add_listbox("  ", "lua>tab b", 1, false, {"Rage"})
local MN1 = gui.add_listbox("   ", "lua>tab b", 1, false, {"UI"})
local MN4 = gui.add_listbox("    ", "lua>tab b", 1, false, {"FakeLag"})
local MN5 = gui.add_listbox("     ", "lua>tab b", 1, false, {"Anti-Aim builder"})
local MN6 = gui.add_listbox("      ", "lua>tab b", 1, false, {"More"})
v1.anim_new = function(v0, v2, v3, v7)
	if not v1.anim_list[v0] then
		v1.anim_list[v0] = {};
		v1.anim_list[v0].color = render.color(0, 0, 0, 0);
		v1.anim_list[v0].number = 0;
		v1.anim_list[v0].call_frame = true;
	end
	if (v3 == nil) then
		v1.anim_list[v0].call_frame = true;
	end
	if (v7 == nil) then
		v7 = 0.1;
	end
	if (type(v2) == "userdata") then
		lerp = v1.math_lerp(v1.anim_list[v0].color, v2, v7);
		v1.anim_list[v0].color = lerp;
		return lerp;
	end
	lerp = v1.math_lerp(v1.anim_list[v0].number, v2, v7);
	v1.anim_list[v0].number = lerp;
	return lerp;
end;
j.vector_lerp = function(k, j, s) return k + (j - k) * s end
j.anim_new = function(k, s, c, N)
    if not j.anim_list[k] then
        j.anim_list[k] = {}
        j.anim_list[k].color = render.color(0, 0, 0, 0)
        j.anim_list[k].number = 0
        j.anim_list[k].call_frame = true
    end
    if c == nil then j.anim_list[k].call_frame = true end
    if N == nil then N = .1 end
    if type(s) == 'userdata' then
        lerp = j.math_lerp(j.anim_list[k].color, s, N)
        j.anim_list[k].color = lerp
        return lerp
    end
    lerp = j.math_lerp(j.anim_list[k].number, s, N)
    j.anim_list[k].number = lerp
    return lerp
end
local v108 = {};
local function v111()
	local v202 = entities.get_entity(engine.get_local_player());
	if not v202 then
		return false;
	end
	return v202:get_prop("m_iHealth") > 0;
end
local function v105(v0)
	return math.floor(tonumber(v0));
end
local v106 = {new=function(v0, v2, v3)
	if (v3 ~= nil) then
		return math.vec3(v0, v2, v3);
	else
		return (math.vec3(v0, v2, 0)):to2d();
	end
end};
local v107 = {new=function(v0, v2, v3, v7)
	v0 = ((v0 ~= nil) and v0) or 255;
	v2 = ((v2 ~= nil) and v2) or 255;
	v3 = ((v3 ~= nil) and v3) or 255;
	v7 = ((v7 ~= nil) and v7) or 255;
	return render.color(v0, v2, v3, v7);
end};
local function v109(v0, v2, v3, v7, v98)
	v98 = (v98 and v98) or 60;
	if (v108[v0] == nil) then
		v108[v0] = v2;
	end
	if v7 then
		v108[v0] = v108[v0] + ((v3 - v108[v0]) / (((101 - v98) / 100) * 15));
	else
		v108[v0] = v108[v0] + ((v2 - v108[v0]) / (((100 - v98) / 100) * 15));
	end
	return v105(v108[v0]);
end
local v120 = {total_size=23,damage=0,damage_bind=nil};
local function v110(v0, v2, v3, v7)
	if v7 then
		v3 = 1 - v3;
	end
	local v201 = render.color(v0.r + ((v2.r - v0.r) * v3), v0.g + ((v2.g - v0.g) * v3), v0.b + ((v2.b - v0.b) * v3), v0.a + ((v2.a - v0.a) * v3));
	return v201;
end
local v112 = {Outline=render.font_flag_outline,Shadow=render.font_flag_shadow};
local v113 = {rect=function(v0, v2, v3, v7)
	if v7 then
		render.rect_filled(v0.x, v0.y, v2.x, v2.y, v3);
	else
		render.rect(v0.x, v0.y, v2.x, v2.y, v3);
	end
end,rect_fade=function(v0, v2, v3, v7, v98, v99)
	render.rect_filled_multicolor(v0.x, v0.y, v2.x, v2.y, v3, v7, v99, v98);
end,circle=function(v0, v2, v3, v7)
	if v7 then
		render.circle_filled(v0.x, v0.y, v2, v3);
	else
		render.circle(v0.x, v0.y, v2, v3);
	end
end,line=function(v0, v2, v3)
	render.line(v0.x, v0.y, v2.x, v2.y, v3);
end,text=function(v0, v2, v3, v7)
	return render.text(v2, v3.x, v3.y, v0, v7);
end,text_size=function(v0, v2)
	local v203, v204 = render.get_text_size(v0, v2);
	return v106.new(v203, v204);
end,screen_size=function()
	local v205, v206 = render.get_screen_size();
	return v106.new(v205, v206);
end,mouse_pos=function()
	local v207, v208 = input.get_cursor_pos();
	return v106.new(v207, v208);
end,load_font=function(v0, v2, v3)
	if (v3 ~= nil) then
		return render.create_font(v0, v2, v3);
	else
		return render.create_font(v0, v2);
	end
end};
local v114 = {indicators=v113.load_font("arialbd.ttf", 21),indicators1=v113.load_font("arial.ttf", 13)};

local s = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function c(k)
    return (k:gsub('.', function(k)
        local j, s = '', k:byte()
        for k = 8, 1, -1 do j = j .. (s % 2 ^ k - s % 2 ^ (k - 1) > 0 and '1' or '0') end
        return j
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(k)
        if #k < 6 then return '' end
        local j = 0
        for s = 1, 6, 1 do j = j + (k:sub(s, s) == '1' and 2 ^ (6 - s) or 0) end
        return s:sub(j + 1, j + 1)
    end) .. ({ '', '==', '=' })[#k % 3 + 1]
end
local function N(k)
    k = string.gsub(k, '[^' .. (s .. '=]'), '')
    return (k:gsub('.', function(k)
        if k == '=' then return '' end
        local j, c = '', s:find(k) - 1
        for k = 6, 1, -1 do j = j .. (c % 2 ^ k - c % 2 ^ (k - 1) > 0 and '1' or '0') end
        return j
    end)):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(k)
        if #k ~= 8 then return '' end
        local j = 0
        for s = 1, 8, 1 do j = j + (k:sub(s, s) == '1' and 2 ^ (8 - s) or 0) end
        return string.char(j)
    end)
end
local function m(k, j)
    local s = {}
    for k in string.gmatch(k, '([^' .. (j .. ']+)')) do s[#s + 1] = string.gsub(k, '\n', ' ') end
    return s
end
local function D(k)
    if k == 'true' or k == 'false' then
        return k == 'true'
    else
        return k
    end
end

local pixel = render.font_esp
local calibri11 = render.create_font("calibri.ttf", 11, render.font_flag_outline)
local calibri13 = render.create_font("calibri.ttf", 13, render.font_flag_shadow)
local verdana = render.create_font("verdana.ttf", 13, render.font_flag_outline)
local tahoma = render.create_font("tahoma.ttf", 13, render.font_flag_shadow)

local delay_jitter_tick = 0
local flip = false

enable_delay_jitter = checkbox("Enable Delay Jitter", "lua>tab b")
yaw_delay = slider("Delay", "lua>tab b", 1, 20, 1)
yaw_range = slider("Delay Jitter Amount", "lua>tab b", 0, 90, 1)

local abs = function(val)
    if val < 0 then
        return -val
    end

    return val
end


    


function delay_jitter()
    if not enable_delay_jitter:get_bool() then return end
    local int_delay = yaw_delay:get_int()
    local int_range = yaw_range:get_int()
    local tickcount = global_vars.tickcount

    for i = 0, 6 do 
        if abs(delay_jitter_tick - tickcount) > int_delay then
            flip = not flip
            delay_jitter_tick = tickcount
        end

        yawAdd:set_int(flip and int_range or -int_range)
    end
end

local refs = {
    yawadd = Find("Rage>Anti-Aim>Angles>Yaw add");
    yawaddamount = Find("Rage>Anti-Aim>Angles>Add");
    spin = Find("Rage>Anti-Aim>Angles>Spin");
    jitter = Find("Rage>Anti-Aim>Angles>Jitter");
    spinrange = Find("Rage>Anti-Aim>Angles>Spin range");
    spinspeed = Find("Rage>Anti-Aim>Angles>Spin speed");
    jitterrandom = Find("Rage>Anti-Aim>Angles>Random");
    jitterrange = Find("Rage>Anti-Aim>Angles>Jitter Range");
    desync = Find("Rage>Anti-Aim>Desync>Fake amount");
    compAngle = Find("Rage>Anti-Aim>Desync>Compensate angle");
    freestandFake = Find("Rage>Anti-Aim>Desync>Freestand fake");
    flipJittFake = Find("Rage>Anti-Aim>Desync>Flip fake with jitter");
    leanMenu = Find("Rage>Anti-Aim>Desync>Roll lean");
    leanamount = Find("Rage>Anti-Aim>Desync>Lean amount");
    ensureLean = Find("Rage>Anti-Aim>Desync>Ensure Lean");
    flipJitterRoll = Find("Rage>Anti-Aim>Desync>Flip lean with jitter");
};

local var = {
    player_states = {"Standing", "Moving", "Slow motion", "Air", "Air Duck", "Crouch"};
};

---speed function
function get_local_speed()
    local local_player = entities.get_entity(engine.get_local_player())
    if local_player == nil then
      return
    end
  
    local velocity_x = local_player:get_prop("m_vecVelocity[0]")
    local velocity_y = local_player:get_prop("m_vecVelocity[1]")
    local velocity_z = local_player:get_prop("m_vecVelocity[2]")
  
    local velocity = math.vec3(velocity_x, velocity_y, velocity_z)
    local speed = math.ceil(velocity:length2d())
    if speed < 10 then
        return 0
    else 
        return speed 
    end
end

--fps stuff
function accumulate_fps()
    return math.ceil(1 / global_vars.frametime)
end
--tickrate function
function get_tickrate()
    if not engine.is_in_game() then return end

    return math.floor( 1.0 / global_vars.interval_per_tick )
end
---ping function
function get_ping()
    if not engine.is_in_game() then return end

    return math.ceil(utils.get_rtt() * 1000);
end

-- character table string
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- encoding
local function enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

-- decoding
local function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

--import and export system
local function str_to_sub(text, sep)
    local t = {}
    for str in string.gmatch(text, "([^"..sep.."]+)") do
        t[#t + 1] = string.gsub(str, "\n", " ")
    end
    return t
end

local function to_boolean(str)
    if str == "true" or str == "false" then
        return (str == "true")
    else
        return str
    end
end

local function animation(check, name, value, speed) 
    if check then 
        return name + (value - name) * global_vars.frametime * speed / 1.5
    else 
        return name - (value + name) * global_vars.frametime * speed / 1.5
        
    end
end


engine.exec("fps_max 0")


print("Loading...")
print("Initializing shetech...")
print("done, <3 ")
print("id/neksusha")
print("dsc.gg/lagcomp")

local MenuSelection = gui.add_listbox('Current.Tab', "lua>tab a", 7, false, { '--->   Global                                 <---', '--->   Rage                                   <---',  '--->   AntiAim                               <---', '--->   Anti-Aim-helpers                  <---', '--->   Fakelag++                            <---','--->   Misc                                    <---', '--->   UI                                       <---',  })
local Misc_list = gui.add_listbox("Information", "lua>tab a", 3, true, {"https://dsc.gg/lagcomp", "Owner-meowsync",})
local v14 = "lua>tab a>";
local v15 = "lua>tab b>";

local resolver_reference = gui.get_config_item("rage>aimbot>aimbot>resolver mode")
local checkbox = gui.add_checkbox("Force roll resolver", "lua>tab b")
gui.add_keybind("lua>tab b>force roll resolver")
local default = resolver_reference:get_int()
local DAMain = Checkbox("Dormant Aimbot", "lua>tab b")
local DA = AddKeybind("lua>tab b>Dormant Aimbot")
local FL0 = Checkbox("Better Hideshots", "lua>tab b")
local hstype = Combo("Hideshots Type", "lua>tab b", {"Favor firerate", "Favor fakelag", "Break lagcomp"})
local ragebotlogs = Checkbox("Ragebot logs", "lua>tab b")
local ideal_peek_enable = gui.add_checkbox("Ideal peek", "lua>tab b")
local inair_hit = gui.add_checkbox('hithcance', "lua>tab b")
gui.add_keybind("lua>tab b>hithcance")
local inair = gui.get_config_item("Rage>Aimbot>ssg08>Scout>Hitchance")
local cl_sidespeed = cvar.cl_sidespeed
local cl_forwardspeed = cvar.cl_forwardspeed
local cl_backspeed = cvar.cl_backspeed
local slowwalk_box = gui.add_checkbox("Slow Walk", "lua>tab b")
local slowwalk_slider = gui.add_slider("Speed", "lua>tab b", 1, 100, 1)


function set_speed( new_speed )
    if ( cl_sidespeed:get_int() == 450 and new_speed == 450 ) then
        return;
    end
     cl_sidespeed:set_float( new_speed );
     cl_forwardspeed:set_float( new_speed );
     cl_backspeed:set_float( new_speed );
end



--end of ragebot

--start of AA

local yawadd = gui.get_config_item("Rage>Anti-Aim>Angles>Add")
local jitterange = gui.get_config_item("Rage>Anti-Aim>Angles>Jitter range")
local pitch = gui.get_config_item("Rage>Anti-Aim>Angles>Pitch")

local pitch = gui.get_config_item("Rage>Anti-Aim>Angles>Pitch")
local defensivedt = gui.add_checkbox("Pitch exploit", "lua>tab b")

local aa = {
    cheker = 0,
    defensive = false,
}

function UpdateAll()
    if engine.is_in_game() == false then return end
    local localplayer = entities.get_entity(engine.get_local_player())
    local tickbase = localplayer:get_prop("m_nTickBase")
     aa.defensive = math.abs(tickbase - aa.cheker) >= 1.3
     aa.cheker = math.max(tickbase, aa.cheker or 0)
    if defensivedt:get_bool() then
        if aa.defensive then
            pitch:set_int(2)
			else
            pitch:set_int(1)
	    end
    end
end


ConditionalStates[0] = {
	player_state = Combo("[Conditions]", "lua>tab b", var.player_states);
}
for i=1, 6 do
	ConditionalStates[i] = {
        ---Anti-Aim
        yawadd = Checkbox("Yaw add " .. var.player_states[i], "lua>tab b");
        yawaddamount = Slider("Add " .. var.player_states[i], "lua>tab b", -180, 180, 1);
        spin = Checkbox("Spin " .. var.player_states[i], "lua>tab b");
        spinrange = Slider("Spin range " .. var.player_states[i], "lua>tab b", 0, 360, 1);
        spinspeed = Slider("Spin speed " .. var.player_states[i], "lua>tab b", 0, 360, 1);
        jitter = Checkbox("Jitter " .. var.player_states[i], "lua>tab b");
        jittertype = Combo("Jitter Type " .. var.player_states[i], "lua>tab b", {"Center", "Offset", "Random"});
        jitterrange = Slider("Jitter range " .. var.player_states[i], "lua>tab b", 0, 360, 1);
        ---Desync
        desynctype = Combo("Desync Type " .. var.player_states[i], "lua>tab b", {"Static", "Jitter", "Random"});
        desync = Slider("Desync " .. var.player_states[i], "lua>tab b", -100, 100, 1);
        compAngle = Slider("Comp " .. var.player_states[i], "lua>tab b", 0, 100, 1);
        flipJittFake = Checkbox("Flip fake " .. var.player_states[i], "lua>tab b");
    };
end

local font2 = render.create_font("verdana.ttf", 20, 1)


function inairh()
    if inair_hit:get_bool() then
        inair:set_int(35)
    else
        inair:set_int(72)
    end
end

 local function print_logo()
    local menuopen = gui.is_menu_open()
    local menupos_x1, menupos_y1, menupos_x2, menupos_y2 = gui.get_menu_rect()
    local textsize_w, textsize_h = render.get_text_size(font2, "dsc.gg/lagcomp")
    if menuopen then
        render.push_uv(0, 0, 1, 1)
        render.pop_uv()
        render.pop_uv()
        render.text(font2, menupos_x2 - textsize_w - 665, menupos_y1 - textsize_h, "shetech [cute]                                                                                                             dsc.gg/lagcomp", render.color(255, 208, 208))
    end
end


local StaticFS = Checkbox("Static Freestand", "lua>tab b")
local FF = Checkbox("FakeFlick", "lua>tab b")
local way = Checkbox("3way anti-aim", "lua>tab b")
local FFK = AddKeybind("lua>tab b>FakeFlick")
local IV = Checkbox("Inverter", "lua>tab b")
local IVK = AddKeybind("lua>tab b>Inverter")
local R = gui.get_config_item('Rage>Anti-Aim>Desync>Leg Slide')
local h = gui.add_checkbox('Legbreaker', v15)

local u = utils.new_timer(31, function() if h:get_bool() then R:set_int(1) end end)
u:start()
local E = utils.new_timer(50, function() if h:get_bool() then R:set_int(2) end end)
E:start()
--end of AA
--visuals and misc
local colormains = Checkbox("Main Theme", "lua>tab b")
local colormain = CPicker("lua>tab b>Main Theme", false)
local watermarkcheckbox, v88, v89, v90 = MultiCombo("Solus UI", "lua>tab b", {"Watermark","Keybinds","Idealtick"});
local clantagmain = Checkbox("Clantag", "lua>tab b")
local ind = gui.add_checkbox("Indicators", "lua>tab b")
local color = gui.add_colorpicker("lua>tab b>Indicators", true)
local v92 = gui.add_checkbox("Enable world hitmarker", v15);
local v95 = {};
local trashtalk = gui.add_checkbox("Killsay", "lua>tab b")

local v91 = gui.add_combo("UI | Type", v15, {"New"});
local v97 = render.font_esp;
render.window = function(v0, v2, v3, v7, v98, v99, v100, v101)
	local v189 = render.color(v98, v99, v100, 255 * v101);
	local colormain0 = render.color(0, 0, 0, 0);
	if (v91:get_int() == 0) then
		for v309 = 1, 10, 1 do
			render.rect_filled_rounded((v0 + 2) - v309, (v2 + 2) - v309, (v3 - 2) + v309, (v7 - 2) + v309, render.color((colormain:get_color()).r, (colormain:get_color()).g, (colormain:get_color()).b, (20 - (2 * v309)) * 165 * (v101 / 255)), 5);
		end
		render.rect_filled_rounded(v0 + 2, v2 + 2, v3 - 2, v7 - 2, v189, 5);
		render.rect_filled_rounded(v0 + 3, v2 + 3, v3 - 3, v7 - 2, render.color(11, 11, 11, 255 * v101), 5);
	end
end;
local v96 = render.create_font("verdana.ttf", 18);

idealtickvisualiser = function()
	local v191 = {(gui.get_config_item("rage>aimbot>aimbot>double tap")):get_bool(),(gui.get_config_item("rage>aimbot>aimbot>hide shot")):get_bool(),(gui.get_config_item("rage>aimbot>ssg08>scout>override")):get_bool(),(gui.get_config_item("rage>aimbot>aimbot>headshot only")):get_bool(),(gui.get_config_item("misc>movement>fake duck")):get_bool(),(gui.get_config_item("misc>movement>peek assist")):get_bool()};
	local v192 = entities.get_entity(engine.get_local_player());
	if (v192 == nil) then
		return;
	end
	if not v192:is_alive() then
		return;
	end
	local v193, v194 = render.get_screen_size();
	doubletapen = v1.anim_new("doubletapenxx", (v89:get_bool() and 1) or 0);
	doubletap = v1.anim_new("doubletapxx", (((v191[1] and v191[6]) or gui.is_menu_open()) and 1) or 0);
	numberdt = v1.anim_new("numberdttxx", (v191[1] and 101) or 0);
	local v195, v196 = render.get_text_size(render.font_esp, "+/- charged idealtick ticks %50");
	local v197 = v192:get_prop("m_flVelocityModifier");
	local v198, v199 = render.get_text_size(render.font_esp, "slowed %" .. (v197 * 100));
	vv = math.floor(numberdt * 1);
	local v200 = math.abs(1 * math.cos((2 * math.pi * (global_vars.curtime + 3)) / 2)) * 255;
	render.text(render.font_esp, (v193 / 2) - (v195 / 2), (v194 / 3) + 95, "+/- charged idealtick ticks %" .. vv, render.color(255, 255, 255, 255 * doubletap * doubletapen));
	render.text(render.font_esp, (v193 / 2) - (v198 / 2), (v194 / 3) + 95 + 9, "slowed %" .. (v197 * 100), render.color(255, 255, 255, v200 * doubletap * doubletapen));
end;


toya = function()
	if not v92:get_bool() then
		return;
	end
	local v174 = 3.5;
	local v175 = 2.5;
	for v248, v249 in pairs(v95) do
		if v249.draw then
			if (global_vars.curtime >= v249.time) then
				v249.alpha = v249.alpha - 2;
			end
			if (v249.alpha <= 0) then
				v249.alpha = 0;
				v249.draw = false;
			end
			local v307, v308 = utils.world_to_screen(v249.x, v249.y, v249.z);
			if (v307 ~= nil) then
				local v348;
				v348 = colormain:get_color();
				local v349 = v249.damage .. "";
				local v350, v351 = render.get_text_size(v96, v349);
				local v352 = math.floor(v249.alpha);
				render.rect_filled(v307 - 6, v308 - 1, v307 + 6, v308 + 1, render.color(v348.r, v348.g, v348.b, v352));
				render.rect_filled(v307 - 1, v308 - 6, v307 + 1, v308 + 6, render.color(v348.r, v348.g, v348.b, v352));
			end
		end
	end
end;

on_round_start = function()
	if not v92:get_bool() then
		return;
	end
	v95 = {};
end;

on_player_hurt = function(v0)
	if not v92:get_bool() then
		return;
	end
	local v176 = entities.get_entity(engine.get_player_for_user_id(v0:get_int("userid")));
	local v177 = engine.get_player_for_user_id(v0:get_int("attacker"));
	if (v177 ~= engine.get_local_player()) then
		return;
	end
	local v178 = global_vars.tickcount;
	local v179 = v95[v178];
	if ((v95[v178] == nil) or (v179.impacts == nil)) then
		return;
	end
	local v180 = {[1]={0,1},[2]={4,5,6},[3]={2,3},[4]={13,15,16},[5]={14,17,18},[6]={7,9,11},[7]={8,10,12}};
	local v181 = v179.impacts;
	local v182 = v180[v0:get_int("hitgroup")];
	local v183 = nil;
	local v184 = math.huge;
	for v250 = 1, #v181, 1 do
		local v251 = v181[v250];
		if (v182 ~= nil) then
			for v332 = 1, #v182, 1 do
				local v333, v334, v335 = v176:get_hitbox_position(v182[v332]);
				local v336 = math.sqrt(((v251.x - v333) ^ 2) + ((v251.y - v334) ^ 2) + ((v251.z - v335) ^ 2));
				if (v336 < v184) then
					v183 = v251;
					v184 = v336;
				end
			end
		end
	end
	if (v183 == nil) then
		return;
	end
	v95[v178] = {x=v183.x,y=v183.y,z=v183.z,time=((global_vars.curtime + 1) - 0.25),alpha=255,damage=v0:get_int("dmg_health"),kill=(v0:get_int("health") <= 0),hs=((v0:get_int("hitgroup") == 0) or (v0:get_int("hitgroup") == 1)),draw=true};
end;
on_bullet_impact = function(v0)
	if not v92:get_bool() then
		return;
	end
	if (engine.get_player_for_user_id(v0:get_int("userid")) ~= engine.get_local_player()) then
		return;
	end
	local v186 = global_vars.tickcount;
	if (v95[v186] == nil) then
		v95[v186] = {impacts={}};
	end
	local v187 = v95[v186].impacts;
	if (v187 == nil) then
		v187 = {};
	end
	v187[#v187 + 1] = {x=v0:get_int("x"),y=v0:get_int("y"),z=v0:get_int("z")};
end;

local tU = { { text = 'FakeDuck', path = 'misc>movement>fake duck' }, { text = 'Pew-Pew', path = 'rage>aimbot>aimbot>double tap' },
{ text = 'OnShot', path = 'rage>aimbot>aimbot>hide shot' }, { text = '+/- IdealTicking', path = 'rage>anti-aim>angles>freestand' }, { text = 'HeadShow', path = 'rage>aimbot>aimbot>headshot only' },
{ text = 'Roll', path = 'rage>anti-aim>desync>ensure lean' }, { text = 'meow-sync', path = 'rage>aimbot>aimbot>Target dormant' }, { text = 'cl_lagcomp 0', path = 'rage>aimbot>aimbot>Anti-exploit' },
{ text = 'MinDMG', path = 'rage>aimbot>ssg08>scout>override' }, { text = 'AA', path = 'lua>tab b>hithcance' }, }

local fU = gui.add_checkbox("Skeet Indicators", "lua>tab b")
local VU = function()
    local k = entities.get_entity(engine.get_local_player())
    local j = k:get_prop('m_vecVelocity[0]')
    local s = k:get_prop('m_vecVelocity[1]')
    return math.sqrt(j * j + s * s)
end
local eU = function()
    local k = {}
    for j, s in pairs(tU) do if (gui.get_config_item(s.path)):get_bool() then table.insert(k, s.text) end end
    return k
end
local pU = math.vec3(render.get_screen_size())
local JU = function(k, j, s) return math.floor(k + (j - k) * s) end
local GU = { 0, 0, 0, 0, 0 }
local iU = render.create_font('calibrib.ttf', 23, render.font_flag_shadow)

function skeetind()
    if fU:get_bool() then
        local k = entities.get_entity(engine.get_local_player())
        if not k then return end
        add_y = 0
        if info.fatality.can_fastfire then
            GU[1] = JU(GU[1], 255, global_vars.frametime * 11)
            add_y = add_y + 7
        else
            if GU[1] > 0 then add_y = add_y + 7 end
            GU[1] = JU(GU[1], 0, global_vars.frametime * 11)
        end
        local s = j.anim_new('m_bIsScoped add dbbx2', info.fatality.can_fastfire and 1 or .01)
        local c = gui.get_config_item('rage>anti-aim>desync>lean amount')
        local N = (c:get_int() / 100) * 2
        local m = info.fatality.can_fastfire and render.color(255, 255, 255, GU[1]) or render.color(226, 54, 55, 255)
        for k, c in pairs(eU()) do
            local D = { x = 10, y = (pU.y / 2 + 98) + 35 * (k - 1) }
            local H = utils.random_int(15, 100) / 100
            local v = j.anim_new('aainverted1xq34', fU:get_bool() and utils.random_int(15, 100) / 100 or 0)
            local l = render.color(150, 200, 30)
            if c == 'AA' then
                l = render.color(255, 208, 208)
                render.circle(D.x + 50, D.y + 10, 5, render.color(0, 0, 0, 255), 3, 22, 1, 1)
                render.circle(D.x + 50, D.y + 10, 5, render.color(255, 208, 208, 255), 3, 12, H, 1)
            end
            if c == 'Pew-Pew' then
                l = m
              render.circle(D.x + 200, D.y + 0, 0, render.color(255, 208, 208, 255), 3, 22, 1, 1)
              render.circle(D.x + 110, D.y + 10, 5, render.color(255, 255, 255, 255), 3, 12, H, 1)  
            end
            if c == 'OnShot' then if not info.fatality.can_onshot then l = render.color(125, 130, 209) end end
            if c == 'OnShot' then if not info.fatality.can_onshot then l = render.color(125, 130, 209) end end
            if c == 'ROLL' then
                l = render.color(232, 113, 111)
                render.circle(D.x + 68, D.y + 10, 5, render.color(0, 0, 0, 255), 3, 22, 1, 1)
                render.circle(D.x + 68, D.y + 10, 5, render.color(232, 113, 111, 255), 3, 12, N, 1)
            end
            local U = math.floor(math.abs(math.sin(global_vars.realtime) * 2) * 255)
            if c == 'FW' then l = render.color((M:get_color()).r, (M:get_color()).g, (M:get_color()).b, U) end
            local Y = math.vec3(render.get_text_size(iU, c))
            for k = 1, 10, 1 do render.rect_filled_rounded((D.x + 4) - k, D.y - k, ((D.x + Y.x) + 8) + k, ((D.y + Y.y) - 3) + k, render.color(l.r, l.g, l.b, (20 - 2 * k) * .35), 10) end
            render.text(iU, D.x + 8, D.y, c, l)
        end
    end
end

--fakelag
local fluctuateswitch = gui.add_checkbox("Fluctuate Fakelag", "lua>tab b")
local fakelaglimit = gui.get_config_item("rage>anti-aim>fakelag>limit")
local flmode = gui.get_config_item("rage>anti-aim>fakelag>mode")
local hs = gui.get_config_item("rage>aimbot>aimbot>hide shot")
local disflonhsswitch = gui.add_checkbox("Disable FL on HS", "lua>tab b")
local defaultfl = gui.add_combo("Fake Lag", "lua>tab b", {"Always on", "Adaptive"})
local fllimit = gui.add_slider("Limit", "lua>tab b", 0, 17, 7)


--updates menu elements and refs
function MenuElements()
    for i=1, 6 do
        local tab = MenuSelection:get_int()
        local state = ConditionalStates[0].player_state:get_int() + 1
        local yawAddCheck = ConditionalStates[i].yawadd:get_bool()
        local spinCheck = ConditionalStates[i].spin:get_bool()
        local jitterCheck = ConditionalStates[i].jitter:get_bool()
        local BH = FL0:get_bool()


        --ragebot
		gui.set_visible("lua>tab b>  ", tab == 1);
        gui.set_visible("lua>tab b>Dormant Aimbot", tab == 1);
		gui.set_visible("lua>tab b>hithcance", tab == 1);
        gui.set_visible("lua>tab b>Better Hideshots", tab == 1);
        gui.set_visible("lua>tab b>Hideshots Type", tab == 1 and BH);
        gui.set_visible("lua>tab b>Ragebot logs", tab == 1);
        gui.set_visible("lua>tab b>Ideal peek", tab == 1);
        gui.set_visible("lua>tab b>Force roll resolver", tab == 1);
        --antiaim
		gui.set_visible("lua>tab b>     ", tab == 2);
        gui.set_visible("lua>tab b>[Conditions]", tab == 2);
        gui.set_visible("lua>tab b>Yaw add " .. var.player_states[i], tab == 2 and state == i);
        gui.set_visible("lua>tab b>Add " .. var.player_states[i], tab == 2 and state == i and yawAddCheck);
        gui.set_visible("lua>tab b>Spin " .. var.player_states[i], tab == 2 and state == i);
        gui.set_visible("lua>tab b>Spin range " .. var.player_states[i], tab == 2 and state == i and spinCheck);
        gui.set_visible("lua>tab b>Spin speed " .. var.player_states[i], tab == 2 and state == i and spinCheck);
        gui.set_visible("lua>tab b>Jitter " .. var.player_states[i], tab == 2 and state == i);
        gui.set_visible("lua>tab b>Jitter Type " .. var.player_states[i], tab == 2 and state == i and jitterCheck);
        gui.set_visible("lua>tab b>Jitter range " .. var.player_states[i], tab == 2 and state == i and jitterCheck);
        --desync
        gui.set_visible("lua>tab b>Desync Type " .. var.player_states[i], tab == 2 and state == i);
        gui.set_visible("lua>tab b>Desync " .. var.player_states[i], tab == 2 and state == i);
        gui.set_visible("lua>tab b>Comp " .. var.player_states[i], tab == 2 and state == i);
        gui.set_visible("lua>tab b>Flip fake " .. var.player_states[i], tab == 2 and state == i);
        gui.set_visible("lua>tab b>Slow walk", tab ==1)
        gui.set_visible("lua>tab b>Speed", tab == 1)
        --aa helpers
		gui.set_visible("lua>tab b> ", tab == 3);
        gui.set_visible("lua>tab b>Static Freestand", tab == 3);
        gui.set_visible("lua>tab b>Pitch exploit", tab == 3);
        gui.set_visible("lua>tab b>FakeFlick", tab == 3);
		gui.set_visible("lua>tab b>Legbreaker", tab == 3);
        gui.set_visible("lua>tab b>Inverter", tab == 3);
		gui.set_visible("lua>tab b>Defensive Yaw", tab == 3);
		gui.set_visible("lua>tab b>3way anti-aim", tab == 3);
        gui.set_visible("lua>tab b>Delay", tab == 3)
        gui.set_visible("lua>tab b>Delay Jitter Amount", tab == 3)
        gui.set_visible("lua>tab b>Enable Delay Jitter", tab == 3)
        --fakelag
		gui.set_visible("lua>tab b>    ", tab == 4);
        gui.set_visible("lua>tab b>Fluctuate Fakelag", tab == 4);
        gui.set_visible("lua>tab b>Fake Lag", tab == 4);
        gui.set_visible("lua>tab b>Limit", tab == 4);
        gui.set_visible("lua>tab b>Disable FL on HS", tab == 4);
        --misc
		gui.set_visible("lua>tab b>      ", tab == 5);
        gui.set_visible("lua>tab b>Killsay", tab == 5);
		gui.set_visible("lua>tab b>Clantag", tab == 5);
        gui.set_visible("lua>tab b>Aspect Ratio", tab == 5);
        gui.set_visible("lua>tab b>Skeet Indicators", tab == 5);
		gui.set_visible("lua>tab b>Enable world hitmarker", tab == 5);
        --visuals tab
		gui.set_visible("lua>tab b>   ", tab == 6);
        gui.set_visible("lua>tab b>Main Theme", tab == 0);
        gui.set_visible("lua>tab b>Indicators", tab == 6);
        gui.set_visible("lua>tab b>Solus UI", tab == 5);
        gui.set_visible("lua>tab b>UI | Type", tab == 6);
    end
end
--end of menu elements and refs
--ragebot start
local hs = gui.get_config_item("Rage>Aimbot>Aimbot>Hide shot")
local dt = gui.get_config_item("Rage>Aimbot>Aimbot>Double tap")
local limit = gui.get_config_item("Rage>Anti-Aim>Fakelag>Limit")

-- cache fakelag limit
local cache = {
  backup = limit:get_int(),
  override = false,
}

cvar.cl_disablefreezecam:set_float(1)
cvar.cl_disablehtmlmotd:set_float(1)
cvar.r_dynamic:set_float(0)
cvar.r_3dsky:set_float(0)
cvar.r_shadows:set_float(0)
cvar.cl_csm_static_prop_shadows:set_float(0)
cvar.cl_csm_world_shadows:set_float(0)
cvar.cl_foot_contact_shadows:set_float(0)
cvar.cl_csm_viewmodel_shadows:set_float(0)
cvar.cl_csm_rope_shadows:set_float(0)
cvar.cl_csm_sprite_shadows:set_float(0)
cvar.cl_freezecampanel_position_dynamic:set_float(0)
cvar.cl_freezecameffects_showholiday:set_float(0)
cvar.cl_showhelp:set_float(0)
cvar.cl_autohelp:set_float(0)
cvar.mat_postprocess_enable:set_float(0)
cvar.fog_enable_water_fog:set_float(0)
cvar.gameinstructor_enable:set_float(0)
cvar.cl_csm_world_shadows_in_viewmodelcascade:set_float(0)
cvar.cl_disable_ragdolls:set_float(0)

function RB()

if FL0:get_bool() then
  if hstype:get_int() == 0 and not dt:get_bool() then
    if hs:get_bool() then
        limit:set_int(1)
        cache.override = true
    else
        if cache.override then
        limit:set_int(cache.backup)
        cache.override = false
        else
        cache.backup = limit:get_int()
        end
      end
    end
  end

  if FL0:get_bool() then
    if hstype:get_int() == 1 and not dt:get_bool() then
      if hs:get_bool() then
          limit:set_int(9)
          cache.override = true
      else
          if cache.override then
          limit:set_int(cache.backup)
          cache.override = false
          else
          cache.backup = limit:get_int()
          end
        end
      end
    end

if FL0:get_bool() then
    if hstype:get_int() == 2 and not dt:get_bool() then
        if hs:get_bool() then
            limit:set_int(global_vars.tickcount % 32 >= 4 and 14 or 1)
            cache.override = true
        else
            if cache.override then
            limit:set_int(cache.backup)
            cache.override = false
            else
            cache.backup = limit:get_int()
            end
        end
    end
end
end

local TargetDormant = Find("rage>aimbot>aimbot>target dormant")

local function DA()

TargetDormant:set_bool(DAMain:get_bool())
    local local_player = entities.get_entity(engine.get_local_player())
    if not engine.is_in_game() or not local_player:is_valid() or not DAMain:get_bool() then
        return
    end
end
--ragebot end
--start of getting AA states and setting valeus

function UpdateStateandAA()

    local isSW = info.fatality.in_slowwalk
    local local_player = entities.get_entity(engine.get_local_player())
    local inAir = local_player:get_prop("m_hGroundEntity") == -1
    local vel_x = math.floor(local_player:get_prop("m_vecVelocity[0]"))
    local vel_y = math.floor(local_player:get_prop("m_vecVelocity[1]"))
    local still = math.sqrt(vel_x ^ 2 + vel_y ^ 2) < 5
    local cupic = bit.band(local_player:get_prop("m_fFlags"),bit.lshift(2, 0)) ~= 0
    local flag = local_player:get_prop("m_fFlags")

    playerstate = 0

    if inAir and cupic then
        playerstate = 5
    else
        if inAir then
            playerstate = 4
        else
            if isSW then
                playerstate = 3
            else
                if cupic then
                    playerstate = 6
                else
                    if still and not cupic then
                        playerstate = 1
                    elseif not still then
                        playerstate = 2
                    end
                end
            end
        end
    end

    refs.yawadd:set_bool(ConditionalStates[playerstate].yawadd:get_bool());
    if ConditionalStates[playerstate].jittertype:get_int() == 1 then
        refs.yawaddamount:set_int((ConditionalStates[playerstate].yawaddamount:get_int()) + (global_vars.tickcount % 4 >= 2 and 0 or ConditionalStates[playerstate].jitterrange:get_int()))
    else
        refs.yawaddamount:set_int(ConditionalStates[playerstate].yawaddamount:get_int());
    end
    refs.spin:set_bool(ConditionalStates[playerstate].spin:get_bool());
    refs.jitter:set_bool(ConditionalStates[playerstate].jitter:get_bool());
    refs.spinrange:set_int(ConditionalStates[playerstate].spinrange:get_int());
    refs.spinspeed:set_int(ConditionalStates[playerstate].spinspeed:get_int());
    refs.jitterrandom:set_bool(ConditionalStates[playerstate].jittertype:get_int() == 2);

    if ConditionalStates[playerstate].jittertype:get_int() == 0 or ConditionalStates[playerstate].jittertype:get_int() == 2 then
            refs.jitterrange:set_int(ConditionalStates[playerstate].jitterrange:get_int());
        else
            refs.jitterrange:set_int(0);
        end

    if ConditionalStates[playerstate].desync:get_int() == 60 and ConditionalStates[playerstate].desynctype:get_int() == 0 then
        refs.desync:set_int((ConditionalStates[playerstate].desync:get_int() * 1.666666667) - 2);
        else if ConditionalStates[playerstate].desync:get_int() == -60 and ConditionalStates[playerstate].desynctype:get_int() == 0 then
            refs.desync:set_int((ConditionalStates[playerstate].desync:get_int() * 1.666666667) + 2);
              else if ConditionalStates[playerstate].desynctype:get_int() == 0 then 
                refs.desync:set_int(ConditionalStates[playerstate].desync:get_int() * 1.666666667);
                    else if ConditionalStates[playerstate].desynctype:get_int() == 1 and 0 >= ConditionalStates[playerstate].desync:get_int() then 
                        refs.desync:set_int(global_vars.tickcount % 4 >= 2 and -18 * 1.666666667 or ConditionalStates[playerstate].desync:get_int() * 1.666666667 + 2);
                            else if ConditionalStates[playerstate].desynctype:get_int() == 1 and ConditionalStates[playerstate].desync:get_int() >= 0 then 
                                refs.desync:set_int(global_vars.tickcount % 4 >= 2 and 18 * 1.666666667 or ConditionalStates[playerstate].desync:get_int() * 1.666666667 - 2);
                                    else if ConditionalStates[playerstate].desynctype:get_int() == 2 and ConditionalStates[playerstate].desync:get_int() >= 0 then 
                                        refs.desync:set_int(utils.random_int(0, ConditionalStates[playerstate].desync:get_int() * 1.666666667));
                                            else if ConditionalStates[playerstate].desynctype:get_int() == 2 and ConditionalStates[playerstate].desync:get_int() <= 0 then 
                                                refs.desync:set_int(utils.random_int(ConditionalStates[playerstate].desync:get_int() * 1.666666667, 0));
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
    refs.compAngle:set_int(ConditionalStates[playerstate].compAngle:get_int());
    refs.flipJittFake:set_bool(ConditionalStates[playerstate].flipJittFake:get_bool());
end
local fontind = render.create_font("verdanab.ttf", 13, render.font_flag_shadow)
local fontbinds = render.create_font("calibrib.ttf", 11, render.font_flag_shadow)
local fontdmg = render.create_font("verdana.ttf", 13, render.font_flag_shadow)
local fontarrows = render.create_font("verdanab.ttf", 15)
local x, y = render.get_screen_size()
local function depressedyaw()

    local player = entities.get_entity(engine.get_local_player())

    if not engine.is_in_game() or not player:is_valid() or not ind:get_bool() then 
		return 
    end  

    --Binds
    local DT = gui.get_config_item("rage>aimbot>aimbot>double tap")
    local HS = gui.get_config_item("rage>aimbot>aimbot>hide shot")
    local PA = gui.get_config_item("misc>movement>peek assist")


    --depressedyaw & min-damage
    if ind:get_bool() then
        render.text(fontind, x / 2, y / 2 + 28, "shetech°", color:get_color(), render.align_center, render.align_center)
        
    end

    --Double Tap
    if DT:get_bool() and info.fatality.can_fastfire == true and ind:get_bool() then
        render.text(fontbinds, x / 2 + 0, y / 2 + 40, "DoubleTap", render.color(255, 255, 255), render.align_center, render.align_center)
    else
        if DT:get_bool() and info.fatality.can_fastfire == false and ind:get_bool() then
            render.text(fontbinds, x / 2, y / 2 + 40, "DoubleTap", render.color(255, 0, 0), render.align_center, render.align_center)
        end
    end

    --Hide Shot
    if HS:get_bool() and DT:get_bool() == false and ind:get_bool() then
        render.text(fontbinds, x / 2, y / 2 + 40, "HideShot", render.color(255, 255, 255), render.align_center, render.align_center)
    else
        if HS:get_bool() and ind:get_bool() then
            render.text(fontbinds, x / 2, y / 2 + 50, "HideShot", render.color(255, 255, 255), render.align_center, render.align_center)
        end
    end

    --Peek Assist
    if PA:get_bool() and ind:get_bool() and (DT:get_bool() == false and HS:get_bool() == false) then
        render.text(fontbinds, x / 2, y / 2 + 40, "+/- IdeakTicking", render.color(255, 255, 255), render.align_center, render.align_center)
    elseif PA:get_bool() and ind:get_bool() and (DT:get_bool() and HS:get_bool() == false) then
        render.text(fontbinds, x / 2, y / 2 + 50, "+/- IdeakTicking", render.color(255, 255, 255), render.align_center, render.align_center)
    elseif PA:get_bool() and ind:get_bool() and (DT:get_bool() == false and HS:get_bool()) then
        render.text(fontbinds, x / 2, y / 2 + 50, "+/- IdeakTicking", render.color(255, 255, 255), render.align_center, render.align_center)
    else 
        if PA:get_bool() and ind:get_bool() and DT:get_bool() and HS:get_bool() then
            render.text(fontbinds, x / 2, y / 2 + 60, "+/- IdeakTicking", render.color(255, 255, 255), render.align_center, render.align_center)
        end
    end
end
local AAfreestand = Find("Rage>Anti-Aim>Angles>Freestand")
local add = Find("Rage>Anti-Aim>Angles>Add")
local jitter = Find("Rage>Anti-Aim>Angles>Jitter Range")
local attargets = Find("Rage>Anti-Aim>Angles>At fov target")
local flipfake = Find("Rage>Anti-Aim>Desync>Flip fake with jitter")
local compfreestand = Find("Rage>Anti-Aim>Desync>Compensate Angle")
local fakefreestand = Find("Rage>Anti-Aim>Desync>Fake Amount")
local freestandfake  = Find("Rage>Anti-Aim>Desync>Freestand Fake")
local add_backup = add:get_int()
local jitter_backup = jitter:get_int()
local attargets_backup = attargets:get_bool()
local flipfake_backup = flipfake:get_bool()
local compfreestand_backup = compfreestand:get_int()
local fakefreestand_backup = fakefreestand:get_int()
local freestandfake_backup = freestandfake:get_int()
local restore_aa = false

local function StaticFreestand()
    if AAfreestand:get_bool() and StaticFS:get_bool() then
        add:set_int(0)
        jitter:set_int(0)
        flipfake:set_bool(false)
        compfreestand:set_int(0)
        freestandfake:set_int(0)
        restore_aa = true
    else
        if (restore_aa == true) then
            add:set_int(add_backup)
            jitter:set_int(jitter_backup)
            attargets:set_bool(attargets_backup)
            flipfake:set_bool(flipfake_backup)
            compfreestand:set_int(compfreestand_backup)
            freestandfake:set_int(freestandfake_backup)
            restore_aa = false
        else
            add_backup = add:get_int()
            jitter_backup = jitter:get_int()
            attargets_backup = attargets:get_bool()
            flipfake_backup = flipfake:get_bool()
            compfreestand_backup = compfreestand:get_int()
            freestandfake_backup = freestandfake:get_int()
        end
    end
end

local add = Find("Rage>Anti-Aim>Angles>Add")
local fakeangle = Find("Rage>Anti-Aim>Desync>Fake Amount")
local fakeamount = fakeangle:get_int() >= 0

local function FakeFlik()
    if FF:get_bool() then
        if global_vars.tickcount % 20 == 1 and fakeangle:get_int() >= 0 then
            add:set_int(80)
        else
            if global_vars.tickcount % 20 == 1 and 0 >= fakeangle:get_int() then
                add:set_int(-80)
            end
        end 
    end
end


local function treiway()
    if way:get_bool() then
        if global_vars.tickcount % 3 == 1 and fakeangle:get_int() >= 0 then
            add:set_int(50)
        else
            if global_vars.tickcount % 3 == 1 and 0 >= fakeangle:get_int() then
                add:set_int(-70)
            end
        end 
    end
end

local fakeangle = Find("Rage>Anti-Aim>Desync>Fake Amount")
local function InvertDesync()
    if IV:get_bool() then
        fakeangle:set_int(fakeangle:get_int() * -1)
    end
end


local v121 = {render.get_screen_size()};
local v122 = gui.add_slider("keybinds_x", v15, 0, v121[1], 1);
local v123 = gui.add_slider("keybinds_y", v15, 0, v121[2], 1);
gui.set_visible(v15 .. "keybinds_x", false);
gui.set_visible(v15 .. "keybinds_y", false);
animate = function(v0, v2, v3, v7, v98, v99)
	v7 = v7 * global_vars.frametime * 20;
	if (v98 == false) then
		if v2 then
			v0 = v0 + v7;
		else
			v0 = v0 - v7;
		end
	elseif v2 then
		v0 = v0 + ((v3 - v0) * (v7 / 100));
	else
		v0 = v0 - ((0 + v0) * (v7 / 100));
	end
	if v99 then
		if (v0 > v3) then
			v0 = v3;
		elseif (v0 < 0) then
			v0 = 0;
		end
	end
	return v0;
end;
drag = function(v0, v2, v3, v7)
	local v217, v218 = input.get_cursor_pos();
	local v219 = false;
	if input.is_key_down(1) then
		if ((v217 > v0:get_int()) and (v218 > v2:get_int()) and (v217 < (v0:get_int() + v3)) and (v218 < (v2:get_int() + v7))) then
			v219 = true;
		end
	else
		v219 = false;
	end
	if v219 then
		v0:set_int(v217 - (v3 / 2));
		v2:set_int(v218 - (v7 / 2));
	end
end;
vasss = render.create_font("verdana.ttf", 12, render.font_flag_shadow);
on_keybinds = function()
	if not v88:get_bool() then
		return;
	end
	local v220 = {v122:get_int(),v123:get_int()};
	local v221 = 0;
	local v222 = {(gui.get_config_item("rage>aimbot>aimbot>double tap")):get_bool(),(gui.get_config_item("rage>aimbot>aimbot>hide shot")):get_bool(),(gui.get_config_item("rage>aimbot>ssg08>scout>override")):get_bool(),(gui.get_config_item("rage>aimbot>aimbot>headshot only")):get_bool(),(gui.get_config_item("misc>movement>fake duck")):get_bool()};
	local v223 = {" Doubletap"," On-shot"," Override Damage"," Force Head"," Duck-peek Assist"," Force Head"};
	if not v222[4] then
		if not v222[5] then
			if not v222[3] then
				if not v222[1] then
					if not v222[6] then
						if not v222[2] then
							v221 = 0;
						else
							v221 = 38;
						end
					else
						v221 = 40;
					end
				else
					v221 = 41;
				end
			else
				v221 = 54;
			end
		else
			v221 = 63;
		end
	else
		v221 = 70;
	end
	animated_size_offset = animate(animated_size_offset or 0, true, v221, 60, true, false);
	local v224 = {(100 + animated_size_offset),21};
	local v225 = "ON";
	local v226 = render.get_text_size(v97, v225) + 7;
	local v227 = v222[3] or v222[4] or v222[5] or v222[6] or v222[7] or v222[8];
	local v228 = v222[1] or v222[2] or v222[9] or v222[10] or v222[11];
	drag(v122, v123, v224[1], v224[2]);
	local v229 = math.floor(math.abs(math.sin(global_vars.realtime) * 2) * 255);
	alpha = animate(alpha or 0, gui.is_menu_open() or v227 or v228, 1, 0.5, false, true);
	local v230, v231 = render.get_text_size(v97, "keybinds");
	render.window(v220[1], v220[2], v220[1] + v224[1], v220[2] + v224[2], (colormain:get_color()).r, (colormain:get_color()).g, (colormain:get_color()).b, alpha);
	render.text(v97, ((v220[1] + (v224[1] / 2)) - (render.get_text_size(v97, "keybinds") / 2)) - 1, v220[2] + 7, "keybinds", render.color((colormain:get_color()).r, (colormain:get_color()).g, (colormain:get_color()).b, 255 * alpha));
	local v232 = 0;
	dt_alpha = animate(dt_alpha or 0, v222[1], 1, 0.5, false, true);
	render.text(v97, v220[1] + 6, v220[2] + v224[2] + 2, v223[1], render.color(255, 255, 255, 255 * dt_alpha));
	render.text(v97, (v220[1] + v224[1]) - v226, v220[2] + v224[2] + 2, v225, render.color((colormain:get_color()).r, (colormain:get_color()).g, (colormain:get_color()).b, (colormain:get_color()).a * dt_alpha));
	if v222[1] then
		v232 = v232 + 11;
	end
	hs_alpha = animate(hs_alpha or 0, v222[2], 1, 0.5, false, true);
	render.text(v97, v220[1] + 6, v220[2] + v224[2] + 2 + v232, v223[2], render.color(255, 255, 255, 255 * hs_alpha));
	render.text(v97, (v220[1] + v224[1]) - v226, v220[2] + v224[2] + 2 + v232, v225, render.color((colormain:get_color()).r, (colormain:get_color()).g, (colormain:get_color()).b, (colormain:get_color()).a * hs_alpha));
	if v222[2] then
		v232 = v232 + 11;
	end
	dmg_alpha = animate(dmg_alpha or 0, v222[3], 1, 0.5, false, true);
	render.text(v97, v220[1] + 6, v220[2] + v224[2] + 2 + v232, v223[3], render.color(255, 255, 255, 255 * dmg_alpha));
	render.text(v97, (v220[1] + v224[1]) - v226, v220[2] + v224[2] + 2 + v232, v225, render.color((colormain:get_color()).r, (colormain:get_color()).g, (colormain:get_color()).b, (colormain:get_color()).a * dmg_alpha));
	if v222[3] then
		v232 = v232 + 11;
	end
	fs_alpha = animate(fs_alpha or 0, v222[4], 1, 0.5, false, true);
	render.text(v97, v220[1] + 6, v220[2] + v224[2] + 2 + v232, v223[4], render.color(255, 255, 255, 255 * fs_alpha));
	render.text(v97, (v220[1] + v224[1]) - v226, v220[2] + v224[2] + 2 + v232, v225, render.color((colormain:get_color()).r, (colormain:get_color()).g, (colormain:get_color()).b, (colormain:get_color()).a * fs_alpha));
	if v222[4] then
		v232 = v232 + 11;
	end
	ho_alpha = animate(ho_alpha or 0, v222[5], 1, 0.5, false, true);
	render.text(v97, v220[1] + 6, v220[2] + v224[2] + 2 + v232, v223[5], render.color(255, 255, 255, 255 * ho_alpha));
	render.text(v97, (v220[1] + v224[1]) - v226, v220[2] + v224[2] + 2 + v232, v225, render.color((colormain:get_color()).r, (colormain:get_color()).g, (colormain:get_color()).b, (colormain:get_color()).a * ho_alpha));
	if v222[5] then
		v232 = v232 + 11;
	end
	fd_alpha = animate(fd_alpha or 0, v222[6], 1, 0.5, false, true);
	render.text(v97, v220[1] + 6, v220[2] + v224[2] + 2 + v232, v223[6], render.color(255, 255, 255, 255 * fd_alpha));
	render.text(v97, (v220[1] + v224[1]) - v226, v220[2] + v224[2] + 2 + v232, v225, render.color((colormain:get_color()).r, (colormain:get_color()).g, (colormain:get_color()).b, (colormain:get_color()).a * fd_alpha));
end;


local first = {
    "u dead sponsored by $hetech° (◣_◢)",
    "missed shot to ?",
    "h$",
    "$hetech° (◣_◢)",
    "ஃᅔ$hetech aa resover >.< ᅕஃ",
    "[$hetech] used unhitabble angles (Pitch: -2.0° Yaw: 360.0°)",
    "id/neksushka",
    "bye bye ",
}


function on_player_death(event)
    if trashtalk:get_bool() then
    local lp = engine.get_local_player();
    local attacker = engine.get_player_for_user_id(event:get_int('attacker'));
    local userid = engine.get_player_for_user_id(event:get_int('userid'));
    local userInfo = engine.get_player_info(userid);
        if attacker == lp and userid ~= lp then
            engine.exec("say " .. first[utils.random_int(1, #first)] .. "")
        end
    else
    end
end




local font=render.create_font("Verdana.ttf", 14,render.font_flag_shadow)


function WM()

    function accumulate_fps()
        return math.ceil(1 / global_vars.frametime)
    end
    
    function get_tick()
        if not engine.is_in_game() then return end
    
        return math.floor( 1.0 / global_vars.interval_per_tick )
    end
    
    
        local x, y = render.get_screen_size()
        local player = entities.get_entity(engine.get_local_player())
        if watermarkcheckbox:get_bool() == false or player == nil then return end
        local text = "shetech° | "..engine.get_player_info(engine.get_local_player()).name.." | Fps : "..accumulate_fps().." | Ping "..math.floor(utils.get_rtt()*500).."ms | Ticks : "..get_tick().." | "..utils.get_time().hour..":"..utils.get_time().min..":"..utils.get_time().sec
        local textx, texty = render.get_text_size(font, text)
        render.rect_filled(x-15,16, x-textx-25, 35, render.color(0, 0, 0, 125))
        render.rect_filled(x-15,14, x-textx-25, 16, colormain:get_color())
        render.text(font, x-textx-20,17, text, render.color(255,255, 255, 255))
end



-- screen size
local screen_size = {render.get_screen_size()}

-- fonts
local verdana = render.create_font("verdana.ttf", 12, render.font_flag_shadow)



function on_slow()

    if not slowdaun:get_bool() then return end

    local pos = {slow_x:get_int(), slow_y:get_int()}
    local size = {100 + 100, 22}
    local player=entities.get_entity(engine.get_local_player())
    if player==nil then return end
    if not player:is_alive() or slowdaun:get_bool()==false then  return end
    local mod=player:get_prop("m_flVelocityModifier")
    mod=mod*100
    if mod==100 and not gui.is_menu_open() then return end



    drag(slow_x, slow_y, size[1], size[2])

    --alpha = animate(alpha or 0, gui.is_menu_open() or override_active or other_binds_active, 1, 0.5, false, true)
    alpha_anim = math.floor(math.abs(math.sin(global_vars.realtime) * 4) * 6)
    alpha_anim1 = math.floor(math.abs(math.sin(global_vars.realtime) * 7) * 255)

    -- glow
    for i = 1, 10 do
        render.rect_filled_rounded(pos[1] - i, pos[2] - i, pos[1] + size[1] + i, pos[2] + size[2] + i, render.color(colormain:get_color().r, colormain:get_color().g, colormain:get_color().b, (alpha_anim - (2 * i)) ), 10)
    end


    render.rect_filled_rounded(pos[1] , pos[2] , pos[1] + size[1], pos[2] + 22,render.color(colormain:get_color().r, colormain:get_color().g, colormain:get_color().b,  255 ), 5)
    render.rect_filled_rounded(pos[1] + 2, pos[2] + 2, pos[1] + size[1]  - 2, pos[2] + 20, render.color(17, 17, 19, 255 ), 4)
    render.rect_filled_rounded(pos[1] + 4, pos[2] + 4, pos[1] + size[1] + mod - 104, pos[2] + 18, render.color(colormain:get_color().r, colormain:get_color().g, colormain:get_color().b,  255 ), 4)
    render.triangle_filled(pos[1] - 30, pos[2]- 15, pos[1] -6 , pos[2]+ 32, pos[1] -54, pos[2]+32, render.color(17, 17, 19, 255 )) 
    render.triangle_filled(pos[1] - 30, pos[2]- 10, pos[1] -10 , pos[2]+ 30, pos[1] -50, pos[2]+30, render.color(colormain:get_color().r, colormain:get_color().g, colormain:get_color().b,  255)) 
    render.text(verdana42, pos[1] - 37 , pos[2]- 10, "!", render.color(17, 17, 19, alpha_anim1 ))
    render.text(calibri13, pos[1] + 20 , pos[2]+ 5, "Slow down: "..tostring(math.floor(mod)).."%" , render.color(255, 255, 255, 255 ))

 

end


local elements = {}


local menu = {}

function menu.initialize()
    elements.yaw = gui.add_combo("Defensive Yaw", "lua>tab b", {"Off", "Flick", "Random"})
end

menu.initialize()

local backup = {}

backup.add = gui.get_config_item("rage>anti-aim>angles>add"):get_int()
backup.yaw = gui.get_config_item("rage>anti-aim>angles>yaw"):get_int()




--gui 
local fontind = render.create_font("verdanab.ttf", 13, render.font_flag_shadow)
local fontbinds = render.create_font("calibrib.ttf", 11, render.font_flag_shadow)
local fontdmg = render.create_font("verdana.ttf", 13, render.font_flag_shadow)
local fontarrows = render.create_font("verdanab.ttf", 15)


local x, y = render.get_screen_size()

local things = {
    id = "other",
    weapon = "knife",
}




local offset_scope = 0


local old_time = 0;
local animation = {

    "$ shetech ",
    "$ h shetec",
    "$ hc shete",
    "$ ech shet",
    "$ tech she",
    "$ etech sh",
    "$ hetech s",
    "$ shetech ",
    
}


local function CT()
    if clantagmain:get_bool() then
        local defaultct = Find("misc>various>clan tag")
        local realtime = math.floor((global_vars.realtime) * 1.725)
        if old_time ~= realtime then
            utils.set_clan_tag(animation[realtime % #animation+1]);
        old_time = realtime;
        defaultct:set_bool(false);
        end
    end
end



autopeek = gui.get_config_item("Misc>Movement>Peek Assist")
doubletap = gui.get_config_item("Rage>Aimbot>Aimbot>Double tap")
freestand = gui.get_config_item("Rage>Anti-Aim>Angles>Freestand")
local powrot = (0)
savedd = doubletap:get_bool()
savedf = doubletap:get_bool()


ffi.cdef [[
    typedef struct{
     void*   handle;
     char    name[260];
     int     load_flags;
     int     server_count;
     int     type;
     int     flags;
     float   mins[3];
     float   maxs[3];
     float   radius;
     char    pad[0x1C];
 } model_t;
 typedef struct {void** this;}aclass;
 typedef void*(__thiscall* get_client_entity_t)(void*, int);
 typedef void(__thiscall* find_or_load_model_fn_t)(void*, const char*);
 typedef const int(__thiscall* get_model_index_fn_t)(void*, const char*);
 typedef const int(__thiscall* add_string_fn_t)(void*, bool, const char*, int, const void*);
 typedef void*(__thiscall* find_table_t)(void*, const char*);
 typedef void(__thiscall* full_update_t)();
 typedef int(__thiscall* get_player_idx_t)();
 typedef void*(__thiscall* get_client_networkable_t)(void*, int);
 typedef void(__thiscall* pre_data_update_t)(void*, int);
 typedef int(__thiscall* get_model_index_t)(void*, const char*);
 typedef const model_t(__thiscall* find_or_load_model_t)(void*, const char*);
 typedef int(__thiscall* add_string_t)(void*, bool, const char*, int, const void*);
 typedef void(__thiscall* set_model_index_t)(void*, int);
 typedef int(__thiscall* precache_model_t)(void*, const char*, bool);
]]
local a = ffi.cast(ffi.typeof("void***"), utils.find_interface("client.dll", "VClientEntityList003")) or
    error("rawientitylist is nil", 2)
local b = ffi.cast("get_client_entity_t", a[0][3]) or error("get_client_entity is nil", 2)
local c = ffi.cast(ffi.typeof("void***"), utils.find_interface("engine.dll", "VModelInfoClient004")) or
    error("model info is nil", 2)
local d = ffi.cast("get_model_index_fn_t", c[0][2]) or error("Getmodelindex is nil", 2)
local e = ffi.cast("find_or_load_model_fn_t", c[0][43]) or error("findmodel is nil", 2)
local f = ffi.cast(ffi.typeof("void***"), utils.find_interface("engine.dll", "VEngineClientStringTable001")) or
    error("clientstring is nil", 2)
local g = ffi.cast("find_table_t", f[0][3]) or error("find table is nil", 2)
function p(pa)
    local a_p = ffi.cast(ffi.typeof("void***"), g(f, "modelprecache"))
    if a_p ~= nil then
        e(c, pa)
        local ac = ffi.cast("add_string_fn_t", a_p[0][8]) or error("ac nil", 2)
        local acs = ac(a_p, false, pa, -1, nil)
        if acs == -1 then print("failed")
            return false
        end
    end
    return true
end

function smi(en, i)
    local rw = b(a, en)
    if rw then
        local gc = ffi.cast(ffi.typeof("void***"), rw)
        local se = ffi.cast("set_model_index_t", gc[0][75])
        if se == nil then
            error("smi is nil")
        end
        se(gc, i)
    end
end

function cm(ent, md)
    if md:len() > 5 then
        if p(md) == false then
            error("invalid model", 2)
        end
        local i = d(c, md)
        if i == -1 then
            return
        end
        smi(ent, i)
    end
end




local path = {
    "models/player/custom_player/z-piks.ru/gta_blood.mdl",
    "models/player/custom_player/z-piks.ru/gta_crip.mdl",
    "models/player/custom_player/toppiofficial/neptunia/adult_neptune.mdl",
	"models/player/custom_player/wcsnik/necoarc/necoarc.mdl",
	"models/player/custom_player/eminem/handicapped/tm_jungle_raider_varianta.mdl",
    "models/player/custom_player/kuristaja/l4d2/rochelle/rochellev2.mdl",
    "models/player/custom_player/tate_skeet/andrewtate.mdl",
    "models/player/custom_player/legacy/toppi/bew/gta/ogloc.mdl",
    "models/player/custom_player/resident/albert_wesker_stars/albert_wesker_stars.mdl",
    "models/player/custom_player/kolka/Scarlet/scarlet.mdl",
    "models/player/custom_player/eminem/css/t_arctic.mdl",
    "models/player/custom_player/eminem/gta_sa/somyst.mdl",
    "models/player/custom_player/nf/gta/tommi.mdl",
    "models/player/custom_player/eminem/gta_sa/vwfypro.mdl",
    "models/player/custom_player/eminem/gta_sa/swmotr5.mdl",
    "models/player/custom_player/eminem/gta_sa/ballas1.mdl",
    "models/player/custom_player/eminem/gta_sa/wuzimu.mdl",
    "models/player/custom_player/eminem/gta_sa/bmybar.mdl",
}

local menu = {}
menu.add = {
    en = gui.add_checkbox("Enabled", "lua>tab a"),
    path = gui.add_combo("Player Model Changer ", "lua>tab a", path),
}


function on_frame_stage_notify(stage, pre_original)
    if stage == csgo.frame_render_start then
        if player == nil then return end
        if player:is_alive() then
            if menu.add.en:get_bool() then
                cm(player:get_index(), path[menu.add.path:get_int() + 1])
            end
        end
    end
end




--aspect ratio
local aspect_ratio_slider = gui.add_slider("Aspect ratio", "lua>tab b", 1, 200, 1)

local r_aspectratio = cvar.r_aspectratio

local default_value = r_aspectratio:get_float()

local function set_aspect_ratio(multiplier)
    local screen_width,screen_height = render.get_screen_size()

    local value = (screen_width * multiplier) / screen_height

    if multiplier == 1 then
        value = 0
    end
    r_aspectratio:set_float(value)
end




function on_create_move()
    UpdateStateandAA()
    StaticFreestand()
    FakeFlik()
    InvertDesync()
    delay_jitter()
end

function on_paint()

	--slowwalk speed
	
	
    if slowwalk_box:get_bool() == true then
        gui.set_visible("lua>tab b>Speed", true)
        local is_down = input.is_key_down( 16 );
        if not ( is_down ) then
            set_speed( 450 )
        else
            local final_val = 250 * slowwalk_slider:get_float( ) / 100
            set_speed( final_val )
        end
    else
        gui.set_visible("lua>tab b>Speed", false)
    end
    local aspect_ratio = aspect_ratio_slider:get_int() * 0.01
    aspect_ratio = 2 - aspect_ratio
    set_aspect_ratio(aspect_ratio)
    skeetind()
    if checkbox:get_bool() then resolver_reference:set_int(0) else resolver_reference:set_int(default) end
    MenuElements()
	if not engine.is_in_game() then return end
	print_logo()
    RB()
    DA()
    WM()
    CT()
    UpdateAll()
	inairh()
	treiway()
	depressedyaw();
	on_keybinds();
	idealtickvisualiser();
	toya();
end

local OldTickCount = -1
    if OldTickCount == global_vars.tickcount then
        return
    else
        OldTickCount = global_vars.tickcount
    end

    local weapons = require("weapons")
