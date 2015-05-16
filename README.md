# Dictionary Bot

This is a simple bot that listens in slack for a command that looks like this:

    define <word>

or:
  
    definition for <word>

The bot then queries the Merriam Webster API, formats the results in a pretty looking slack response, and sends it to the channel.

That's it!

## Running the Bot

You'll need [a slack token](https://github.com/FreedomBen/slackbot_frd#step-1), and an API token from [Merriam Webster](http://www.dictionaryapi.com/).

Open up `slackbot-frd.conf` and add your tokens appropriately.  Then make sure to `bundle install`:

    bundle install
    
Then run the bot with:

    slackbot-frd start

*Note:*  This bot is built on top of [slackbot_frd](https://github.com/FreedomBen/slackbot_frd)
