-- config
height = 0
depth = 0
dx = 0
dy = 0
width = 0
branchSpace = 0
directionality = 1 -- 1 = up/true to axis, 2 = right, 0 = left
 
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
fuel()
 
-- main
function main()
  checkInv()
  dig()
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
  deposit()
end


function deposit()
 invdx = dx * -1
 invdy = dy * -1
 move(invdx,invdy)
end
 
-- move maintains directionality so it is only to be used for moving on its own, not in between mining. x,y is relative to turtle
function move(x,y)
 
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
 
function dig()
 
end


