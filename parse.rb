module Parse
  def cryptopia_get_currencies(results)
    values = []
    rows   = []
    results["Data"].each do |item|
      values.push(
        {
          values: [
            {
              user_entered_value: {number_value: item["Id"]}
            },
            {
              user_entered_value: {string_value: item["Name"]}
            },
            {
              user_entered_value: {string_value: item["Symbol"]}
            },
            {
              user_entered_value: {string_value: item["Algorithm"]}
            },
            {
              user_entered_value: {number_value: item["WithdrawFee"]}
            },
            {
              user_entered_value: {number_value: item["MinWithdraw"]}
            },
            {
              user_entered_value: {number_value: item["MaxWithdraw"]}
            },
            {
              user_entered_value: {number_value: item["MinBaseTrade"]}
            },
            {
              user_entered_value: {number_value: item["DepositConfirmations"]}
            },
            {
              user_entered_value: {string_value: item["ListingStatus"]}
            },
            {
              user_entered_value: {string_value: item["Status"]}
            },
            {
              user_entered_value: {string_value: item["StatusMessage"]}
            }
          ]
        }
      )
    end
    rows.push(values)
  end
  module_function :cryptopia_get_currencies
end
