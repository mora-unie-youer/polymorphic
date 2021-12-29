local IO = {}

-- This function is there to replace executing of 'cp'
function IO.copy(old_path, new_path, block_sz)
	block_sz = block_sz or 8192
	local old_file = io.open(old_path, 'rb')
	if not old_file then return false end
	local new_file = io.open(new_path, 'wb')
	if not new_file then
		old_file:close()
		return false
	end

	while true do
		local block = old_file:read(block_sz)
		if not block then break end
		new_file:write(block)
	end
	
	local old_file_sz = old_file:seek('end')
	local new_file_sz = new_file:seek('end')
	old_file:close()
	new_file:close()
	return old_file_sz == new_file_sz
end

return IO
