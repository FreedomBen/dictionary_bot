class Definition
  attr_accessor :word, :fl, :hw, :pr, :definitions

  def initialize(entry_json)
    @no_definition = entry_json.nil?
    return unless entry_json

    @word = entry_json["id"]
    @fl = entry_json["fl"]
    @hw = entry_json["hw"]
    @pr = entry_json["pr"]
    @definitions = if entry_json["def"]
                     entry_json["def"]["dt"]
                   else
                     []
                   end

    if @definitions.is_a?(Hash)
      SlackbotFrd::Log.error("definitions are in a hash!: #{@definitions}")
    elsif @definitions.is_a?(Array)
      @definitions.map!{ |d| clean_defstr(d) }
    else
      @definitions = [clean_defstr(@definitions)]
    end
  end

  def has_definitions
    return false if @no_definition
    @definitions.any?{ |d| !d.empty? }
  end

  def to_s
    if @no_definition
      return "No definition found"
    else
      return <<-DEFINITION
Definition for: *#{@word}*
    _#{@fl} | #{@hw} | #{@pr}_
#{@definitions.select{|d| !d.empty?}.map.with_index{|d, i| "    #{i+1} - #{d}"}.join("\n")}
      DEFINITION
    end
  end

  private
  def clean_defstr(defstr)
    defstr.gsub(/^:/, '').gsub(/\<\/?.*\>/i, '')
  end
end
