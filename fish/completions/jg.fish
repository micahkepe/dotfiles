# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_jg_global_optspecs
	string join \n compact count depth n/no-display h/help V/version
end

function __fish_jg_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_jg_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_jg_using_subcommand
	set -l cmd (__fish_jg_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c jg -n "__fish_jg_needs_command" -l compact -d 'Do not pretty-print the JSON output, instead use compact'
complete -c jg -n "__fish_jg_needs_command" -l count -d 'Display count of number of matches'
complete -c jg -n "__fish_jg_needs_command" -l depth -d 'Display depth of the input document'
complete -c jg -n "__fish_jg_needs_command" -s n -l no-display -d 'Do not display matched JSON values'
complete -c jg -n "__fish_jg_needs_command" -s h -l help -d 'Print help'
complete -c jg -n "__fish_jg_needs_command" -s V -l version -d 'Print version'
complete -c jg -n "__fish_jg_needs_command" -a "generate" -d 'Generate additional documentation and/or completions'
complete -c jg -n "__fish_jg_using_subcommand generate; and not __fish_seen_subcommand_from shell man" -s h -l help -d 'Print help'
complete -c jg -n "__fish_jg_using_subcommand generate; and not __fish_seen_subcommand_from shell man" -f -a "shell" -d 'Generate shell completions for the given shell to stdout'
complete -c jg -n "__fish_jg_using_subcommand generate; and not __fish_seen_subcommand_from shell man" -f -a "man" -d 'Generate a man page for jg to output directory if specified, else the current directory'
complete -c jg -n "__fish_jg_using_subcommand generate; and __fish_seen_subcommand_from shell" -s h -l help -d 'Print help'
complete -c jg -n "__fish_jg_using_subcommand generate; and __fish_seen_subcommand_from man" -s o -l output-dir -d 'The output directory to write the man pages' -r -F
complete -c jg -n "__fish_jg_using_subcommand generate; and __fish_seen_subcommand_from man" -s h -l help -d 'Print help'
