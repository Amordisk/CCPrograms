-- config
height = 0
depth = 0
dx = 0
dy = 0
width = 1
branchSpace = 0
directionality = 1 -- 1 = up/true to axis, 2 = right, 0 = left, 3 = backwards
 
-- input
print("height")
height = read()
 
print("depth")
depth = read()
 
print("branch spacing")
branchSpace = read()

print("branch length")
branchLength = read()
 
-- fuel
function fuel()
    fuelLevel = turtle.getFuelLevel()
    if fuelLevel < 10 then
        turtle.select(16)
        turtle.refuel(1)
    end
end

-- check and deal with full inventory
function checkInv()
  inventory = nil
  inventory = {}
  for i=1,15 do
    table.insert(inventory,turtle.getItemCount(i))
  end
  for i=1,#inventory do
    if inventory[i] == 0 then
      return
    end
  end
  deposit(1)
end


function deposit(t)
 invdx = dx * -1
 invdy = dy * -1
 movey(invdy)
 movex(invdx)
 turtle.turnLeft()
 turtle.turnLeft()
 for i=1,15 do
  turtle.select(i)
  turtle.drop()
 end
 turtle.turnRight()
 turtle.turnRight()
 if t == 1 then
  invdy = invdy * -1
  invdx = invdx * -1
  movex(invdx)
  movey(invdy)
 end
end
 
-- move maintains directionality so it is only to be used for moving on its own, not in between mining. x,y is relative to turtle
function movey(y)
 if y > 0 then
  turtle.turnRight()
  for i=1,y do
   turtle.forward()
   dy = dy + 1
  end
  turtle.turnLeft()
 elseif y < 0 then
  turtle.turnLeft()
  for i=y,-1 do
   turtle.forward()
   dy = dy - 1
  end
  turtle.turnRight()
 end
end

function movex(x)
 if x > 0 then
  for i=1,x do
   turtle.forward()
   dx = dx + 1
  end
 elseif x < 0 then
  for i=x,-1 do
   turtle.back()
   dx = dx - 1
  end
 end
end
 
function dig(d,h,b)
 --if h == 3 then   stops dig from working for some reason
  for i=1,d do
   turtle.dig()
   movex(1)
   fuel()
   veinMine()
   turtle.digUp()
   turtle.digDown()
   if i % branchSpace == 0 and b == 1 then
    turtle.turnLeft()
    branch()
    turtle.turnRight()
    turtle.turnRight()
    branch()
    turtle.turnLeft()
   end
  end
 --end
end

function senseOre(block)
 return block.name:find('ore')
end

function veinMine()
     for _, direction in ipairs({'up', 'down', 'other'}) do
        if direction == 'up' then
            local success, data = turtle.inspectUp()
            if success and senseOre(data) then
                turtle.digUp()
                turtle.up()
                veinMine()
                turtle.down()
            end
        elseif direction == 'down' then
            local success, data = turtle.inspectDown()
            if success and senseOre(data) then
                turtle.digDown()
                turtle.down()
                veinMine()
                turtle.up()
            end
        else
            for i=1, 4 do
                local success, data = turtle.inspect()
                if success and senseOre(data) then
                    turtle.dig()
                    turtle.forward()
                    for i=1,4 do
                      turtle.turnLeft()
                      veinMine()
                    end
                    turtle.back()
                end
            end
        end
    end
end
 
function branch()
 dig(branchLength,height,0)
 for i=1,branchLength do
  turtle.back()
 end
end

-- main
function main()
 fuel()
 checkInv()
 dig(depth, height, 1)
 deposit()
end

main()
