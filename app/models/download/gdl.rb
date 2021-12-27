class Download
  class Gdl < Download
    def build_command
      cmd = ["gdl"]
      cmd << "--directory=\"#{ENV["OUTPUT_PATH"]}\""
      cmd << "\"#{url}\""
      cmd.join(" ")
    end
  end
end
