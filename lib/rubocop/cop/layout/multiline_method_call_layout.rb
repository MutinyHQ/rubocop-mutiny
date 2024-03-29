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
      class MultilineMethodCallLayout < Cop
        include MultilineLayout

        MSG = 'Add a line break between each argument of a ' \
              'multi-line method argument list.'.freeze

        def on_send(node)
          args = node.arguments
          # If there is a trailing hash arg without explicit braces, like this:
          #
          #    method(1, 'key1' => value1, 'key2' => value2)
          #
          # ...then each key/value pair is treated as a method 'argument'
          # when determining where line breaks should appear.
          if (last_arg = args.last)
            if last_arg.hash_type? && !last_arg.braces?
              args = args.concat(args.pop.children)
            end
          end

          check_method_line_break(node, args)
        end

        def ignored_method?(method_name)
          ignored_methods.include?(method_name) || method_name.to_s.end_with?('=')
        end

        def ignored_methods
          @methods ||= begin
            @config.for_cop('Indentation')['IgnoredMethods'].map(&:to_sym) + cop_config['IgnoredMethods'].map(&:to_sym)
          end
        end
      end
    end
  end
end
