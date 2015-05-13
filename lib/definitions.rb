require_relative 'definition'

class Definitions
  def initialize(word, json)
    @word = word
    if !json["entry_list"]
      @skunked = true
    elsif json["entry_list"]["suggestion"]
      @suggestions = json["entry_list"]["suggestion"]
    elsif json["entry_list"]["entry"].is_a?(Array)
      @definitions = json["entry_list"]["entry"].map{ |entry_list| Definition.new(entry_list) }
    else
      @definitions = [Definition.new(json["entry_list"]["entry"])]
    end
  end

  def to_s
    if @skunked
      "Sorry, I did not find any definitions for '#{@word}'"
    elsif @suggestions
      "Sorry, I did not find any definitions for '#{@word}'.\nHere are some suggestions: #{@suggestions.join(", ")}"
    else
      @definitions.select{|d| d.has_definitions}.join("\n")
    end
  end
end
