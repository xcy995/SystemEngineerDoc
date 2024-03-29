# frozen_string_literal: true

# span.rb : Implements text columns
#
# Copyright September 2008, Gregory Brown. All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

module Prawn
  class Document # rubocop: disable Style/Documentation
    # @group Stable API

    # A span is a special purpose bounding box that allows a column of elements
    # to be positioned relative to the margin_box.
    #
    # This method is typically used for flowing a column of text from one page
    # to the next.
    #
    # @example
    #   span(350, position: :center) do
    #     text "Here's some centered text in a 350 point column. " * 100
    #   end
    #
    # @param width [Number] The width of the column in PDF points
    # @param options [Hash{Symbol => any }]
    # @option options :position [:left, :center, :right, Number]
    #   position of the span relative to the page margins.
    # @yield
    # @return [void]
    # @raise [ArgumentError] For unsupported `:position` value.
    def span(width, options = {})
      Prawn.verify_options([:position], options)
      original_position = y

      # FIXME: Any way to move this upstream?
      left_boundary =
        case options.fetch(:position, :left)
        when :left
          margin_box.absolute_left
        when :center
          margin_box.absolute_left + (margin_box.width / 2.0) - (width / 2.0)
        when :right
          margin_box.absolute_right - width
        when Numeric
          margin_box.absolute_left + options[:position]
        else
          raise ArgumentError, 'Invalid option for :position'
        end

      # we need to bust out of whatever nested bounding boxes we're in.
      canvas do
        bounding_box(
          [
            left_boundary,
            margin_box.absolute_top,
          ],
          width: width,
        ) do
          self.y = original_position
          yield
        end
      end
    end
  end
end
