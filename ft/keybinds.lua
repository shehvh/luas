--github.com/shehvh
local HUD = {}
function HUD:new(x, y, w, h)
    self = setmetatable({}, {__index = HUD})
    self.x, self.y, self.w, self.h = x or 200, y or 400, w or 160, h or 20
    self.drag_x, self.drag_y = 0, 0
    self.is_dragging = false
    return self
end
function HUD:drag()
    local m = {} m.x, m.y = input.get_cursor_pos()
        local is_hovered = (m.x > (self.x) and m.x < (self.x + self.w) and m.y > (self.y) and m.y < (self.y + self.h))
    if is_hovered then
        if input.is_key_down(1) and not self.is_dragging then
            self.is_dragging = true
         
            self.drag_x = self.x - m.x
            self.drag_y = self.y - m.y
        end
    end
    if not input.is_key_down(1) then
        self.is_dragging = false
    end
    if self.is_dragging and gui.is_menu_open() then
        self.x = (self.drag_x + m.x)
        self.y = (self.drag_y + m.y)
    end
end
function HUD:paint() end
function HUD:draw()self:paint()self:drag()end
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--мда треш ксюша швш
local binds_data = {
    {
        name = "Rage aimbot",
        path = "rage>aimbot>aimbot>aimbot" --aimbot
    },--[[aimbot]] --[=[aimbot]=]
    {
        name = "HideShot",
        path = "rage>aimbot>aimbot>hide shot"
    },
    {
        name = "Pew-Pew",
        path = "rage>aimbot>aimbot>double tap"
    },
    {
        name = "Force safepoint",
        path = "rage>aimbot>aimbot>force extra safety"
    },
    {
        name = "Headshot only",
        path = "rage>aimbot>aimbot>headshot only"
    },
    {
        name = "MinDmg",
        path = "rage>aimbot>autosniper>auto>override"
    },
    {
        name = "Autostop",
        path = "rage>aimbot>autosniper>extra>autostop"
    },
    {
        name = "Anti-aim enable",
        path = "rage>anti-aim>angles>anti-aim"
    },
    {
        name = "[shetech] IdealTick p100",
        path = "rage>anti-aim>angles>freestand"
    },
    {
        name = "-0 Yaw",
        path = "rage>anti-aim>angles>back"
    },
    {
        name = "-89 Yaw",
        path = "rage>anti-aim>angles>Left"
    },
    {
        name = "89 Yaw",
        path = "rage>anti-aim>angles>right"
    },
    {
        name = "Ensure lean",
        path = "rage>anti-aim>desync>ensure lean"
    },
    {
        name = "Legit aimbot",
        path = "legit>pistol>aimhelper>magnet"
    },
    {
        name = "Triggerbot",
        path = "legit>pistol>assists>triggerbot"
    },
    {
        name = "Esp enable",
        path = "visuals>esp>player>esp"
    },
    {
        name = "Chams enable",
        path = "visuals>models>general>chams"
    },
    {
        name = "Thirdperson",
        path = "visuals>misc>local>thirdperson"
    },
    {
        name = "+/- Fastest AutoPeak",
        path = "misc>movement>peek assist"
    },
    {
        name = "Secret Slow Walk",
        path = "misc>movement>slide"
    },
    {
        name = "Fake Duck",
        path = "misc>movement>fake duck"
    },
}
for _,v in pairs(binds_data)do
    v.item = gui.get_config_item(v.path)
end
local screen_size = {} screen_size.x,screen_size.y = render.get_screen_size()
local path = "lua>tab b"
local keybindlist_m =  gui.add_checkbox("Keybindlist", path)
local color = gui.add_colorpicker(path..">Keybindlist", true)
local type_keybinds = gui.add_combo("Keybindlist type", path,{"Static","Fade","Chroma"})
local second_color = gui.add_colorpicker(path..">Keybindlist type", true)
local db = database.load("Xissayala_keybinds_data.db")
if db == nil then
    database.save("Xissayala_keybinds_data.db",{x = 0,y = 0})
    db = {x = 0,y = 0}
end
function on_shutdown()
    database.save("Xissayala_keybinds_data.db",db)
end
local speed = 18
local m_alpha = 0
local m_active = {}
local font = render.create_font("SegUIVar.ttf", 14,render.font_flag_shadow)
local keybindlist = HUD:new(
    db.x,
    db.y,
    160
)
--[=[]=]
local valtotype = function (b)
   return({"hold", "toggle"})[b] or nil
end
local lerp = function(a,b,c) return a + (b - a) *c*global_vars.frametime end
function keybindlist:paint()
    local isanybindactive = false
    local maximum_offset = 110
    local master_switch = keybindlist_m:get_bool()
    local x, y = self.x,self.y
    local c = color:get_color()
    local f = second_color:get_color()
    local itr = 1
    for c_key, c_data in pairs(binds_data) do
        local k = c_data.name
        local _, tybeB = gui.get_keybind(c_data.path)
        if c_data.item:get_bool() and valtotype(tybeB) then
            isanybindactive = true
            if m_active[k] == nil then
                m_active[k] = {value = "",alpha = 0,offset = 0,name = "",y_add = -8 + itr*16+5}
            end
            m_active[k].itr = itr
            m_active[k].name = k
            m_active[k].value = valtotype(tybeB)
            m_active[k].offsetr = ({render.get_text_size(font, "["..valtotype(tybeB).."]")})[1]
            m_active[k].offset = ({render.get_text_size(font, k)})[1]+m_active[k].offsetr+10
            m_active[k].alpha = lerp(m_active[k].alpha,1,speed)
            m_active[k].y_add = lerp(m_active[k].y_add, itr*16+5,speed)
            itr = itr + 1
        else
            if m_active[k] then
                if m_active[k].alpha then
                    m_active[k].alpha = lerp(m_active[k].alpha,0,speed)
                    --itr = itr + 1
                end
                if m_active[k].y_add then
                    m_active[k].y_add = lerp(m_active[k].y_add,-8  + m_active[k].itr*16+5,speed)
                end
                if m_active[k].alpha < 0.1 then
                    m_active[k] = nil
                end
            end
        end
        if m_active[k] and (m_active[k].offset) > maximum_offset then
            maximum_offset = m_active[k].offset
        end
    end
    self.w = math.floor(.5+lerp(self.w, maximum_offset, speed))
    if m_alpha > 0.01 then
        for _, c_data in pairs(m_active) do
            render.text(font, x, c_data.y_add + y, c_data.name, render.color(255, 255, 255, c_data.alpha*m_alpha*255))
            render.text(font, x+self.w-c_data.offsetr, y + c_data.y_add, "[".. c_data.value.."]", render.color(255, 255, 255, c_data.alpha*m_alpha*255))
            --itr = itr + 1
        end
        render.rect_filled(x, y, x+self.w, y+self.h, render.color(17,17,17,m_alpha*100))
        if type_keybinds:get_int() == 0 then
            render.rect_filled(x, y, x+self.w, y+2, render.color(c.r,c.g,c.b,m_alpha*c.a))
        elseif type_keybinds:get_int() == 1 then
            render.rect_filled_multicolor(x, y, x+self.w/2, y+2,
            render.color(f.r, f.g, f.b, m_alpha*f.a),
            render.color(c.r, c.g, c.b, m_alpha*c.a),
            render.color(c.r, c.g, c.b, m_alpha*c.a),
            render.color(f.r, f.g, f.b, m_alpha*f.a))
            render.rect_filled_multicolor(x+self.w/2, y, x+self.w, y+2,
            render.color(c.r, c.g, c.b, m_alpha*c.a),
            render.color(f.r, f.g, f.b, m_alpha*f.a),
            render.color(f.r, f.g, f.b, m_alpha*f.a),
            render.color(c.r, c.g, c.b, m_alpha*c.a))
        else
            render.rect_filled_multicolor(x, y, x+self.w/2, y+2,
            render.color(0, 255, 255, m_alpha*255),
            render.color(255, 0, 255, m_alpha*255),
            render.color(255, 0, 255, m_alpha*255),
            render.color(0, 255, 255, m_alpha*255))
            render.rect_filled_multicolor(x+self.w/2, y, x+self.w, y+2,
            render.color(255, 0, 255, m_alpha*255),
            render.color(255, 255, 0, m_alpha*255),
            render.color(255, 255, 0, m_alpha*255),
            render.color(255, 0, 255, m_alpha*255))
        end
        render.text(font, x+self.w/2, y+self.h/2, "KeyBinds", render.color(255, 255, 255, m_alpha*255), render.align_center, render.align_center)
    end
    db.x = self.x
    db.y = self.y
    m_alpha = lerp(m_alpha,((gui.is_menu_open() or isanybindactive) and master_switch) and 1 or 0 ,speed)
end
function on_paint()
    keybindlist:draw()
end
--]=]
