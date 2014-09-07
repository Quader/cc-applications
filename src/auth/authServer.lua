local myid = os.computerID()
local doorList = { 11,13 }
local passwordForDoor = { "notch","minecraft" }

mon=peripheral.wrap("top")
print("Access Terminal")
rednet.open("left")


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

function checkPasswordForLock(id, password, player)
   local i = findIndexForId(id)
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

   senderId, message, distance = rednet.receive()
     
   isValid = checkPasswordForLock(senderId, message, player)

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