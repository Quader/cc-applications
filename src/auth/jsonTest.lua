os.LoadAPI("json")
file = fs.open("playerDB.txt", "r")
fileStr = file.readAll()

file.close()
jsonObj = json.decode(fileStr)

for key, value in pairs(jsonObj) do
  if key == "player" then
    local playerObj = value
    for key,value in pairs(playerObj) do
      for key, value in pairs(value) do
        print(value)
      end
    end
  end
end