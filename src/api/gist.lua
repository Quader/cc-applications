local cmd, id, arg = ...

local function printUsage()
	print('Usage:')
	print('gist get <url> <name>')
end


if(not id) then
	return printUsage()
end

if(not http) then
	print('Gist requires http API')
	print('Set B:enableAPI_http to true in ComputerCraft.cfg')
	return
end

local jsonPath = shell.resolve('json')

if(not fs.exists(jsonPath)) then
	print('Missing JSON library, downloading now.')
	os.sleep(0.2)
	write('Connecting to pastebin.com...')

	local response = http.get('http://pastebin.com/raw.php?i=0g211jCp')
	if(response) then
		print('Success!')

		local result = response.readAll()
		response.close()

		local file = fs.open(jsonPath, 'w')
		file.write(result)
		file.close()

		print('Downloaded JSON library to "json"')
	else
		return print('Failed.')
	end
end

if(not json) then
	os.loadAPI(jsonPath)
end

if(cmd == 'get') then
	write('Connecting to gist.github.com...')
	id = string.sub(id, -20)
	local response = http.get("https://api.github.com/gists/" .. id)

	if(response) then
		print('Success!')

		local result = response.readAll()
		response.close()

		local jsonTable = json.decode(result)

		for file, data in pairs(jsonTable.files) do
			print('Found "', file, '"')
			local path = shell.resolve(arg)

			if(fs.exists(path)) then
				print('File "', arg, '" already exists, skipping...')
			else
				local file = fs.open(path, 'w')
				file.write(data.content)
				file.close()

				print('Saved as ' .. arg)
			end
		end
	else
		print('Failed.')
	end
else
	return printUsage()
end