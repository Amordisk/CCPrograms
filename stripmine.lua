-- config
height = 0
depth = 0
dx = 0
dy = 0
width = 0
branchSpace = 0
 
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
  move()
end

-- check and deal with full inventory
function checkInv()
  inventory = nil
  inventory = {}
  for i=1,15 do
    table.insert(inventory,turtle.getItemCount(i))
  end
  for i=1,#inventory do
    if inventory[i] = 0 then
      return
    end
  end
  -- right here need to add something that returns you to start position and puts stuff in chest
  startLoc()
end

-- need to make functions for dig, move and startLoc(move back to start and deposit in chest)


