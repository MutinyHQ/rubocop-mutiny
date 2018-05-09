# frozen_string_literal: true
require 'rubocop/cop/layout/mixin/multiline_layout'

module RuboCop
  module Cop
    module Layout
      class MultilineArrayElementLayout < Cop
        include MultilineLayout

        MSG = 'Add a line break between each element of a ' \
              'multi-line array.'.freeze

        def on_array(node)
          return if !node.loc.begin && !assignment_on_same_line?(node)

          check_method_line_break(node, node.children)
        end

        private

        def assignment_on_same_line?(node)
          source = node.source_range.source_line[0...node.loc.column]
          source =~ /\s*\=\s*$/
        end
      end
    end
  end
end
