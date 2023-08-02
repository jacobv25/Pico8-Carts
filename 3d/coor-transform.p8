pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- define cube vertices
local vertices = {
  {x=-10, y=-10, z=-10},
  {x=10, y=-10, z=-10},
  {x=10, y=10, z=-10},
  {x=-10, y=10, z=-10},
  {x=-10, y=-10, z=10},
  {x=10, y=-10, z=10},
  {x=10, y=10, z=10},
  {x=-10, y=10, z=10}
}

-- cube edges
local edges = {
  {1, 2}, {2, 3}, {3, 4}, {4, 1},
  {5, 6}, {6, 7}, {7, 8}, {8, 5},
  {1, 5}, {2, 6}, {3, 7}, {4, 8}
}

local angle = 0

function _update()
  angle += 0.01
end

-- transforms 3d coordinates into 2d
function project(vertex)
  local scale = 64 / (vertex.z + 64)
  local x = vertex.x * scale + 64
  local y = vertex.y * scale + 64
  return x, y
end

-- rotate, translate, and scale
function transform(vertex)
  local x = vertex.x * cos(angle) - vertex.z * sin(angle)
  local z = vertex.x * sin(angle) + vertex.z * cos(angle)
  local y = vertex.y

  -- translation
  x += 0
  y += 0
  z += 30

  -- scaling
  x *= 2
  y *= 2
  z *= 2

  return {x=x, y=y, z=z}
end

function _draw()
  cls()
  for i, edge in pairs(edges) do
    local v1 = transform(vertices[edge[1]])
    local v2 = transform(vertices[edge[2]])

    local x1, y1 = project(v1)
    local x2, y2 = project(v2)

    line(x1, y1, x2, y2, 7)
  end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
