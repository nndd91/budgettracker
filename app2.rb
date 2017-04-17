$debug = true

class Entry
#Class Methods
  @@database = Array.new #Array to hold all entries
  attr_accessor :record, :date, :shortdes, :longdes, :amount, :currency, :con_amount

  def initialize
    @record = @@database.length.to_s
    @date = "01/01/2017"
    @shortdes = "shortdes"
    @longdes = "longdes"
    @amount = "$0.00"
    @currency = "SGD"
    @con_amount = "$0.00"
    #@@database << self
  end

  def self.all_instances #Return all entry
    @@database

    if $debug == true
      puts "Debug: #{@@database} \n"
    end

  end


  def self.userinput(type) #Menu for allowing user input
    clearscreen
    type = type.to_i
    array = Array.new
    c = @@database.length.to_i
    b = @@database

    puts "c is: " + c.to_s
    b.push(Entry.new)

    if type == 1 #Command Line

      puts "Enter data in the following format"
      puts "<date>, <shortdes>, <longdes>, <amount>, <currency>, <con_amount>"

      input = gets.chomp
      p input
      array = input.split(',')
      p array



    elsif type == 2 #Guide
      guide = [["Date", b[c].date], ["Short Description", b[c].shortdes], ["Long Description", b[c].longdes], ["Amount",b[c].amount], ["Currency", b[c].currency]]
      p guide[0][1]
      for i in 0..4
        puts "Please enter #{guide[i][0]} (Leave blank for default[#{(guide[i][1])}]): "
        input = gets.chomp.to_s
        array.push(input)
      end
      p array

    end



    if $debug ==true
      puts "New entry created with content: "
      p b[c]
    end
    b[c].date = array[0]
    b[c].shortdes = array[1]
    b[c].longdes = array[2]
    b[c].amount = array[3]

    puts "Updated entry with content: "
    p b[c]

  end

  def self.print_all_entry
    clearscreen
    print "All Entries are as follows: \n\n"
    for i in 0..(@@database.length-1)
      print @@database[i].record + " | " + @@database[i].date + " | " + @@database[i].shortdes + " | " + @@database[i].longdes + " | " + @@database[i].amount + " | " + @@database[i].currency + " | " + @@database[i].con_amount + " | "
      print "\n"
    end
    print "\n"
  end


#Instance Method

  def print_entry
    print @date
    print " | "
    print @shortdes
    print " | "
    print @longdes
    print " | "
    print @amount
    print " | "
    print @currency
    print " | "
    print @con_amount
    print " | "
  end
end # End of Class

#Utilities Methods

def clearscreen
  system('cls')
end

def menu

clearscreen

  print <<EOF
  Hello there! Welcome to this budget tracker!
  What would you like to do today?

    1. New Entry
    2. New Entry(Guided)
    3. View all Entry
EOF

  input = gets.chomp.to_i

  case input
  when 1 #New Entry
    Entry.userinput(1)

    puts "Input 1 to go back"
    input = gets.chomp.to_i
    if input == 1
      menu
    else
      exit
    end
  when 2 #Guide Entry
    Entry.userinput(2)

    puts "Input 1 to go back"
    input = gets.chomp.to_i
    if input == 1
      menu
    else
      exit
    end
  when 3 # View all Entry
    Entry.print_all_entry
    puts "Input 1 to go back"
    input = gets.chomp.to_i
    if input == 1
      menu
    else
      exit
    end

  end

end

def main #Main Program Start


  entry00000001 = Entry.new
  #entry00000001.inputentry
  entry00000002 = Entry.new
  entry00000003 = Entry.new
  entry00000004 = Entry.new
  #entry00000002.inputentry



  p entry00000001.date = "03/03/1991"

  entry00000001.print_entry
  print "\n"
  entry00000002.print_entry
  print "\n"

  Entry.all_instances
  Entry.print_all_entry

  menu
  Entry.userinput






end

main

#Entry.print_all_entry

