class XmlDocument
  attr_accessor :scope
  attr_reader :prettify

  def initialize(prettify = false)
    @prettify = prettify
    @scope = 0
  end

  def send(tag_name, *attributes, &blk)
    attr_string = ""

    (attributes.length > 0 ? attributes[0] : [] ).each do |key, value|
      attr_string += " #{key}='#{value}'"
    end

    if !block_given?
      format_line("<#{tag_name}#{attr_string}/>")
    else
      output = format_line("<#{tag_name}#{attr_string}>")
      self.scope += 1
      output += blk.call
      self.scope -= 1
      output += format_line("</#{tag_name}>")
    end
  end

  def indent
    prettify ? "  " * scope : ""
  end

  def newline_if_necessary
    prettify ? "\n" : ""
  end

  def format_line(string)
    indent + string + newline_if_necessary
  end

  def method_missing(method_name, *args, &blk)
    send(method_name, *args, &blk)
  end
end
