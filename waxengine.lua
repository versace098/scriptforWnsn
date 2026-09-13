[9/13/26 3:30 PM] vęrsace: #made by versace little faggot#
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "waxgui"
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")

local pool = {
    {n="Gather Amount",v=1,w=100,t="flat",q=1},
    {n="Bee Attack",v=1,w=100,t="flat",q=1},
    {n="Bee Health",v=5,w=100,t="flat",q=0.8},
    {n="Convert Amount",v=2,w=95,t="flat",q=1},
    {n="Capacity",v=50,w=90,t="flat",q=0.9},
    {n="Movement Speed",v=1,w=85,t="pct",q=0.7},
    {n="Bee Attack%",v=1,w=80,t="pct",q=1.5},
    {n="Bee Health%",v=1,w=80,t="pct",q=1.2},
    {n="Convert Amount%",v=1,w=75,t="pct",q=1.5},
    {n="Capacity%",v=1,w=70,t="pct",q=1.3},
    {n="Pollen From Bees%",v=1,w=65,t="pct",q=1.4},
    {n="Gifted Bee Bonus",v=1,w=15,t="sp",q=3},
    {n="Critical Hit Chance",v=1,w=20,t="pct",q=2.5},
    {n="Critical Hit Power",v=1,w=20,t="pct",q=2.5},
    {n="Super Crit Chance",v=1,w=8,t="pct",q=4},
    {n="Super Crit Power",v=1,w=8,t="pct",q=4},
    {n="Bee Ability Rate",v=1,w=5,t="pct",q=5},
    {n="Instant Conversion",v=1,w=4,t="pct",q=4.5},
    {n="Pollen From Tools%",v=1,w=3,t="pct",q=3.5},
    {n="White Pollen%",v=1,w=6,t="pct",q=2},
    {n="Red Pollen%",v=1,w=6,t="pct",q=2},
    {n="Blue Pollen%",v=1,w=6,t="pct",q=2},
}

local tw = 0
for i=1,#pool do tw = tw + pool[i].w end

local waxes = {
    Soft = {r=1,qm=1},
    Hard = {r=0.6,qm=1.5},
    Swirled = {r=0.4,qm=2},
    Caustic = {r=0.25,qm=3},
}

local function mk(seed)
    local s = seed % 4294967296
    if s < 0 then s = s + 4294967296 end
    return {s=s, i=s}
end

local function nxt(r)
    r.s = (r.s * 1664525 + 1013904223) % 4294967296
    return r.s / 4294967296
end

local function pick(r)
    local roll = nxt(r) * tw
    local a = 0
    for i=1,#pool do
        a = a + pool[i].w
        if roll <= a then return pool[i] end
    end
    return pool[#pool]
end

local function at(seed, off)
    local r = mk(seed)
    for i=0,off do
        nxt(r)
        local s = pick(r)
        if i == off then return s end
    end
end

local function jump(r)
    return math.floor(nxt(r) * 32) + 1
end

local function sim(seed, wt, cnt)
    local w = waxes[wt] or waxes.Soft
    local r = mk(seed)
    local off = 0
    local out = {}
    for i=1,cnt do
        if nxt(r) <= w.r then
            local d = jump(r)
            off = off + d
            local s = at(seed, off)
            table.insert(out, {w=i, o=off, d=d, s=s})
        end
    end
    return out
end

local function pot(seed, wt, cnt, runs)
    runs = runs or 5000
    local w = waxes[wt] or waxes.Soft
    local tot = 0
    for i=1,runs do
        local r = mk(seed + i)
        local off = 0
        local q = 0
        for j=1,cnt do
            if nxt(r) <= w.r then
                off = off + jump(r)
                local s = at(seed + i, off)
                if s then q = q + s.q * w.qm end
            end
        end
        tot = tot + q
    end
    local avg = tot / runs
    local mx = cnt * 5 * w.qm
    return math.clamp((avg / mx) * 5, 0, 5)
end

local function probs(seed, n)
    n = n or 5000
    local r = mk(seed)
    local c = {}
    for i=1,#pool do c[pool[i].n] = 0 end
    for i=1,n do
        nxt(r)
        local s = pick(r)
        c[s.n] = c[s.n] + 1
    end
    local out = {}
    for k,v in pairs(c) do
        table.insert(out, {n=k, c=v, p=(v/n)*100})
    end
    table.sort(out, function(a,b) return a.c > b.c end)
    return out
end

local main = Instance.new("Frame")
main.Size = UDim2.new(0,500,0,600)
main.Position = UDim2.new(0.5,-250,0.5,-300)
main.BackgroundColor3 = Color3.fromRGB(25,25,30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local ttl = Instance.new("TextLabel")
ttl.Size = UDim2.new(1,0,0,30)
ttl.BackgroundColor3 = Color3.fromRGB(40,40,50)
ttl.TextColor3 = Color3.fromRGB(255,255,255)
ttl.Text = "wax engine"
ttl.Font = Enum.Font.GothamBold
ttl.TextSize = 16
ttl.Parent = main

local sl = Instance.new("TextLabel")
sl.Size = UDim2.new(0,60,0,25)
sl.Position = UDim2.new(0,10,0,40)
sl.BackgroundTransparency = 1
sl.
[9/13/26 3:30 PM] vęrsace: TextColor3 = Color3.fromRGB(200,200,200)
sl.Text = "seed:"
sl.Font = Enum.Font.Gotham
sl.TextSize = 13
sl.TextXAlignment = Enum.TextXAlignment.Left
sl.Parent = main

local sb = Instance.new("TextBox")
sb.Size = UDim2.new(0,150,0,25)
sb.Position = UDim2.new(0,70,0,40)
sb.BackgroundColor3 = Color3.fromRGB(50,50,60)
sb.TextColor3 = Color3.fromRGB(255,255,255)
sb.Text = "123456789"
sb.Font = Enum.Font.Gotham
sb.TextSize = 13
sb.Parent = main

local wl = Instance.new("TextLabel")
wl.Size = UDim2.new(0,70,0,25)
wl.Position = UDim2.new(0,240,0,40)
wl.BackgroundTransparency = 1
wl.TextColor3 = Color3.fromRGB(200,200,200)
wl.Text = "wax:"
wl.Font = Enum.Font.Gotham
wl.TextSize = 13
wl.TextXAlignment = Enum.TextXAlignment.Left
wl.Parent = main

local wd = Instance.new("TextButton")
wd.Size = UDim2.new(0,120,0,25)
wd.Position = UDim2.new(0,300,0,40)
wd.BackgroundColor3 = Color3.fromRGB(50,50,60)
wd.TextColor3 = Color3.fromRGB(255,255,255)
wd.Text = "Soft"
wd.Font = Enum.Font.Gotham
wd.TextSize = 13
wd.Parent = main

local wo = {"Soft","Hard","Swirled","Caustic"}
local wi = 1
wd.MouseButton1Click:Connect(function()
    wi = wi + 1
    if wi > #wo then wi = 1 end
    wd.Text = wo[wi]
end)

local dl = Instance.new("TextLabel")
dl.Size = UDim2.new(0,60,0,25)
dl.Position = UDim2.new(0,10,0,75)
dl.BackgroundTransparency = 1
dl.TextColor3 = Color3.fromRGB(200,200,200)
dl.Text = "depth:"
dl.Font = Enum.Font.Gotham
dl.TextSize = 13
dl.TextXAlignment = Enum.TextXAlignment.Left
dl.Parent = main

local db = Instance.new("TextBox")
db.Size = UDim2.new(0,100,0,25)
db.Position = UDim2.new(0,70,0,75)
db.BackgroundColor3 = Color3.fromRGB(50,50,60)
db.TextColor3 = Color3.fromRGB(255,255,255)
db.Text = "500"
db.Font = Enum.Font.Gotham
db.TextSize = 13
db.Parent = main

local stl = Instance.new("TextLabel")
stl.Size = UDim2.new(0,60,0,25)
stl.Position = UDim2.new(0,240,0,75)
stl.BackgroundTransparency = 1
stl.TextColor3 = Color3.fromRGB(200,200,200)
stl.Text = "steps:"
stl.Font = Enum.Font.Gotham
stl.TextSize = 13
stl.TextXAlignment = Enum.TextXAlignment.Left
stl.Parent = main

local stb = Instance.new("TextBox")
stb.Size = UDim2.new(0,60,0,25)
stb.Position = UDim2.new(0,300,0,75)
stb.BackgroundColor3 = Color3.fromRGB(50,50,60)
stb.TextColor3 = Color3.fromRGB(255,255,255)
stb.Text = "3"
stb.Font = Enum.Font.Gotham
stb.TextSize = 13
stb.Parent = main

local rf = Instance.new("TextButton")
rf.Size = UDim2.new(0,100,0,22)
rf.Position = UDim2.new(0,10,0,110)
rf.BackgroundColor3 = Color3.fromRGB(50,50,60)
rf.TextColor3 = Color3.fromRGB(255,255,255)
rf.Text = "rare only"
rf.Font = Enum.Font.Gotham
rf.TextSize = 12
rf.Parent = main
local ro = false
rf.MouseButton1Click:Connect(function()
    ro = not ro
    rf.BackgroundColor3 = ro and Color3.fromRGB(80,120,80) or Color3.fromRGB(50,50,60)
end)

local pf = Instance.new("TextButton")
pf.Size = UDim2.new(0,100,0,22)
pf.Position = UDim2.new(0,120,0,110)
pf.BackgroundColor3 = Color3.fromRGB(50,50,60)
pf.TextColor3 = Color3.fromRGB(255,255,255)
pf.Text = "pct only"
pf.Font = Enum.Font.Gotham
pf.TextSize = 12
pf.Parent = main
local po = false
pf.MouseButton1Click:Connect(function()
    po = not po
    pf.BackgroundColor3 = po and Color3.fromRGB(80,120,80) or Color3.fromRGB(50,50,60)
end)

local run = Instance.new("TextButton")
run.Size = UDim2.new(0,100,0,28)
run.Position = UDim2.new(0,10,0,145)
run.BackgroundColor3 = Color3.fromRGB(60,100,60)
run.TextColor3 = Color3.fromRGB(255,255,255)
run.Text = "sim"
run.Font = Enum.Font.GothamBold
run.TextSize = 13
run.Parent = main

local calc = Instance.new("TextButton")
calc.Size = UDim2.new(0,120,0,28)
calc.Position = UDim2.new(0,120,0,145)
calc.BackgroundColor3 = Color3.fromRGB(60,60,100)
calc.TextColor3 = Color3.fromRGB(255,255,255)
calc.Text = "potential"
calc.Font = Enum.Font.GothamBold
calc.TextSize = 13
calc.Parent = main

local prb = Instance.new("TextButton")
prb.Size = UDim2.new(0,100,0,28)
prb.Position = UDim2.new(0,250,0,145)
prb.BackgroundColor3 = Color3.fromRGB(100,60,60)
prb.TextColor3 = Color3.fromRGB(255,255,255)
prb.Text = "probs"
prb.Font = Enum.Font.
[9/13/26 3:30 PM] vęrsace: GothamBold
prb.TextSize = 13
prb.Parent = main

local exp = Instance.new("TextButton")
exp.Size = UDim2.new(0,100,0,28)
exp.Position = UDim2.new(0,360,0,145)
exp.BackgroundColor3 = Color3.fromRGB(100,100,60)
exp.TextColor3 = Color3.fromRGB(255,255,255)
exp.Text = "explore"
exp.Font = Enum.Font.GothamBold
exp.TextSize = 13
exp.Parent = main

local trp = Instance.new("TextButton")
trp.Size = UDim2.new(0,100,0,28)
trp.Position = UDim2.new(0,10,0,180)
trp.BackgroundColor3 = Color3.fromRGB(120,80,60)
trp.TextColor3 = Color3.fromRGB(255,255,255)
trp.Text = "turpentine"
trp.Font = Enum.Font.GothamBold
trp.TextSize = 13
trp.Parent = main

local sf = Instance.new("ScrollingFrame")
sf.Size = UDim2.new(1,-20,0,370)
sf.Position = UDim2.new(0,10,0,215)
sf.BackgroundColor3 = Color3.fromRGB(15,15,20)
sf.BorderSizePixel = 0
sf.ScrollBarThickness = 6
sf.CanvasSize = UDim2.new(0,0,0,0)
sf.Parent = main

local ll = Instance.new("UIListLayout")
ll.Padding = UDim.new(0,2)
ll.SortOrder = Enum.SortOrder.LayoutOrder
ll.Parent = sf

local function clr()
    for _,c in ipairs(sf:GetChildren()) do
        if c:IsA("TextLabel") then c:Destroy() end
    end
    sf.CanvasSize = UDim2.new(0,0,0,0)
end

local function add(txt, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-6,0,20)
    l.BackgroundTransparency = 1
    l.TextColor3 = col or Color3.fromRGB(200,200,200)
    l.Text = txt
    l.Font = Enum.Font.Code
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = sf
    sf.CanvasSize = UDim2.new(0,0,0,ll.AbsoluteContentSize.Y)
end

run.MouseButton1Click:Connect(function()
    clr()
    local seed = tonumber(sb.Text) or 123456789
    local wt = wd.Text
    local cnt = math.clamp(tonumber(stb.Text) or 3, 1, 5)
    local res = sim(seed, wt, cnt)
    add("=== sim seed="..seed.." wax="..wt.." steps="..cnt.." ===", Color3.fromRGB(255,220,100))
    if #res == 0 then
        add("no successful waxes")
    else
        for _,g in ipairs(res) do
            local sname = g.s and g.s.n or "nil"
            add(string.format("wax %d: +%d -> off %d -> %s", g.w, g.d, g.o, sname))
        end
    end
end)

calc.MouseButton1Click:Connect(function()
    clr()
    local seed = tonumber(sb.Text) or 123456789
    local wt = wd.Text
    local cnt = math.clamp(tonumber(stb.Text) or 3, 1, 5)
    add("=== potential (5000 runs) ===", Color3.fromRGB(255,220,100))
    local sc = pot(seed, wt, cnt, 5000)
    add(string.format("score: %.2f / 5.00", sc), Color3.fromRGB(100,255,100))
end)

prb.MouseButton1Click:Connect(function()
    clr()
    local seed = tonumber(sb.Text) or 123456789
    add("=== probs (5000 samples) ===", Color3.fromRGB(255,220,100))
    local p = probs(seed, 5000)
    for _,e in ipairs(p) do
        if e.c > 0 then
            add(string.format("%-28s %5d  %.2f%%", e.n, e.c, e.p))
        end
    end
end)

exp.MouseButton1Click:Connect(function()
    clr()
    local seed = tonumber(sb.Text) or 123456789
    local d = tonumber(db.Text) or 500
    add("=== explore depth="..d.." ===", Color3.fromRGB(255,220,100))
    local r = mk(seed)
    for i=0,d do
        nxt(r)
        local s = pick(r)
        local show = true
        if ro and s.q < 2 then show = false end
        if po and s.t ~= "pct" then show = false end
        if show then
            local col = s.q >= 4 and Color3.fromRGB(255,100,100) or s.q >= 2.5 and Color3.fromRGB(255,200,100) or Color3.fromRGB(200,200,200)
            add(string.format("off %5d  %-28s %s %d", i, s.n, s.t, s.v), col)
        end
    end
end)

trp.MouseButton1Click:Connect(function()
    clr()
    local seed = tonumber(sb.Text) or 123456789
    add("=== turpentine reset ===", Color3.fromRGB(255,220,100))
    add("base offset = wax count")
    add("rng reset to seed "..seed)
    add("stats cleared")
end)
