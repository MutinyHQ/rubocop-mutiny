# frozen_string_literal: true

module RuboCop
  module Cop
    module Lint
      class ParametersBeforeBlock < Cop
        MSG = 'Parenthesize the params `%s` to make sure that the block will be'\
              ' associated with the `%s` method call.'.freeze

        def on_send(node)
          return if node.parenthesized? || ignored_method?(node)

          if node.block_literal? && node.arguments?
            add_offense(
              node,
              location: :expression,
              message: format(
                MSG,
                node.arguments.map(&:source).join(', '),
                node.method_name
              )
            )
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            corrector.replace(args_begin(node), '(')
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
          ignored_methods_config.include?(node.method_name.to_s)
        end

        def ignored_methods_config
          @ignored_methods_config ||= cop_config['IgnoredMethods'] || []
        end
      end
    end
  end
end
