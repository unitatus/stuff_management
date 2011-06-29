class CreditCard
  include Validatable
  
  attr_accessor :type, :number, :security_code, :expiration_month, :expiration_year

  validates_presence_of :type, :message => "Please select a type"
  validates_presence_of :number, :message => "Please enter a number"
  validates_presence_of :security_code, :message => "Please enter a security code"
  validates_presence_of :expiration_month, :message => "Please enter a two-digit month"
  validates_presence_of :expiration_year, :message => "Please enter a four-digit year"

  validates_numericality_of :number, :if => :number_populated
  validates_numericality_of :security_code, :if => :security_code_populated
  validates_numericality_of :expiration_month, :if => :exp_month_populated
  validates_numericality_of :expiration_year, :if => :exp_year_populated

  validates_length_of :number, :minimum => 16, :maximum => 16, :message => "Credit card number is incorrect length", :if => :number_populated
  validates_length_of :security_code, :minimum => 3, :maximum => 4, :message => "Please enter a security code from 3-4 digits", :if => :security_code_populated
  validates_length_of :expiration_month, :minimum => 2, :maximum => 2, :message => "Please enter a two-digit month", :if => :exp_month_populated
  validates_length_of :expiration_year, :minimum => 4, :maximum => 4, :message => "Please enter a four-digit year", :if => :exp_year_populated

  def number_populated
    !number.empty?
  end

  def security_code_populated
    !security_code.empty?
  end
  
  def exp_month_populated
    !expiration_month.empty?
  end

  def exp_year_populated
    !expiration_year.empty?
  end
end
