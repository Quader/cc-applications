local iPageHandler_Active_page = 1
local tPageHandler_Functions = {}
--
iH - Höhe Monitor



function execfunc( _sName )
	_sName()
end

function system:addPage( _iId, _sName, _tFunctions )
	if type( _iId ) ~=  "number" or type( _sName ) ~= "string" or type( _tFunctions ) ~= "table" then
		--Error ausgeben!
		term.clear()
		term.setCursorPos( 1, 1 )
		print( "Type error! Expected number, string, table got " .. tostring( type( _iId )) .. " , " ..  tostring( type( _sName )) .. " , " .. tostring( type( _tFunctions )))
		return
	else
		tPageHandler_Functions[_iId] = {}
		tPageHandler_Functions[_iId].name = _sName
		tPageHandler_Functions[_iId].functions = _tFunctions
	end
end

function system:removePage( ... )
	if #... ~= 1 then
		--Error ausgeben!
		term.clear()
		term.setCursorPos( 1, 1 )
		print( "Argument Error! Expected 1 got " .. #... )
		return
	else
		if type( ... )  == "string" then
			for i, tPage in ipairs( tPageHandler_Functions ) do
				if tPage.name == ... then
					table.remove( tPageHandler_Functions, i )
					next = next - 1
				end
			end
		elseif type( ... ) == "number" then
			table.remove( tPageHandler_Functions, ... )
		else
			--Error ausgeben!
			term.clear()
			term.setCursorPos( 1, 1 )
			print( "Type Error! Expected string or number got " .. tostring( type( ... )))
			return
		end
	end
end

local function system:pageHandler()

	local iXcounter = 1
	for i, tPage in ipairs( tPageHandler_Functions ) do
		for iI = 1, string.len( tPage.name ) do
			monitor.setCursorPos( iXcounter + iI, iH )
			monitor.write(string.sub( tPage, iI, iI ))
		end
		iXcounter = iXcounter + string.len( tPage.name ) + 1
	end

	for i, tFunc in pairs( tPageHandler_Functions[iPageHandler_Active_page].functions ) do
		execfunc( tFunc )
	end
end