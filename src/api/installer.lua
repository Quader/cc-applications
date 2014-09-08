if not fs.exists("gist") then
	shell.run("pastebin get YwirW9fG gist")
end

shell.run("gist get d66ef52d334172d49d7d peripherals")
os.loadAPI("peripherals")