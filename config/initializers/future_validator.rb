class FutureValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    if !value.nil?
      unless value >= Time.now
        record.errors.add(attr_name, :arrival_time, options.merge(value: value))
      end
    end
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_futureness_of(*attr_names)
    validates_with FutureValidator, _merge_attributes(attr_names)
  end
end
