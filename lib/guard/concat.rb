require 'guard'
require 'guard/plugin'
require 'guard/watcher'

module Guard
  class Concat < Plugin

    VERSION = '0.0.5'

    def initialize(options = {})
      @output = "#{options[:output]}.#{options[:type]}"
      @opts = options

      super options

      files = options[:files].join("|")
      options[:watchers] = [] unless options[:watchers]
      options[:watchers] << ::Guard::Watcher.new(%r{^#{options[:input_dir]}/(#{files})\.#{options[:type]}$})
    end

    def run_on_changes(paths)
      concat
      ::Guard::UI.info "Concatenated #{@output}"
    end

    # The actual concat method
    #
    # scans the :files passed as options
    # supports * and expands them requiring all files in that path/folder

    def concat
      content = ""
      files = []
      @opts[:files].each do |file|
        files += if single? file
          ["#{@opts[:input_dir]}/#{file}.#{@opts[:type]}"]
        else
          expand file
        end
      end
      files.each do |file|
        content << File.read(file)
        content << "\n"
      end
      File.open(@output, "w"){ |f| f.write content.strip }
    end

    def input_dir
      @opts[:input_dir]
    end

    def type
      @opts[:type]
    end


    private

    # handle the star option (*)

    def single?(file)
      file !~ /\*/
    end

    def expand(file)
      path = "#{input_dir}/#{file}.#{type}"
      Dir.glob path
    end

  end
end
