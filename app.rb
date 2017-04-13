$debugging = true

class Entry
#Class Methods
  @@database = Array.new #Array to hold all entries
  attr_accessor :record, :date, :shortdes, :longdes, :amount, :currency, :con_amount, :status

  def initialize
    @record = (@@database.length+1).to_s
    @date = "01/01/2017"
    @shortdes = "Entry ##{@record}"
    @longdes = ""
    @amount = "$0.00"
    @currency = "SGD"
    @con_amount = "$0.00"
    @status = "Active"
    #@@database << self
  end

  def self.all_instances #Return all entry
    @@database

    debug(@@database)


  end


  def self.userinput(type) #Menu for allowing user input
    clearscreen
    type = type.to_i
    array = Array.new
    c = @@database.length.to_i
    b = @@database

    debug(c, "c is: ")
    b.push(Entry.new)

    if type == 1 #Command Line

      puts "Enter data in the following format"
      puts "<date>, <shortdes>, <longdes>, <amount>, <currency>, <con_amount>"

      input = gets.chomp


      debug(input)
      array = input.split(',')
      debug(array)

    elsif type == 2 #Guide
      guide = [["Date", b[c].date], ["Short Description", b[c].shortdes], ["Long Description", b[c].longdes], ["Amount",b[c].amount], ["Currency", b[c].currency]]

      for i in 0..4
        puts "Please enter #{guide[i][0]} (Leave blank for default [ #{(guide[i][1])} ] ): "
        input = gets.chomp.to_s
        array.push(input)
      end
      debug(array)

    end
    puts "You have entered: "
    for i in 0..4
      print array[i].to_s + "  |  "
    end
    print "\n" + "Is this correct? (y/n)"
    input = gets.chomp.upcase.to_s

    if input == "Y"
      debug(b[c], "New entry created with content: ")
      if array[0].to_s != ""
        b[c].date = array[0]
      end
      if array[1].to_s != ""
        b[c].shortdes = array[1]
      end
      if array[2].to_s != ""
        b[c].longdes = array[2]
      end
      if array[3].to_s != ""
        b[c].amount = array[3].to_f
      end
      if array[4].to_s != ""
        b[c].currency = array[4]
      end
      if array[4].to_s == "SEK"
        b[c].con_amount = array[3].to_f *(1.0/6)
      else
        b[c].con_amount = array[3].to_f
      end

      puts "Updated entry with content: "
      p b[c]
    else
      b.pop
      userinput(type)
    end

  end

  def self.print_all_entry
    clearscreen
    print "All Entries are as follows: \n\n"

    print "Record No." + " | " + "Date" + " | " + "Short Description" + " | " + "Long Description" + " | " + "Amount" + " | " + "Currency" + " | " + "Converted Amount" + " | "
    print "\n"
    for i in 0..(@@database.length-1)
      if @@database[i].status == "Active"
        print @@database[i].record.to_s + " | " + @@database[i].date.to_s + " | " + @@database[i].shortdes.to_s + " | " + @@database[i].longdes.to_s + " | " + @@database[i].amount.to_s + " | " + @@database[i].currency.to_s + " | " + @@database[i].con_amount.to_s + " | "
        print "\n"
      end
    end
    print "\n"
  end

  def self.delete_entry

    print <<EOF
Which entry would you like to delete?

1. Most recent entry
2. Enter entry number
3. View latest 30 entries

Please enter your option:
EOF

    input = gets.chomp.to_i

    case input
    when 1
      @@database.pop
    when 2
      print "Enter the entry number you wish to delete: "
      input = gets.chomp.to_i
      debug(input, "Value of input is: ")
      for i in 0..(@@database.length.to_i-1)
        if @@database[i].record.to_i == input
          @@database[i].status = "Deleted"
          debug(@@database[i].status, "Status of entry #{input} is now: ")
        end
      end


    when 3


    end



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
  if $debugging == true
    puts "=========================Debug is on==============================="
    puts ""
  end
end

def debug(var, *optional)
  if $debugging == true
    #print "Debug: #{optional} #{var}"
    print "######  Debug: #{optional[0]}"
    p var
  else
  end
end

def menu

print <<EOF

Menu:
  1. New Entry
  2. New Entry(Guided)
  3. View all Entry
  4. Delete an Entry

EOF

print "Please choose an option: "
  input = gets.chomp.to_i

  case input
  when 1 #New Entry
    Entry.userinput(1)
    menu
  when 2 #Guide Entry
    Entry.userinput(2)

    menu
  when 3 # View all Entry
    Entry.print_all_entry
    menu
  when 4
    Entry.delete_entry
    menu

  end

end

def main #Main Program Start

clearscreen

  print <<EOF
Hello there! Welcome to this budget tracker!
What would you like to do today?
EOF

  menu
  Entry.userinput






end

main

#Entry.print_all_entry

