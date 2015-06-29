def super_print(string, options = {})
  defaults = {
    :times => "1",
    :upcase => false,
    :reverse => false
  }
  
  options = defaults.merge(options)
  
  options[:upcase] ? string.upcase! : nil
  
  options[:reverse] ? string.reverse! : nil
  
  options[:times].to_i.times { print(string) }
  
  print("\n")
  
end

super_print("Hello")                                    #=> "Hello"
super_print("Hello", :times => 3)                       #=> "Hello" 3x
super_print("Hello", :upcase => true)                   #=> "HELLO"
super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"