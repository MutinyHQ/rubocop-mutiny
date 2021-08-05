module RuboCop
  module Cop
    module Layout
      module MultilineLayout

        def autocorrect(node)
          ->(corrector) { corrector.insert_before(node.source_range, "\n") }
        end

        private

        def check_method_line_break(node, children)
          return if node.respond_to?(:method_name) && ignored_method?(node.method_name)
          return if children.empty?

          check_children_line_break(node, children)
        end

        def check_children_line_break(node, children, start = node)
          return unless children.first.loc.first_line != children.last.loc.last_line

          if children.size == 1
            return unless node.loc.first_line == children.first.loc.first_line

            add_offense(children.first, location: :expression, message: self.class::MSG)
          else
            children.each.with_index do |child, i|
              next_child = children[i + 1]
              next unless next_child

              if child.loc.last_line == next_child.loc.first_line
                add_offense(next_child, location: :expression, message: self.class::MSG)
              end
            end
          end
        end

        def ignored_method?(method_name)
          method_name.to_s.end_with?('=') || ignored_methods.include?(method_name)
        end

        def ignored_methods
          @methods ||= @config.for_cop('Indentation')['IgnoredMethods'].map(&:to_sym)
        end

      end
    end
  end
end
