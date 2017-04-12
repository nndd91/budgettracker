$debug = true

class Entry
#Class Methods
  @@database = Array.new #Array to hold all entries
  attr_accessor :date, :shortdes, :longdes, :amount, :currency, :con_amount

  def self.all_instances #Return all entry
    @@database
    if $debug == true
      puts "Debug: #{@@database} \n"
    end
  end

  def self.print_all_entry
    for i in 0..(@@database.length-1)
      print @@database[i].date + " | " + @@database[i].shortdes + " | " + @@database[i].longdes + " | " + @@database[i].amount + " | " + @@database[i].currency + " | " + @@database[i].con_amount + " | "
      print "\n"
    end
  end


#Instance Method
  def initialize
    @date = "01/01/2017"
    @shortdes = "shortdes"
    @longdes = "longdes"
    @amount = "$0.00"
    @currency = "SGD"
    @con_amount = "$0.00"
    @@database << self
  end

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
end

def userinput
  input = gets.chomp
  p input
  array = input.split(',')
  p array


end

def main
#Main Program

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



end

main
userinput

