class CreditCard
  include Validatable
  
  attr_accessor :type, :number, :security_code, :expiration_month, :expiration_year

  validates_presence_of :number
  validates_presence_of :security_code
  validates_presence_of :expiration_month
  validates_presence_of :expiration_year

  validates_numericality_of :number
  validates_numericality_of :security_code
  validates_numericality_of :expiration_month
  validates_numericality_of :expiration_year
end
