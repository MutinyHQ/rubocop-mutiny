# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      class MultilineMethodCallParentheses < Cop
        MSG = 'Multiline method calls must use parentheses.'.freeze

        def on_send(node)
          return unless node.arguments? && !node.parenthesized? && !ignored_method?(node)

          if node.arguments.first.loc.first_line != node.arguments.last.loc.last_line
            add_offense(node, location: :selector)
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            corrector.insert_before(args_begin(node), '(')
            corrector.insert_after(args_end(node), ')')
          end
        end

        private
        def args_begin(node)
          loc = node.loc
          selector =
            node.super_type? || node.yield_type? ? loc.keyword : loc.selector
          selector.end.resize(1)
        end

        def args_end(node)
          node.loc.expression.end
        end

        def ignored_method?(node)
          ignored_methods.include?(node.method_name) || node.method_name.to_s.end_with?('=')
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
