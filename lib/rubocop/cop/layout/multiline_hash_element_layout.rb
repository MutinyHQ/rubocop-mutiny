# frozen_string_literal: true
require 'rubocop/cop/layout/mixin/multiline_layout'

module RuboCop
  module Cop
    module Layout
      class MultilineHashElementLayout < Cop
        include MultilineLayout

        MSG = 'Add a line break between each element of a ' \
              'multi-line hash.'.freeze

        def on_hash(node)
          # node.loc.begin tells us whether the hash opens with a {
          # If it doesn't, Style/FirstMethodArgumentLineBreak will handle it
          check_method_line_break(node, node.children) if node.loc.begin
        end

      end
    end
  end
end
