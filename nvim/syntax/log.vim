" Match timestamps (ISO format, common log formats)
syntax match LogDate /\v\d{4}-\d{2}-\d{2}/
syntax match LogTime /\v\d{2}:\d{2}:\d{2}/

" Match log levels (case-insensitive)
syntax keyword LogLevel ERROR WARNING WARN CRITICAL ALERT FATAL contained
syntax keyword LogLevel INFO DEBUG TRACE NOTICE contained

" Match numbers (useful for tracking process IDs, error codes, etc.)
syntax match LogNumber /\v\d+/ contained

" Match IP addresses (common in logs)
syntax match LogIP /\v(\d{1,3}\.){3}\d{1,3}/ contained

" Match file paths (useful in logs showing stack traces)
syntax match LogPath /\v\/[\w\/.-]+/ contained

" Match function names or module names (assuming logs have a format like `[module] message`)
syntax match LogModule /\v\[[A-Za-z0-9_-]+\]/ contained

" Match log messages (everything after timestamp and log level)
syntax region LogMessage start=/\v\d{2}:\d{2}:\d{2}\s+/ end=/$/ contains=LogLevel,LogNumber,LogIP,LogPath,LogModule

" Highlight groups
highlight link LogDate Number
highlight link LogTime Identifier
highlight link LogLevel Keyword
highlight link LogNumber Constant
highlight link LogIP PreProc
highlight link LogPath Underlined
highlight link LogModule Function
highlight link LogMessage Normal
