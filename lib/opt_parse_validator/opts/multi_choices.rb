# frozen_string_literal: true

module OptParseValidator
  # Implementation of the MultiChoices Option
  class OptMultiChoices < OptArray
    # @param [ Array ] option See OptBase#new
    # @param [ Hash ] attrs
    # @option attrs [ Hash ] :choices
    # @option attrs [ Array<Array> ] :incompatible
    # @options attrs [ String ] :separator See OptArray#new
    def initialize(option, attrs = {})
      raise Error, 'The :choices attribute is mandatory' unless attrs.key?(:choices)
      raise Error, 'The :choices attribute must be a hash' unless attrs[:choices].is_a?(Hash)

      super
    end

    def append_help_messages
      option << 'Available Choices:'

      append_choices_help_messages

      super

      append_incompatible_help_messages
    end

    def append_choices_help_messages
      max_spaces = choices.keys.max_by(&:size).size

      choices.each do |key, opt|
        first_line_prefix  = " #{key} #{' ' * (max_spaces - key.length)}"
        other_lines_prefix = ' ' * first_line_prefix.size

        opt_help_messages(opt).each_with_index do |message, index|
          option << "#{index.zero? ? first_line_prefix : other_lines_prefix} #{message}"
        end
      end
    end

    def help_message_for_default
      msg = +''

      default.each do |key, value|
        msg << if value == true
                 key.to_s.titleize
               else
                 "#{key.to_s.titleize}: #{value}"
               end
        msg << ', '
      end

      msg.chomp(', ')
    end

    # @param [ OptBase ] opt
    #
    # @return [ Array<String> ]
    def opt_help_messages(opt)
      opt.help_messages.empty? ? [opt.to_s.humanize] : opt.help_messages
    end

    def append_incompatible_help_messages
      return if incompatible.empty?

      option << 'Incompatible choices (only one of each group/s can be used):'

      incompatible.each do |a|
        option << " - #{a.join(', ')}"
      end
    end

    # @param [ String ] value
    #
    # @return [ Hash ]
    def validate(value)
      results = {}

      super.each do |item|
        opt = choices[item.to_sym]

        if opt
          opt_value = opt.value_if_empty.nil? || opt.value_if_empty
        else
          opt, opt_value = value_from_pattern(item)
        end

        results[opt.to_sym] = opt.normalize(opt.validate(opt_value))
      end

      verify_compatibility(results)
    end

    # @return [ Array ]
    def value_from_pattern(item)
      choices.each do |key, opt|
        next unless item =~ /\A#{key}(.*)\z/

        return [opt, Regexp.last_match[1]]
      end

      raise Error, "Unknown choice: #{item}"
    end

    # @return [ Array<Array<Symbol>> ]
    def incompatible
      Array(attrs[:incompatible])
    end

    # @param [ Hash ] values
    #
    # @return [ Hash ]
    def verify_compatibility(values)
      incompatible.each do |a|
        last_match = ''

        a.each do |key|
          sym = choices[key].to_sym

          next unless values.key?(sym)

          raise Error, "Incompatible choices detected: #{last_match}, #{key}" unless last_match.empty?

          last_match = key
        end
      end
      values
    end

    # No normalization
    def normalize(value)
      value
    end
  end
end
