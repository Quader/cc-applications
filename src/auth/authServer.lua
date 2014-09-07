local myid = os.computerID()
local doorList = { 11,13 }
local passwordForDoor = { "notch","minecraft" }
mon=peripheral.wrap("top")
print("Access Terminal")
rednet.open("left")
os.loadAPI("json")

print("Computer id for Access Terminal is "..tostring(myid))

function findIndexForId(id)
   for i,v in ipairs(doorList) do
      if id == v then
         return i
      end
   end
   return 0
end

function setPasswordForLock(id,password)
   local i = findIndexForId(id)
   
   if i == 0 then
      return false
   end
   
   passwordForDoor[i] = password
   print("in setPasswordForLock"..id..password)
   return true
end

function checkPasswordForLock(password, player)
  file = fs.open("playerDB.txt", "r")
  fileStr = file.readAll()
   
  file.close()
  jsonObj = json.decode(fileStr)

  for key, value in pairs(jsonObj) do
    if key == "player" then
      local playerObj = value
      for key,value in pairs(playerObj) do
        if key["name"] == player and key["password"] then
          return 1
        else
          return 0
        end 
      end
    end
  end

  if i == 0 then 
    return -1
  end
  if passwordForDoor[i] == password then
    return 1
  else
    return 0
  end
end

function saveData()
  local myfile = io.open("/doorpw.dat","w")
  print(tostring(myfile))
  print("1")
  for i,pw in ipairs(passwordForDoor) do
     myfile:write(pw)
  end
  print("4")
  myfile:close()
end

function retrieveData()
  local myfile = io.open("/doorpw.dat","w"
)
  for i,pw in ipairs(passwordForDoor) do
     local playerStr = myfile:read(pw)
  end

  print("4")
  myfile:close()
end

local isValid = 0

while true do
  local timeString = textutils.formatTime(os.time(),false)

  local senderId, response = rednet.receive()
  local responseTable = json.decode(response)

  isValid = checkPasswordForLock(responseTable["password"], repsonseTable["player"])

  if isValid == -1 then
    print("server "..senderId.." sent us a request but is not in our list")
  elseif isValid == 1 then
    rednet.send(senderId, "Valid")
    mon.scroll(1)
    mon.setCursorPos(1,4)
    mon.write("Access from "..senderId.." at "..timeString)
  else
    rednet.send(senderId, "Not Valid")
    mon.scroll(1)
    mon.setCursorPos(1,4)
    mon.write("Failure from "..senderId.." at "..timeString)
  end
end