class Address < ActiveRecord::Base
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :day_phone, :presence => true
  validates :address_line_1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true
  validates_format_of :phone, :with => /^[0-9]{3,3}-[0-9]{3,3}-[0-9]{4,4}$/, :message => "Phone number format is not valid (xxx-xxx-xxxx)."

  def day_phone=(phone)
    @day_phone=convert_phone(phone)
  end

  def evening_phone=(phone)
    @day_phone=convert_phone(phone)
  end

  def convert_phone(phone)
    phone.gsub(/[^0-9]/, "").gsub(/^([0-9]{0,3})([0-9]{0,3})([0-9]{0,})$/) do |match|
      tmp = ""
      tmp += $1 if $1.size > 0
      tmp += "-" + $2 if $2.size > 0
      tmp += "-" + $3 if $3.size > 0
      tmp
    end
  end
end
