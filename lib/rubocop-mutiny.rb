require 'rubocop'
require 'rubocop-rspec'

# Setup Code
require 'rubocop/mutiny'
require 'rubocop/mutiny/inject'

# Custom Rules
require 'rubocop/cop/layout/multiline_method_call_layout'
require 'rubocop/cop/layout/multiline_method_definition_layout'
require 'rubocop/cop/layout/multiline_array_element_layout'
require 'rubocop/cop/layout/multiline_hash_element_layout'
require 'rubocop/cop/lint/parameters_before_block'
require 'rubocop/cop/performance/object_in'
require 'rubocop/cop/style/multiline_method_call_parentheses'

RuboCop::Mutiny::Inject.defaults!
