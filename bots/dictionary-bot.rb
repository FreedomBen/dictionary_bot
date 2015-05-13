require 'slackbot_frd'
require 'crack'
require 'curb'

require_relative '../lib/definitions'

class DictionaryBot < SlackbotFrd::Bot
  def add_callbacks(slack_connection)
    slack_connection.on_message(:any, :any) do |user, channel, message|
      if message && user != :bot && user != 'angel'
        # Dictionary
        if message.downcase =~ /^(define|definition\s+for)\s+(\w+)/i
          SlackbotFrd::Log.info("Defining #{$2} for user '#{user}' in channel '#{channel}'")
          xml = Curl.get("http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{$2}?key=#{$slackbotfrd_conf['dictionary_key']}")
          json = Crack::XML.parse(xml.body_str)
          slack_connection.send_message(channel, Definitions.new($2, json).to_s)
          begin
            SlackbotFrd::Log.info("Defined #{$2} for user '#{user}' in channel '#{channel}'")
          rescue IOError => e
          end
        # Thesaurus
        # elsif message.downcase =~ /^(synonyms?|antonyms?)(\s+for)?\s+(\w+)/i
        end
      end
    end
  end
end
