module RuboCop
  module Cop
    module Performance
      # This cop identifies uses of `Object#in?`, which iterates over each
      # item in a `Range` to see if a specified item is there. In contrast,
      # `Range#cover?` simply compares the target item with the beginning and
      # end points of the `Range`. In a great majority of cases, this is what
      # is wanted.
      #
      # Here is an example of a case where `Range#cover?` may not provide the
      # desired result:
      #
      #     ('a'..'z').cover?('yellow') # => true
      #
      class ObjectIn < Cop
        MSG = 'Use `Range#cover?` instead of `Object#in?`.'.freeze

        def_node_matcher :object_in, <<-PATTERN
          (send _ :in? {irange erange (begin {irange erange})})
        PATTERN

        def on_send(node)
          return unless object_in(node)

          add_offense(node, location: :expression)
        end
      end
    end
  end
end
