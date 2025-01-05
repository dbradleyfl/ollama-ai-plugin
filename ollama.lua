local config = import("micro/config")
local shell = import("micro/shell")
local micro = import("micro")
local util = import("micro/util")
local os = import("os")

function init()
	config.MakeCommand("ai", invoke, config.NoComplete)
	config.RegisterGlobalOption("ollama", "model", "llama3.2")
	micro.InfoBar():Message("AI Plugin Loaded. Model set to: ", config.GetGlobalOption("ollama.model"))
end

function invoke(bp, args)
	prompt = args[1]

	context = nil

	cursor = bp.Buf.GetActiveCursor(bp.Buf)

	if cursor:HasSelection() then
		context = util.String(cursor:GetSelection())
	else
		context = util.String(bp.Buf:Bytes())
	end

	cmd = string.format("ollama run %s \"Respond to the following prompt with a single code snippet and nothing else. Do not wrap the code snippet in backticks. Make sure to respond with all the code that would replace the context. Prompt: %s Context: %s\"", config.GetGlobalOption("ollama.model"), prompt, context)
	out, err = shell.RunInteractiveShell(cmd, false, true)
	
	if err ~= nil then
		micro.InfoBar():Error(err)
		return
	end

	if cursor:HasSelection() then
		cursor:DeleteSelection()
		bp.Buf:Insert(-bp.Cursor.Loc, out)
	else
		bp:SelectAll()
		bp:Backspace()
		bp.Buf:Insert(-bp.Cursor.Loc, out)
		micro.InfoBar():Message("Replaced whole file's content" )
	end
end