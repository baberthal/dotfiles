syn match jmlRubyExtraAlias "\<alias_method\>" nextgroup=rubyAliasDeclaration
syn match jmlRubyExtraAlias "\<alias_attr_reader\>" nextgroup=rubyAliasDeclaration
syn match jmlRubyExtraAlias "\<alias_attr_writer\>" nextgroup=rubyAliasDeclaration
syn match jmlRubyExtraAlias "\<alias_attr_accessor\>" nextgroup=rubyAliasDeclaration
syn match jmlRubyExtraAlias "\<private_attr_accessor\>" nextgroup=rubyAliasDeclaration
syn match jmlRubyExtraAlias "\<private_attr_writer\>" nextgroup=rubyAliasDeclaration
syn match jmlRubyExtraAlias "\<private_attr_reader\>" nextgroup=rubyAliasDeclaration
syn match jmlRubyExtraAlias "\<protected_attr_accessor\>" nextgroup=rubyAliasDeclaration
syn match jmlRubyExtraAlias "\<protected_attr_writer\>" nextgroup=rubyAliasDeclaration
syn match jmlRubyExtraAlias "\<protected_attr_reader\>" nextgroup=rubyAliasDeclaration

syn match jmlRubyExtraKW "block_given?"

hi def link jmlRubyExtraAlias Keyword
hi def link jmlRubyExtraKW Keyword
