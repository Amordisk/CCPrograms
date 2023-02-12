-- config
height = 0
depth = 0
dx = 0
dy = 0
width = 0
branchSpace = 0
directionality = 1 -- 1 = up/true to axis, 2 = right, 0 = left, 3 = backwards
 
-- input
print("height")
height = read()
 
print("depth")
depth = read()
 
print("width")
width = read()
 
print("branch spacing")
branchSpace = read()
 
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
 
function dig(d,h)
 --if h == 3 then   stops dig from working for some reason
  for i=1,d do
   --vein sense here
   turtle.dig()
   movex(1)
   --vein sense here
   turtle.digUp()
   turtle.digDown()
  end
 --end
end

function senseOre(block)
 return block.name:find('ore')
end

function veinSense()
 success, data = turtle.inspect()
 if success and senseOre(data) then
  veinMine(front)
 end
 success, data = turtle.inspectUp()
 if success and senseOre(data) then
  veinMine(up)
 end
 success, data = turtle.inspectDown()
 if success and senseOre(data) then
  veinMine(down)
 end
end
 
function veinMine(direction)
 
 
end
 
-- main
function main()
 fuel()
 checkInv()
 dig(depth, height)
 deposit()
end

main()
