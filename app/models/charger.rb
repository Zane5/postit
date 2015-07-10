class Charger < ActiveRecord::Base
	establish_connection(:pegasus_db)
	self.abstract_class = true
	self.table_name = 'xxrouter.merchant_charger_mail'

  # Prevent creation of new records and modification to existing records
  def readonly?
    return true
  end

	# Prevent objects from being destroyed
	def before_destroy
    raise ActiveRecord::ReadOnlyRecord
  end

  def self.delete_all
		raise ActiveRecord::ReadOnlyRecord
	end
	
	def delete
		raise ActiveRecord::ReadOnlyRecord
	end
	
end