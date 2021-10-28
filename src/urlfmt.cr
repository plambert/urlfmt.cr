require "uri"
require "json"

module Urlfmt
  VERSION = "0.1.0"

  enum Command
    HELP
    FORMAT
  end

  enum Format
    COMPACT
    INDENT
    ANSI_COMPACT
    ANSI_INDENT
    JSON
  end

  class CLI
    property command : Urlfmt::Command = Urlfmt::Command::HELP
    property opts : Array(String)
    property format : Urlfmt::Format = Urlfmt::Format::INDENT

    def initialize(args : Array(String) = ARGV.dup)
      help_opt = false
      while args.size > 0
        opt = args.shift
        case opt
        when "--help"
          help_opt = true
        when "--compact"
          @format = Urlfmt::Format::COMPACT
        when "--indent"
          @format = Urlfmt::Format::INDENT
        when "--ansi", "--ansi-compact"
          @format = Urlfmt::Format::ANSI_COMPACT
        when "--ansi_indent"
          @format = Urlfmt::Format::ANSI_INDENT
        when "--json"
          @format = Urlfmt::Format::JSON
        when "help"
          @command = Urlfmt::Command::HELP
        when "format"
          @command = Urlfmt::Command::FORMAT
        when "--"
          while args.size > 0
            opts << args.shift
          end
        when %r{^-}
          raise "#{opt}: unknown option"
        else
          opts << opt
        end
      end
    end
  end
end

cli = Urlfmt::CLI.new
cli.run
