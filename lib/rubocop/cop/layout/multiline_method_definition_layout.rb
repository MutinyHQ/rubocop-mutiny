# frozen_string_literal: true
require 'rubocop/cop/layout/mixin/multiline_layout'

module RuboCop
  module Cop
    module Layout
      # This cop checks for a line break before the first argument in a
      # multi-line method call.
      #
      # @example
      #
      #     # bad
      #     method(foo, bar,
      #       baz)
      #
      #     # good
      #     method(
      #       foo, bar,
      #       baz)
      #
      #     # ignored
      #     method foo, bar,
      #       baz
      class MultilineMethodDefinitionLayout < Cop
        include MultilineLayout

        MSG = 'Add a line break between each argument of a ' \
              'multi-line method argument list.'.freeze

        def on_def(node)
          check_method_line_break(node, node.arguments)
        end
      end
    end
  end
end
