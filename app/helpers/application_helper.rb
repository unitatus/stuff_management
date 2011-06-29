module ApplicationHelper
  def error_messages_for_attribute(object, attribute)
    if (object.kind_of? ActiveRecord::Base)
      error_messages = object.errors[attribute]
    else # assume validatable for now
      error_messages = object.errors.on(attribute)
    end
    if (error_messages)
      html = '<div class="error_label">'
      error_messages.each do |message|
        html += message + "<br>"
      end
      html += "</div>"
    end

    # By default html strings are escaped in rails. Use raw function to reverse that.
    raw html
  end

  def cc_types
    ['Select Card',
     'American Express',
     'Discover',
     'Mastercard',
     'Visa']
  end

  def states_array
    ['AK',
	'AL',
	'AR',
	'AZ',
	'CA',
	'CO',
	'CT',
	'DC',
	'DE',
	'FL',
	'GA',
	'HI',
	'IA',
	'ID',
	'IL',
	'IN',
	'KS',
	'KY',
	'LA',
	'MA',
	'MD',
	'ME',
	'MI',
	'MN',
	'MO',
	'MS',
	'MT',
	'NC',
	'ND',
	'NE',
	'NH',
	'NJ',
	'NM',
	'NV',
	'NY',
	'OH',
	'OK',
	'OR',
	'PA',
	'RI',
	'SC',
	'SD',
	'TN',
	'TX',
	'UT',
	'VA',
	'VT',
	'WA',
	'WI',
	'WV',
	'WY']
  end
end
