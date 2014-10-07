def assert_records_values(records, values)
  expect(records.length).to eq(values.count), "Expected <#{values.count}> number of records, got <#{records.count}>\n\nRecords:\n#{records.to_a}"
  records.each_with_index do |record, index|
    assert_record_values record, values[index], index: index
  end
end

def assert_record_values(record, values, index: nil)
  values.each do |field, value|
    record_value = [field].flatten.inject(record) { |object, method| object.try :send, method }
    record_value = record_value.to_s if (record_value.is_a? BigDecimal and value.is_a? String) or (record_value.is_a? Date and value.is_a? String)

    expect_string_or_regexp record_value, value,
                            "#{"(index #{index}) " if index}<#{field}> value expected to be <#{value.inspect}>. Got <#{record_value.inspect}>"
  end
end

def expect_string_or_regexp(value, expected, message = nil)
  if expected.is_a? String
    expect(value).to eq(expected), message
  else
    expect(value).to match(expected), message
  end
end
