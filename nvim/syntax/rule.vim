" syn match ruleComment /#\?.*$/
syn match ruleComment /#.*$/
syn match ruleComment /\(@RULE\)\@<=\_.\{-}\(@\w\+\)\@>/
syn match ruleKeyword /@\w\+/
syn match ruleVariableDefinition /^\W*var\W*\w\+=\W*{\d\+\(\W*,\W*\d\+\)*\W*}\W*$/ contains=ruleVarKeyword,ruleVariableIdentifier
syn match ruleVariableIdentifier contained /\(var\W\+\)\@<=\w\+/
syn keyword ruleVarKeyword contained var
" syn keyword ruleKeyword var
syn keyword ruleDefaults n_states neighborhood symmetries

let b:current_syntax = "rule"

hi def link ruleKeyword Keyword
hi def link ruleVarKeyword Keyword
hi def link ruleVariableDefinition Normal
hi def link ruleVariableIdentifier Identifier
hi def link ruleComment Comment
hi def link ruleDefaults Special
