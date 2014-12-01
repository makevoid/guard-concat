require 'guard'
require 'guard/plugin'
require 'guard/watcher'

module Guard
  class Concat < Plugin

    VERSION = '0.1.0'

    def initialize(options = {})
      super

      @output = "#{options[:output]}.#{options[:type]}"
      @opts = options

      if options[:files]
        files = options[:files].join("|")
        options[:watchers] = [] unless options[:watchers]
        options[:watchers] << ::Guard::Watcher.new(%r{^#{options[:input_dir]}/(#{files})\.#{options[:type]}$})
      end
    end

    def start
      concat
    end

    def reload
      concat
    end

    def run_all
      concat
    end

    def run_on_changes(paths)
      concat
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

      if File.open(@output, "w"){ |f| f.write content.strip }
        ::Guard::UI.info "Concatenated #{@output}"
      else
        ::Guard::UI.error "Error contanenating #{@output}"
      end
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
