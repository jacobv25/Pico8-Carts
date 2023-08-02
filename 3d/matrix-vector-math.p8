-- define cube vertices
local vertices = {
  {-10, -10, -10}, {10, -10, -10}, {10, 10, -10}, {-10, 10, -10},
  {-10, -10, 10}, {10, -10, 10}, {10, 10, 10}, {-10, 10, 10}
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

-- multiply a vector by a matrix
function mat_mult(mat, vec)
  local x = mat[1][1]*vec[1] + mat[1][2]*vec[2] + mat[1][3]*vec[3]
  local y = mat[2][1]*vec[1] + mat[2][2]*vec[2] + mat[2][3]*vec[3]
  local z = mat[3][1]*vec[1] + mat[3][2]*vec[2] + mat[3][3]*vec[3]
  return {x, y, z}
end

-- project 3D to 2D
function project(vec)
  local scale = 64 / (vec[3] + 64)
  local x = vec[1] * scale + 64
  local y = vec[2] * scale + 64
  return x, y
end

function _draw()
  cls()

  -- rotation matrix around Y-axis
  local rotation_mat = {
    {cos(angle), 0, sin(angle)},
    {0, 1, 0},
    {-sin(angle), 0, cos(angle)}
  }

  -- translation matrix
  local translation_mat = {
    {1, 0, 0},
    {0, 1, 0},
    {0, 0, 30}
  }

  -- scaling matrix
  local scaling_mat = {
    {2, 0, 0},
    {0, 2, 0},
    {0, 0, 2}
  }

  for i, edge in pairs(edges) do
    local v1 = mat_mult(rotation_mat, vertices[edge[1]])
    local v2 = mat_mult(rotation_mat, vertices[edge[2]])

    v1 = mat_mult(translation_mat, v1)
    v2 = mat_mult(translation_mat, v2)

    v1 = mat_mult(scaling_mat, v1)
    v2 = mat_mult(scaling_mat, v2)

    local x1, y1 = project(v1)
    local x2, y2 = project(v2)

    line(x1, y1, x2, y2, 7)
  end
end
